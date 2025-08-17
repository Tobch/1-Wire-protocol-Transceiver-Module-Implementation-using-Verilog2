//------------------------------------------------------------------------------
// one_wire_rx.v
//------------------------------------------------------------------------------
module one_wire_rx (
    input              clk,
    input              rst_n,
    input              enable,
    inout              one_wire_data,
    output reg         presence_detect,
    output reg         rx_valid,
    output reg [7:0]   rx_byte
);

  
    localparam  T_PDL      = 60;   
    localparam  T_RDS      = 15;    
    localparam  CLK_MHZ    = 100;
    localparam  PDL_CYC    = T_PDL * CLK_MHZ;
    localparam  RDSAMP_CYC = T_RDS * CLK_MHZ;

    // Internal regs
    reg drive_low;               
    reg [31:0] pres_cnt;        
    reg [31:0] sample_cnt;       
    reg sampling;                 
    reg [2:0] bit_idx;            
    reg [7:0] shift_reg;         
    reg one_wire_sync0, one_wire_sync1; 
    wire one_wire_sync;          
    reg one_wire_prev;           
    wire falling_edge;
    reg sampled_bit;
    reg [7:0] new_shift;

  
    reg presence_done;

   
    assign one_wire_data = drive_low ? 1'b0 : 1'bz;

  
    // Synchronize the asynchronous bus input to our clock domain
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            one_wire_sync0 <= 1'b1;
            one_wire_sync1 <= 1'b1;
        end else begin
            one_wire_sync0 <= (one_wire_data === 1'b0) ? 1'b0 : 1'b1;
            one_wire_sync1 <= one_wire_sync0;
        end
    end
    assign one_wire_sync = one_wire_sync1;

 
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            one_wire_prev <= 1'b1;
        end else begin
            one_wire_prev <= one_wire_sync;
        end
    end
    assign falling_edge = (one_wire_prev == 1'b1 && one_wire_sync == 1'b0);

    
    // Main sequential logic: presence pulse generation, sample timer, bit capture
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            presence_detect <= 1'b0;
            drive_low       <= 1'b0;
            pres_cnt        <= 32'd0;
            sampling        <= 1'b0;
            sample_cnt      <= 32'd0;
            bit_idx         <= 3'd0;
            shift_reg       <= 8'd0;
            rx_byte         <= 8'd0;
            rx_valid        <= 1'b0;
            presence_done   <= 1'b0;
        end else begin
           
            rx_valid <= 1'b0;

            if (!enable) begin
                // idle when slave disabled
                drive_low       <= 1'b0;
                presence_detect <= 1'b0;
                pres_cnt        <= 32'd0;
                sampling        <= 1'b0;
                sample_cnt      <= 32'd0;
                bit_idx         <= 3'd0;
                shift_reg       <= 8'd0;
                presence_done   <= 1'b0;
            end else begin
                // If not yet done presence, detect master reset low and reply
                if (!presence_done) begin
                    if (one_wire_sync == 1'b0 && !drive_low) begin
                        // start presence response: drive low for PDL_CYC
                        drive_low <= 1'b1;
                        presence_detect <= 1'b1;
                        pres_cnt <= 32'd0;
                    end

                    // maintain presence pulse duration
                    if (drive_low) begin
                        if (pres_cnt >= PDL_CYC) begin
                            drive_low <= 1'b0;
                            presence_detect <= 1'b0;
                            pres_cnt <= 32'd0;
                            // mark that presence response finished — now real data slots may follow
                            presence_done <= 1'b1;
                            // ensure bit index and buffers ready
                            bit_idx <= 3'd0;
                            shift_reg <= 8'd0;
                        end else begin
                            pres_cnt <= pres_cnt + 1;
                        end
                    end
                end else begin
                    // presence_done == 1: normal data sampling permitted
                    if (falling_edge && !drive_low && !sampling) begin
                        sampling <= 1'b1;
                        sample_cnt <= 32'd0;
                    end

                    // If sampling, count and capture at RDSAMP_CYC
                    if (sampling) begin
                        if (sample_cnt >= RDSAMP_CYC) begin
                            // sample the synchronized bus: 0 => bit 0, else bit 1
                            sampled_bit = (one_wire_sync == 1'b1) ? 1'b1 : 1'b0;
                            new_shift = shift_reg;
                            if (sampled_bit)
                                new_shift = new_shift | (8'b1 << bit_idx);
                            else
                                new_shift = new_shift & ~(8'b1 << bit_idx);

                            shift_reg <= new_shift;

                            if (bit_idx == 3'd7) begin
                                // last bit captured -> publish byte and pulse rx_valid
                                rx_byte <= new_shift;
                                bit_idx <= 3'd0;
                                sampling <= 1'b0;
                                sample_cnt <= 32'd0;
                                rx_valid <= 1'b1;
                                shift_reg <= 8'd0;
                                // prepare for next frame: require a new reset/presence before sampling again
                                presence_done <= 1'b0;
                            end else begin
                                bit_idx <= bit_idx + 1;
                                sampling <= 1'b0;
                                sample_cnt <= 32'd0;
                            end
                        end else begin
                            sample_cnt <= sample_cnt + 1;
                        end
                    end
                end
            end
        end
    end

endmodule
