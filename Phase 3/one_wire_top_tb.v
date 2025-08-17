`timescale 1ns/1ps
module one_wire_top_tb;
    reg        clk = 0;
    reg        rst_n;
    reg        start;
    reg  [7:0] tx_byte;
    wire       tx_done;
    wire       rx_valid;
    wire [7:0] rx_byte;

    // 100 MHz clock
    always #5 clk = ~clk;

    one_wire_top uut (
        .clk      (clk),
        .rst_n    (rst_n),
        .start    (start),
        .tx_byte  (tx_byte),
        .tx_done  (tx_done),
        .rx_valid (rx_valid),
        .rx_byte  (rx_byte)
    );

    initial begin
        rst_n   = 1'b0;
        start   = 1'b0;
        tx_byte = 8'hA5;
        #20 rst_n = 1'b1;
        #20;

        // Start TX
        #10 start = 1'b1;
        #10 start = 1'b0;

        fork
            // Main check
            begin
                @(posedge rx_valid); // Wait until data ready
                #10; // Allow for data to settle
                if (rx_byte === 8'hA5) begin
                    $display("PASS: top-level TX->RX successful: 0x%0h", rx_byte);
                end else begin
                    $display("FAIL: top-level RX=0x%0h (expected 0x%0h)", rx_byte, tx_byte);
                end
                $stop;
            end

            // Timeout
            begin
                #5_000_000; // 5 ms
                $display("ERROR: TIMEOUT - rx_valid not seen within 5 ms");
                $stop;
            end
        join
    end
endmodule
