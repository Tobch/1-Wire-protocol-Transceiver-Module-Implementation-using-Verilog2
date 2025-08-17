// File: one_wire_top.v

module one_wire_top (
    input        clk,
    input        rst_n,
    input        start,       // start transmit from master
    input  [7:0] tx_byte,     // data to transmit
    output       tx_done,     // tx finished
    output       rx_valid,    // rx has valid byte
    output [7:0] rx_byte      // received byte
);

  
    wire one_wire_data;

    // Instantiate transmitter
    one_wire_tx tx_inst (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .tx_byte(tx_byte),
        .busy(),              
        .done(tx_done),
        .one_wire_data(one_wire_data)
    );

    // Instantiate receiver (slave)
    one_wire_rx rx_inst (
        .clk(clk),
        .rst_n(rst_n),
        .enable(1'b1),         // slave enabled
        .one_wire_data(one_wire_data),
        .presence_detect(),    
        .rx_valid(rx_valid),
        .rx_byte(rx_byte)
    );

endmodule