`timescale 1ns/1ps
//------------------------------------------------------------------------------
// File: one_wire_rx_tb.v (fixed recovery gap for write-0 slots)
//------------------------------------------------------------------------------
module one_wire_rx_tb;
    reg        clk = 0;
    reg        rst_n;
    reg        enable;
    reg        drive_master;
    wire       one_wire_data;
    wire       presence_detect;
    wire       rx_valid;
    wire [7:0] rx_byte;
    integer    i;

    // 100 MHz clock
    always #5 clk = ~clk;

    // Instantiate DUT
    one_wire_rx dut (
        .clk(clk),
        .rst_n(rst_n),
        .enable(enable),
        .one_wire_data(one_wire_data),
        .presence_detect(presence_detect),
        .rx_valid(rx_valid),
        .rx_byte(rx_byte)
    );

    // Simulate master pulling the line
    assign one_wire_data = drive_master ? 1'b0 : 1'bz;

    initial begin
        // Reset & init
        rst_n        = 1'b0;
        enable       = 1'b0;
        drive_master = 1'b0;
        #20 rst_n   = 1'b1;
        #20 enable  = 1'b1;

        // 480 µs reset pulse
        drive_master = 1'b1; #480_000;
        drive_master = 1'b0; #100_000;

        // Send 8 slots for 0xA5 (MSB first)
        for (i = 7; i >= 0; i = i - 1) begin
            if ((8'hA5 >> i) & 1) begin
                // Write-1 slot
                drive_master = 1'b1; #6_000;
                drive_master = 1'b0; #54_000;
            end else begin
                // Write-0 slot (with recovery gap)
                drive_master = 1'b1; #60_000;
                drive_master = 1'b0; #1_000;   // <-- important recovery delay
            end
        end

        // Wait for slave to finish
        #100_000;
        if (rx_byte == 8'hA5)
            $display("PASS: RX captured A5");
        else
            $display("FAIL: RX=0x%0h", rx_byte);

        $stop;
    end
endmodule
