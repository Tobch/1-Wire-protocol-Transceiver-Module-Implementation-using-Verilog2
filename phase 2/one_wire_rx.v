`timescale 1ns/1ps
//------------------------------------------------------------------------------
// one_wire_rx.v
// Robust One-Wire Receiver (slave) with falling-edge detection & sample timer.
// Fix: gate sampling until presence response is completed (presence_done).
// Assumes 100 MHz clock (1 cycle = 10 ns).
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

    // Timing (µs -> cycles @100 MHz)
    localparam integer T_PDL      = 60;    // presence low time (µs)
    localparam integer T_RDS      = 15;    // sample offset after falling edge (µs)
    localparam integer CLK_MHZ    = 100;
    localparam integer PDL_CYC    = T_PDL * CLK_MHZ;
    localparam integer RDSAMP_CYC = T_RDS * CLK_MHZ;

    // Internal regs
    reg drive_low;                // local drive for presence pulse
    reg [31:0] pres_cnt;          // presence pulse counter
    reg [31:0] sample_cnt;        // per-slot sample counter
    reg sampling;                 // sampling in progress
    reg [2:0] bit_idx;            // which bit to store next (0..7)
    reg [7:0] shift_reg;          // assembled bits (LSB-first)
    reg one_wire_sync0, one_wire_sync1; // two-stage synchronizer
    wire one_wire_sync;           // synchronized sampled bus (0 or 1)
    reg one_wire_prev;            // previous sampled value (for edge detect)
    wire falling_edge;
    reg sampled_bit;
    reg [7:0] new_shift;

    // NEW: only start sampling after presence response completed
    reg presence_done;

    // Tri-state control: when drive_low asserted, pull line low; otherwise float (z)
    assign one_wire_data = drive_low ? 1'b0 : 1'bz;

    // -------------------------------------------------------------------------
    // Synchronize the asynchronous bus input to our clock domain
    // Treat 'z' (and 'x') as logical 1 (pull-up behavior).
    // -------------------------------------------------------------------------
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

    // Falling edge detector: previous == 1 && current == 0
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            one_wire_prev <= 1'b1;
        end else begin
            one_wire_prev <= one_wire_sync;
        end
    end
    assign falling_edge = (one_wire_prev == 1'b1 && one_wire_sync == 1'b0);

    // -------------------------------------------------------------------------
    // Main sequential logic: presence pulse generation, sample timer, bit capture
    // Presence_done becomes 1 after we finish the presence pulse (so sampling
    // only begins on falling edges that occur after that).
    // -------------------------------------------------------------------------
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
            // default: deassert rx_valid (we pulse it when last bit captured)
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
                    // On falling edge of the bus (start of a time slot), begin sampling timer
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
