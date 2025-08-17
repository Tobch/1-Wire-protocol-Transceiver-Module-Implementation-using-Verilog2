//------------------------------------------------------------------------------
// one_wire_tx.v
// Description: 1-Wire Transmitter FSM (Master mode)
//------------------------------------------------------------------------------ 
module one_wire_tx (
    input        clk,
    input        rst_n,
    input        start,
    input  [7:0] tx_byte,
    output       busy,
    output       done,
    inout        one_wire_data
);

    // 1-Wire timing parameters 
    localparam T_RSTL = 480;
    localparam T_RSTH = 480;
    localparam T_PDH  = 15;
    localparam T_PDL  = 60;
    localparam T_SLOT = 60;
    localparam T_REC  = 1;
    localparam T_W1L  = 6;
    localparam T_W0L  = 60;


    localparam CLK_MHZ  = 100;
    localparam RSTL_CYC = T_RSTL * CLK_MHZ;
    localparam RSTH_CYC = T_RSTH * CLK_MHZ;
    localparam PDH_CYC  = T_PDH  * CLK_MHZ;
    localparam PDL_CYC  = T_PDL  * CLK_MHZ;
    localparam SLOT_CYC = T_SLOT * CLK_MHZ;
    localparam W1L_CYC  = T_W1L  * CLK_MHZ;
    localparam W0L_CYC  = T_W0L  * CLK_MHZ;
    localparam REC_CYC  = T_REC  * CLK_MHZ;

    // FSM states
    localparam S_IDLE       = 4'd0;
    localparam S_RST_LOW    = 4'd1;
    localparam S_RST_REL    = 4'd2;
    localparam S_PDH_WAIT   = 4'd3;
    localparam S_PDL_SAMPLE = 4'd4;
    localparam S_REC_WAIT   = 4'd5;
    localparam S_BIT_INIT   = 4'd6;
    localparam S_BIT_LOW    = 4'd7;
    localparam S_BIT_WAIT   = 4'd8;
    localparam S_BIT_REC    = 4'd9;
    localparam S_FINISH     = 4'd10;

    reg [3:0]  state, next_state;
    reg [31:0] cnt;
    reg [2:0]  bit_idx;
    reg        cur_bit;

    reg drive_low, next_drive_low;
    reg presence,  next_presence;

    // Drive the shared wire 
    assign one_wire_data = drive_low ? 1'b0 : 1'bz;
    assign busy = (state != S_IDLE && state != S_FINISH);
    assign done = (state == S_FINISH);

    // Sequential state, counters, and registers
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state     <= S_IDLE;
            cnt       <= 32'd0;
            bit_idx   <= 3'd0;
            cur_bit   <= 1'b0;
            drive_low <= 1'b0;
            presence  <= 1'b0;
        end else begin
            state     <= next_state;
            drive_low <= next_drive_low;
            presence  <= next_presence;

            // Counter logic
            if (state == next_state)
                cnt <= cnt + 1;
            else
                cnt <= 32'd0;

            // Capture bit at start of low phase
            if (state == S_BIT_LOW && cnt == 0)
                cur_bit <= tx_byte[bit_idx];  // LSB-first

            // Advance bit index
            if (state == S_BIT_REC && next_state == S_BIT_LOW)
                bit_idx <= bit_idx + 1;
            else if (state == S_BIT_INIT && next_state == S_BIT_LOW)
                bit_idx <= 0;
        end
    end

    // Combinational next-state logic
    always @(*) begin
        next_state     = state;
        next_drive_low = 1'b0;       // default: release bus
        next_presence  = presence;   // hold previous unless updated

        case (state)
            S_IDLE: if (start) next_state = S_RST_LOW;

            S_RST_LOW: begin
                next_drive_low = 1'b1;
                if (cnt >= RSTL_CYC) next_state = S_RST_REL;
            end

            S_RST_REL: if (cnt >= RSTH_CYC) next_state = S_PDH_WAIT;

            S_PDH_WAIT: if (cnt >= PDH_CYC) next_state = S_PDL_SAMPLE;

            S_PDL_SAMPLE: begin
                next_presence = (one_wire_data == 1'b0);
                next_state    = S_REC_WAIT;
            end

            S_REC_WAIT: if (cnt >= PDL_CYC + REC_CYC) next_state = S_BIT_INIT;

            S_BIT_INIT: next_state = S_BIT_LOW;

            S_BIT_LOW: begin
                next_drive_low = 1'b1;
                if ((cur_bit && cnt >= W1L_CYC) || (!cur_bit && cnt >= W0L_CYC))
                    next_state = S_BIT_WAIT;
            end

            S_BIT_WAIT: if (cnt >= SLOT_CYC) next_state = S_BIT_REC;

            S_BIT_REC: begin
                if (bit_idx == 3'd7)
                    next_state = S_FINISH;
                else
                    next_state = S_BIT_LOW;
            end

            S_FINISH: next_state = S_IDLE;
        endcase
    end

endmodule
