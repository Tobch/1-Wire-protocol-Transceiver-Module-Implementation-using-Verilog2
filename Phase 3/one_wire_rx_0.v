//
// Verilog description for cell one_wire_top, 
// 08/16/25 12:43:21
//
// LeonardoSpectrum Level 3, 2020a.2 
//


module one_wire_top ( clk, rst_n, start, tx_byte, tx_done, rx_valid, rx_byte ) ;

    input clk ;
    input rst_n ;
    input start ;
    input [7:0]tx_byte ;
    output tx_done ;
    output rx_valid ;
    output [7:0]rx_byte ;

    wire one_wire_data, PWR;
    wire [1:0] \$dummy ;




    one_wire_tx tx_inst (.clk (clk), .rst_n (rst_n), .start (start), .tx_byte ({
                tx_byte[7],tx_byte[6],tx_byte[5],tx_byte[4],tx_byte[3],
                tx_byte[2],tx_byte[1],tx_byte[0]}), .busy (\$dummy [0]), .done (
                tx_done), .one_wire_data (one_wire_data)) ;
    one_wire_rx rx_inst (.clk (clk), .rst_n (rst_n), .enable (PWR), .one_wire_data (
                one_wire_data), .presence_detect (\$dummy [1]), .rx_valid (
                rx_valid), .rx_byte ({rx_byte[7],rx_byte[6],rx_byte[5],
                rx_byte[4],rx_byte[3],rx_byte[2],rx_byte[1],rx_byte[0]})) ;
    CONZ1 ix76 (.X (PWR)) ;
endmodule


module one_wire_rx ( clk, rst_n, enable, one_wire_data, presence_detect, 
                     rx_valid, rx_byte ) ;

    input clk ;
    input rst_n ;
    input enable ;
    inout one_wire_data ;
    output presence_detect ;
    output rx_valid ;
    output [7:0]rx_byte ;

    wire sample_cnt_30, sample_cnt_29, sample_cnt_28, sample_cnt_27, 
         sample_cnt_26, sample_cnt_25, sample_cnt_24, sample_cnt_23, 
         sample_cnt_22, sample_cnt_21, sample_cnt_20, sample_cnt_19, 
         sample_cnt_18, sample_cnt_17, sample_cnt_16, sample_cnt_15, 
         sample_cnt_14, sample_cnt_13, sample_cnt_12, sample_cnt_11, 
         sample_cnt_10, sample_cnt_9, sample_cnt_8, sample_cnt_7, sample_cnt_6, 
         sample_cnt_5, sample_cnt_4, sample_cnt_3, sample_cnt_2, sample_cnt_1, 
         sample_cnt_0, pres_cnt_30, pres_cnt_29, pres_cnt_28, pres_cnt_27, 
         pres_cnt_26, pres_cnt_25, pres_cnt_24, pres_cnt_23, pres_cnt_22, 
         pres_cnt_21, pres_cnt_20, pres_cnt_19, pres_cnt_18, pres_cnt_17, 
         pres_cnt_16, pres_cnt_15, pres_cnt_14, pres_cnt_13, pres_cnt_12, 
         pres_cnt_11, pres_cnt_10, pres_cnt_9, pres_cnt_8, pres_cnt_7, 
         pres_cnt_6, pres_cnt_5, pres_cnt_4, pres_cnt_3, pres_cnt_2, pres_cnt_1, 
         pres_cnt_0, pres_cnt_r_30, pres_cnt_r_29, pres_cnt_r_28, pres_cnt_r_27, 
         pres_cnt_r_26, pres_cnt_r_25, pres_cnt_r_24, pres_cnt_r_23, 
         pres_cnt_r_22, pres_cnt_r_21, pres_cnt_r_20, pres_cnt_r_19, 
         pres_cnt_r_18, pres_cnt_r_17, pres_cnt_r_16, pres_cnt_r_15, 
         pres_cnt_r_14, pres_cnt_r_13, pres_cnt_r_12, pres_cnt_r_11, 
         pres_cnt_r_10, pres_cnt_r_9, pres_cnt_r_8, pres_cnt_r_7, pres_cnt_r_6, 
         pres_cnt_r_5, pres_cnt_r_4, pres_cnt_r_3, pres_cnt_r_2, pres_cnt_r_1, 
         pres_cnt_ix133_carry_31, pres_cnt_ix133_carry_30, 
         pres_cnt_ix133_carry_29, pres_cnt_ix133_carry_28, 
         pres_cnt_ix133_carry_27, pres_cnt_ix133_carry_26, 
         pres_cnt_ix133_carry_25, pres_cnt_ix133_carry_24, 
         pres_cnt_ix133_carry_23, pres_cnt_ix133_carry_22, 
         pres_cnt_ix133_carry_21, pres_cnt_ix133_carry_20, 
         pres_cnt_ix133_carry_19, pres_cnt_ix133_carry_18, 
         pres_cnt_ix133_carry_17, pres_cnt_ix133_carry_16, 
         pres_cnt_ix133_carry_15, pres_cnt_ix133_carry_14, 
         pres_cnt_ix133_carry_13, pres_cnt_ix133_carry_12, 
         pres_cnt_ix133_carry_11, pres_cnt_ix133_carry_10, 
         pres_cnt_ix133_carry_9, pres_cnt_ix133_carry_8, pres_cnt_ix133_carry_7, 
         pres_cnt_ix133_carry_6, pres_cnt_ix133_carry_5, pres_cnt_ix133_carry_4, 
         pres_cnt_ix133_carry_3, pres_cnt_ix133_carry_2, sample_cnt_r_30, 
         sample_cnt_r_29, sample_cnt_r_28, sample_cnt_r_27, sample_cnt_r_26, 
         sample_cnt_r_25, sample_cnt_r_24, sample_cnt_r_23, sample_cnt_r_22, 
         sample_cnt_r_21, sample_cnt_r_20, sample_cnt_r_19, sample_cnt_r_18, 
         sample_cnt_r_17, sample_cnt_r_16, sample_cnt_r_15, sample_cnt_r_14, 
         sample_cnt_r_13, sample_cnt_r_12, sample_cnt_r_11, sample_cnt_r_10, 
         sample_cnt_r_9, sample_cnt_r_8, sample_cnt_r_7, sample_cnt_r_6, 
         sample_cnt_r_5, sample_cnt_r_4, sample_cnt_r_3, sample_cnt_r_2, 
         sample_cnt_r_1, sample_cnt_ix133_carry_31, sample_cnt_ix133_carry_30, 
         sample_cnt_ix133_carry_29, sample_cnt_ix133_carry_28, 
         sample_cnt_ix133_carry_27, sample_cnt_ix133_carry_26, 
         sample_cnt_ix133_carry_25, sample_cnt_ix133_carry_24, 
         sample_cnt_ix133_carry_23, sample_cnt_ix133_carry_22, 
         sample_cnt_ix133_carry_21, sample_cnt_ix133_carry_20, 
         sample_cnt_ix133_carry_19, sample_cnt_ix133_carry_18, 
         sample_cnt_ix133_carry_17, sample_cnt_ix133_carry_16, 
         sample_cnt_ix133_carry_15, sample_cnt_ix133_carry_14, 
         sample_cnt_ix133_carry_13, sample_cnt_ix133_carry_12, 
         sample_cnt_ix133_carry_11, sample_cnt_ix133_carry_10, 
         sample_cnt_ix133_carry_9, sample_cnt_ix133_carry_8, 
         sample_cnt_ix133_carry_7, sample_cnt_ix133_carry_6, 
         sample_cnt_ix133_carry_5, sample_cnt_ix133_carry_4, 
         sample_cnt_ix133_carry_3, sample_cnt_ix133_carry_2, GND, presence_done, 
         sampling, nx6340, one_wire_sync, one_wire_sync0, nx28, nx6341, nx32, 
         pres_cnt_31, nx42, nx50, nx68, nx76, nx92, nx100, nx108, nx126, nx134, 
         nx152, nx160, nx168, nx186, nx194, nx210, nx218, nx226, nx244, nx252, 
         nx260, nx268, nx276, nx284, nx292, nx300, nx318, nx326, nx334, 
         NOT__2443, nx370, nx378, nx390, nx6342, nx392, nx398, nx402, nx410, 
         sample_cnt_31, nx420, nx428, nx446, nx454, nx462, nx482, nx490, nx498, 
         nx516, nx524, nx542, nx550, nx558, nx576, nx584, nx592, nx612, nx620, 
         nx628, nx646, nx654, nx662, nx670, nx678, nx686, nx694, nx702, nx720, 
         nx728, nx736, bit_idx_2, nx776, nx788, bit_idx_1, bit_idx_0, nx794, 
         nx804, nx814, nx836, nx846, nx856, nx862, nx866, nx884, nx892, nx902, 
         nx910, nx918, nx926, nx934, shift_reg_0, nx6344, nx942, nx946, 
         shift_reg_1, nx6345, nx974, shift_reg_2, nx6346, nx1002, shift_reg_3, 
         nx6347, nx1022, nx1040, shift_reg_4, nx6348, nx1048, nx1066, 
         shift_reg_5, nx6349, nx1074, nx1092, shift_reg_6, nx6350, nx1100, 
         shift_reg_7, nx6351, nx1120, nx6360, nx6362, nx6366, nx6379, nx6389, 
         nx6393, nx6395, nx6397, nx6403, nx6407, nx6412, nx6427, nx6444, nx6446, 
         nx6478, nx6483, nx6511, nx6519, nx6544, nx6573, nx6578, nx6605, nx6607, 
         nx6608, nx6611, nx6614, nx6619, nx6626, nx6650, nx6654, nx6663, nx6665, 
         nx6673, nx6675, nx6683, nx6685, nx6693, nx6702, nx6711, nx6720, nx6730, 
         nx6732, nx6738, nx6740;
    wire [82:0] \$dummy ;




    HA1A0 pres_cnt_ix133_D0_I0_dup_1523 (.S (pres_cnt_r_1), .CO (
          pres_cnt_ix133_carry_2), .A (pres_cnt_1), .B (pres_cnt_0)) ;
    HA1A0 pres_cnt_ix133_D0_I0_dup_1524 (.S (pres_cnt_r_2), .CO (
          pres_cnt_ix133_carry_3), .A (pres_cnt_2), .B (pres_cnt_ix133_carry_2)
          ) ;
    HA1A0 pres_cnt_ix133_D0_I0_dup_1525 (.S (pres_cnt_r_3), .CO (
          pres_cnt_ix133_carry_4), .A (pres_cnt_3), .B (pres_cnt_ix133_carry_3)
          ) ;
    HA1A0 pres_cnt_ix133_D0_I0_dup_1526 (.S (pres_cnt_r_4), .CO (
          pres_cnt_ix133_carry_5), .A (pres_cnt_4), .B (pres_cnt_ix133_carry_4)
          ) ;
    HA1A0 pres_cnt_ix133_D0_I0_dup_1527 (.S (pres_cnt_r_5), .CO (
          pres_cnt_ix133_carry_6), .A (pres_cnt_5), .B (pres_cnt_ix133_carry_5)
          ) ;
    HA1A0 pres_cnt_ix133_D0_I0_dup_1528 (.S (pres_cnt_r_6), .CO (
          pres_cnt_ix133_carry_7), .A (pres_cnt_6), .B (pres_cnt_ix133_carry_6)
          ) ;
    HA1A0 pres_cnt_ix133_D0_I0_dup_1529 (.S (pres_cnt_r_7), .CO (
          pres_cnt_ix133_carry_8), .A (pres_cnt_7), .B (pres_cnt_ix133_carry_7)
          ) ;
    HA1A0 pres_cnt_ix133_D0_I0_dup_1530 (.S (pres_cnt_r_8), .CO (
          pres_cnt_ix133_carry_9), .A (pres_cnt_8), .B (pres_cnt_ix133_carry_8)
          ) ;
    HA1A0 pres_cnt_ix133_D0_I0_dup_1531 (.S (pres_cnt_r_9), .CO (
          pres_cnt_ix133_carry_10), .A (pres_cnt_9), .B (pres_cnt_ix133_carry_9)
          ) ;
    HA1A0 pres_cnt_ix133_D0_I0_dup_1532 (.S (pres_cnt_r_10), .CO (
          pres_cnt_ix133_carry_11), .A (pres_cnt_10), .B (
          pres_cnt_ix133_carry_10)) ;
    HA1A0 pres_cnt_ix133_D0_I0_dup_1533 (.S (pres_cnt_r_11), .CO (
          pres_cnt_ix133_carry_12), .A (pres_cnt_11), .B (
          pres_cnt_ix133_carry_11)) ;
    HA1A0 pres_cnt_ix133_D0_I0_dup_1534 (.S (pres_cnt_r_12), .CO (
          pres_cnt_ix133_carry_13), .A (pres_cnt_12), .B (
          pres_cnt_ix133_carry_12)) ;
    HA1A0 pres_cnt_ix133_D0_I0_dup_1535 (.S (pres_cnt_r_13), .CO (
          pres_cnt_ix133_carry_14), .A (pres_cnt_13), .B (
          pres_cnt_ix133_carry_13)) ;
    HA1A0 pres_cnt_ix133_D0_I0_dup_1536 (.S (pres_cnt_r_14), .CO (
          pres_cnt_ix133_carry_15), .A (pres_cnt_14), .B (
          pres_cnt_ix133_carry_14)) ;
    HA1A0 pres_cnt_ix133_D0_I0_dup_1537 (.S (pres_cnt_r_15), .CO (
          pres_cnt_ix133_carry_16), .A (pres_cnt_15), .B (
          pres_cnt_ix133_carry_15)) ;
    HA1A0 pres_cnt_ix133_D0_I0_dup_1538 (.S (pres_cnt_r_16), .CO (
          pres_cnt_ix133_carry_17), .A (pres_cnt_16), .B (
          pres_cnt_ix133_carry_16)) ;
    HA1A0 pres_cnt_ix133_D0_I0_dup_1539 (.S (pres_cnt_r_17), .CO (
          pres_cnt_ix133_carry_18), .A (pres_cnt_17), .B (
          pres_cnt_ix133_carry_17)) ;
    HA1A0 pres_cnt_ix133_D0_I0_dup_1540 (.S (pres_cnt_r_18), .CO (
          pres_cnt_ix133_carry_19), .A (pres_cnt_18), .B (
          pres_cnt_ix133_carry_18)) ;
    HA1A0 pres_cnt_ix133_D0_I0_dup_1541 (.S (pres_cnt_r_19), .CO (
          pres_cnt_ix133_carry_20), .A (pres_cnt_19), .B (
          pres_cnt_ix133_carry_19)) ;
    HA1A0 pres_cnt_ix133_D0_I0_dup_1542 (.S (pres_cnt_r_20), .CO (
          pres_cnt_ix133_carry_21), .A (pres_cnt_20), .B (
          pres_cnt_ix133_carry_20)) ;
    HA1A0 pres_cnt_ix133_D0_I0_dup_1543 (.S (pres_cnt_r_21), .CO (
          pres_cnt_ix133_carry_22), .A (pres_cnt_21), .B (
          pres_cnt_ix133_carry_21)) ;
    HA1A0 pres_cnt_ix133_D0_I0_dup_1544 (.S (pres_cnt_r_22), .CO (
          pres_cnt_ix133_carry_23), .A (pres_cnt_22), .B (
          pres_cnt_ix133_carry_22)) ;
    HA1A0 pres_cnt_ix133_D0_I0_dup_1545 (.S (pres_cnt_r_23), .CO (
          pres_cnt_ix133_carry_24), .A (pres_cnt_23), .B (
          pres_cnt_ix133_carry_23)) ;
    HA1A0 pres_cnt_ix133_D0_I0_dup_1546 (.S (pres_cnt_r_24), .CO (
          pres_cnt_ix133_carry_25), .A (pres_cnt_24), .B (
          pres_cnt_ix133_carry_24)) ;
    HA1A0 pres_cnt_ix133_D0_I0_dup_1547 (.S (pres_cnt_r_25), .CO (
          pres_cnt_ix133_carry_26), .A (pres_cnt_25), .B (
          pres_cnt_ix133_carry_25)) ;
    HA1A0 pres_cnt_ix133_D0_I0_dup_1548 (.S (pres_cnt_r_26), .CO (
          pres_cnt_ix133_carry_27), .A (pres_cnt_26), .B (
          pres_cnt_ix133_carry_26)) ;
    HA1A0 pres_cnt_ix133_D0_I0_dup_1549 (.S (pres_cnt_r_27), .CO (
          pres_cnt_ix133_carry_28), .A (pres_cnt_27), .B (
          pres_cnt_ix133_carry_27)) ;
    HA1A0 pres_cnt_ix133_D0_I0_dup_1550 (.S (pres_cnt_r_28), .CO (
          pres_cnt_ix133_carry_29), .A (pres_cnt_28), .B (
          pres_cnt_ix133_carry_28)) ;
    HA1A0 pres_cnt_ix133_D0_I0_dup_1551 (.S (pres_cnt_r_29), .CO (
          pres_cnt_ix133_carry_30), .A (pres_cnt_29), .B (
          pres_cnt_ix133_carry_29)) ;
    HA1A0 pres_cnt_ix133_D0_I0_dup_1552 (.S (pres_cnt_r_30), .CO (
          pres_cnt_ix133_carry_31), .A (pres_cnt_30), .B (
          pres_cnt_ix133_carry_30)) ;
    HA1A0 sample_cnt_ix133_D0_I0_dup_1523 (.S (sample_cnt_r_1), .CO (
          sample_cnt_ix133_carry_2), .A (sample_cnt_1), .B (sample_cnt_0)) ;
    HA1A0 sample_cnt_ix133_D0_I0_dup_1524 (.S (sample_cnt_r_2), .CO (
          sample_cnt_ix133_carry_3), .A (sample_cnt_2), .B (
          sample_cnt_ix133_carry_2)) ;
    HA1A0 sample_cnt_ix133_D0_I0_dup_1525 (.S (sample_cnt_r_3), .CO (
          sample_cnt_ix133_carry_4), .A (sample_cnt_3), .B (
          sample_cnt_ix133_carry_3)) ;
    HA1A0 sample_cnt_ix133_D0_I0_dup_1526 (.S (sample_cnt_r_4), .CO (
          sample_cnt_ix133_carry_5), .A (sample_cnt_4), .B (
          sample_cnt_ix133_carry_4)) ;
    HA1A0 sample_cnt_ix133_D0_I0_dup_1527 (.S (sample_cnt_r_5), .CO (
          sample_cnt_ix133_carry_6), .A (sample_cnt_5), .B (
          sample_cnt_ix133_carry_5)) ;
    HA1A0 sample_cnt_ix133_D0_I0_dup_1528 (.S (sample_cnt_r_6), .CO (
          sample_cnt_ix133_carry_7), .A (sample_cnt_6), .B (
          sample_cnt_ix133_carry_6)) ;
    HA1A0 sample_cnt_ix133_D0_I0_dup_1529 (.S (sample_cnt_r_7), .CO (
          sample_cnt_ix133_carry_8), .A (sample_cnt_7), .B (
          sample_cnt_ix133_carry_7)) ;
    HA1A0 sample_cnt_ix133_D0_I0_dup_1530 (.S (sample_cnt_r_8), .CO (
          sample_cnt_ix133_carry_9), .A (sample_cnt_8), .B (
          sample_cnt_ix133_carry_8)) ;
    HA1A0 sample_cnt_ix133_D0_I0_dup_1531 (.S (sample_cnt_r_9), .CO (
          sample_cnt_ix133_carry_10), .A (sample_cnt_9), .B (
          sample_cnt_ix133_carry_9)) ;
    HA1A0 sample_cnt_ix133_D0_I0_dup_1532 (.S (sample_cnt_r_10), .CO (
          sample_cnt_ix133_carry_11), .A (sample_cnt_10), .B (
          sample_cnt_ix133_carry_10)) ;
    HA1A0 sample_cnt_ix133_D0_I0_dup_1533 (.S (sample_cnt_r_11), .CO (
          sample_cnt_ix133_carry_12), .A (sample_cnt_11), .B (
          sample_cnt_ix133_carry_11)) ;
    HA1A0 sample_cnt_ix133_D0_I0_dup_1534 (.S (sample_cnt_r_12), .CO (
          sample_cnt_ix133_carry_13), .A (sample_cnt_12), .B (
          sample_cnt_ix133_carry_12)) ;
    HA1A0 sample_cnt_ix133_D0_I0_dup_1535 (.S (sample_cnt_r_13), .CO (
          sample_cnt_ix133_carry_14), .A (sample_cnt_13), .B (
          sample_cnt_ix133_carry_13)) ;
    HA1A0 sample_cnt_ix133_D0_I0_dup_1536 (.S (sample_cnt_r_14), .CO (
          sample_cnt_ix133_carry_15), .A (sample_cnt_14), .B (
          sample_cnt_ix133_carry_14)) ;
    HA1A0 sample_cnt_ix133_D0_I0_dup_1537 (.S (sample_cnt_r_15), .CO (
          sample_cnt_ix133_carry_16), .A (sample_cnt_15), .B (
          sample_cnt_ix133_carry_15)) ;
    HA1A0 sample_cnt_ix133_D0_I0_dup_1538 (.S (sample_cnt_r_16), .CO (
          sample_cnt_ix133_carry_17), .A (sample_cnt_16), .B (
          sample_cnt_ix133_carry_16)) ;
    HA1A0 sample_cnt_ix133_D0_I0_dup_1539 (.S (sample_cnt_r_17), .CO (
          sample_cnt_ix133_carry_18), .A (sample_cnt_17), .B (
          sample_cnt_ix133_carry_17)) ;
    HA1A0 sample_cnt_ix133_D0_I0_dup_1540 (.S (sample_cnt_r_18), .CO (
          sample_cnt_ix133_carry_19), .A (sample_cnt_18), .B (
          sample_cnt_ix133_carry_18)) ;
    HA1A0 sample_cnt_ix133_D0_I0_dup_1541 (.S (sample_cnt_r_19), .CO (
          sample_cnt_ix133_carry_20), .A (sample_cnt_19), .B (
          sample_cnt_ix133_carry_19)) ;
    HA1A0 sample_cnt_ix133_D0_I0_dup_1542 (.S (sample_cnt_r_20), .CO (
          sample_cnt_ix133_carry_21), .A (sample_cnt_20), .B (
          sample_cnt_ix133_carry_20)) ;
    HA1A0 sample_cnt_ix133_D0_I0_dup_1543 (.S (sample_cnt_r_21), .CO (
          sample_cnt_ix133_carry_22), .A (sample_cnt_21), .B (
          sample_cnt_ix133_carry_21)) ;
    HA1A0 sample_cnt_ix133_D0_I0_dup_1544 (.S (sample_cnt_r_22), .CO (
          sample_cnt_ix133_carry_23), .A (sample_cnt_22), .B (
          sample_cnt_ix133_carry_22)) ;
    HA1A0 sample_cnt_ix133_D0_I0_dup_1545 (.S (sample_cnt_r_23), .CO (
          sample_cnt_ix133_carry_24), .A (sample_cnt_23), .B (
          sample_cnt_ix133_carry_23)) ;
    HA1A0 sample_cnt_ix133_D0_I0_dup_1546 (.S (sample_cnt_r_24), .CO (
          sample_cnt_ix133_carry_25), .A (sample_cnt_24), .B (
          sample_cnt_ix133_carry_24)) ;
    HA1A0 sample_cnt_ix133_D0_I0_dup_1547 (.S (sample_cnt_r_25), .CO (
          sample_cnt_ix133_carry_26), .A (sample_cnt_25), .B (
          sample_cnt_ix133_carry_25)) ;
    HA1A0 sample_cnt_ix133_D0_I0_dup_1548 (.S (sample_cnt_r_26), .CO (
          sample_cnt_ix133_carry_27), .A (sample_cnt_26), .B (
          sample_cnt_ix133_carry_26)) ;
    HA1A0 sample_cnt_ix133_D0_I0_dup_1549 (.S (sample_cnt_r_27), .CO (
          sample_cnt_ix133_carry_28), .A (sample_cnt_27), .B (
          sample_cnt_ix133_carry_27)) ;
    HA1A0 sample_cnt_ix133_D0_I0_dup_1550 (.S (sample_cnt_r_28), .CO (
          sample_cnt_ix133_carry_29), .A (sample_cnt_28), .B (
          sample_cnt_ix133_carry_28)) ;
    HA1A0 sample_cnt_ix133_D0_I0_dup_1551 (.S (sample_cnt_r_29), .CO (
          sample_cnt_ix133_carry_30), .A (sample_cnt_29), .B (
          sample_cnt_ix133_carry_29)) ;
    HA1A0 sample_cnt_ix133_D0_I0_dup_1552 (.S (sample_cnt_r_30), .CO (
          sample_cnt_ix133_carry_31), .A (sample_cnt_30), .B (
          sample_cnt_ix133_carry_30)) ;
    CONZ0 ix6201 (.X (GND)) ;
    OAOI1 ix371 (.X (nx370), .A1 (nx6360), .A2 (nx6626), .B (presence_detect), .C (
          nx6614)) ;
    OR8T0 ix6361 (.X (nx6360), .A1 (nx6362), .A2 (pres_cnt_28), .A3 (pres_cnt_27
          ), .A4 (pres_cnt_24), .A5 (pres_cnt_26), .A6 (pres_cnt_25), .A7 (
          pres_cnt_23), .A8 (pres_cnt_22)) ;
    OR3T0 ix6363 (.X (nx6362), .A1 (pres_cnt_29), .A2 (pres_cnt_31), .A3 (
          pres_cnt_30)) ;
    FD1I0 reg_pres_cnt_29 (.Q (pres_cnt_29), .XQ (\$dummy [0]), .D (nx32), .CK (
          clk), .EN (nx6732), .CL (rst_n)) ;
    AN2T0 ix33 (.X (nx32), .A1 (pres_cnt_r_29), .A2 (nx6366)) ;
    AOA4I0 ix29 (.X (nx28), .A1 (NOT__2443), .A2 (one_wire_sync), .B (
           presence_done), .C (enable)) ;
    FD1I0 reg_drive_low (.Q (presence_detect), .XQ (NOT__2443), .D (nx370), .CK (
          clk), .EN (nx378), .CL (rst_n)) ;
    FD1C2 reg_one_wire_sync1 (.Q (one_wire_sync), .XQ (\$dummy [1]), .D (
          one_wire_sync0), .CK (clk), .PR (rst_n)) ;
    FD1C0 reg_one_wire_sync0 (.Q (one_wire_sync0), .XQ (\$dummy [2]), .D (
          one_wire_data), .CK (clk), .PR (rst_n)) ;
    TS1R1 tri_one_wire_data (.X (one_wire_data), .A (GND), .C (NOT__2443)) ;
    AN2T0 ix867 (.X (nx866), .A1 (enable), .A2 (nx6379)) ;
    FD1I0 reg_presence_done (.Q (presence_done), .XQ (nx6379), .D (nx866), .CK (
          clk), .EN (nx862), .CL (rst_n)) ;
    OAI3R0 ix771 (.X (nx6342), .A1 (nx6389), .A2 (nx6427), .A3 (nx6444), .B (
           sampling)) ;
    OR6T0 ix6390 (.X (nx6389), .A1 (sample_cnt_29), .A2 (sample_cnt_31), .A3 (
          sample_cnt_30), .A4 (sample_cnt_26), .A5 (sample_cnt_28), .A6 (
          sample_cnt_27)) ;
    FD1I0 reg_sample_cnt_29 (.Q (sample_cnt_29), .XQ (\$dummy [3]), .D (nx410), 
          .CK (clk), .EN (nx6730), .CL (rst_n)) ;
    AN2T0 ix411 (.X (nx410), .A1 (sample_cnt_r_29), .A2 (nx6393)) ;
    NR2V1 ix6394 (.X (nx6393), .A1 (nx6395), .A2 (nx6397)) ;
    ND2N0 ix6396 (.X (nx6395), .A1 (enable), .A2 (nx6342)) ;
    OA1R0 ix403 (.X (nx402), .A1 (nx398), .A2 (nx390), .B (nx6730)) ;
    NR4R1 ix391 (.X (nx390), .A1 (one_wire_sync), .A2 (nx6403), .A3 (sampling), 
          .A4 (presence_detect)) ;
    FD1C0 reg_one_wire_prev (.Q (\$dummy [4]), .XQ (nx6403), .D (one_wire_sync)
          , .CK (clk), .PR (rst_n)) ;
    FD1I0 reg_sampling (.Q (sampling), .XQ (nx6397), .D (nx392), .CK (clk), .EN (
          nx402), .CL (rst_n)) ;
    AOA4I0 ix879 (.X (nx6340), .A1 (nx6407), .A2 (nx6397), .B (nx6379), .C (
           enable)) ;
    FD1I0 reg_sample_cnt_31 (.Q (sample_cnt_31), .XQ (\$dummy [5]), .D (nx420), 
          .CK (clk), .EN (nx6730), .CL (rst_n)) ;
    NR2R0 ix421 (.X (nx420), .A1 (nx6412), .A2 (nx398)) ;
    XN2R0 ix6413 (.X (nx6412), .A1 (sample_cnt_31), .A2 (
          sample_cnt_ix133_carry_31)) ;
    FD1I0 reg_sample_cnt_30 (.Q (sample_cnt_30), .XQ (\$dummy [6]), .D (nx428), 
          .CK (clk), .EN (nx6730), .CL (rst_n)) ;
    AN2T0 ix429 (.X (nx428), .A1 (sample_cnt_r_30), .A2 (nx6393)) ;
    FD1I0 reg_sample_cnt_26 (.Q (sample_cnt_26), .XQ (\$dummy [7]), .D (nx446), 
          .CK (clk), .EN (nx6730), .CL (rst_n)) ;
    AN2T0 ix447 (.X (nx446), .A1 (sample_cnt_r_26), .A2 (nx6393)) ;
    FD1I0 reg_sample_cnt_28 (.Q (sample_cnt_28), .XQ (\$dummy [8]), .D (nx454), 
          .CK (clk), .EN (nx6730), .CL (rst_n)) ;
    AN2T0 ix455 (.X (nx454), .A1 (sample_cnt_r_28), .A2 (nx6393)) ;
    FD1I0 reg_sample_cnt_27 (.Q (sample_cnt_27), .XQ (\$dummy [9]), .D (nx462), 
          .CK (clk), .EN (nx6730), .CL (rst_n)) ;
    AN2T0 ix463 (.X (nx462), .A1 (sample_cnt_r_27), .A2 (nx6393)) ;
    OR5T0 ix6428 (.X (nx6427), .A1 (sample_cnt_23), .A2 (sample_cnt_25), .A3 (
          sample_cnt_24), .A4 (sample_cnt_22), .A5 (sample_cnt_21)) ;
    FD1I0 reg_sample_cnt_23 (.Q (sample_cnt_23), .XQ (\$dummy [10]), .D (nx482)
          , .CK (clk), .EN (nx6730), .CL (rst_n)) ;
    AN2T0 ix483 (.X (nx482), .A1 (sample_cnt_r_23), .A2 (nx6393)) ;
    FD1I0 reg_sample_cnt_25 (.Q (sample_cnt_25), .XQ (\$dummy [11]), .D (nx490)
          , .CK (clk), .EN (nx6730), .CL (rst_n)) ;
    AN2T0 ix491 (.X (nx490), .A1 (sample_cnt_r_25), .A2 (nx6393)) ;
    FD1I0 reg_sample_cnt_24 (.Q (sample_cnt_24), .XQ (\$dummy [12]), .D (nx498)
          , .CK (clk), .EN (nx6730), .CL (rst_n)) ;
    AN2T0 ix499 (.X (nx498), .A1 (sample_cnt_r_24), .A2 (nx6393)) ;
    FD1I0 reg_sample_cnt_22 (.Q (sample_cnt_22), .XQ (\$dummy [13]), .D (nx516)
          , .CK (clk), .EN (nx6730), .CL (rst_n)) ;
    AN2T0 ix517 (.X (nx516), .A1 (sample_cnt_r_22), .A2 (nx6393)) ;
    FD1I0 reg_sample_cnt_21 (.Q (sample_cnt_21), .XQ (\$dummy [14]), .D (nx524)
          , .CK (clk), .EN (nx6730), .CL (rst_n)) ;
    AN2T0 ix525 (.X (nx524), .A1 (sample_cnt_r_21), .A2 (nx6393)) ;
    OR6T0 ix6445 (.X (nx6444), .A1 (nx6446), .A2 (sample_cnt_12), .A3 (
          sample_cnt_14), .A4 (sample_cnt_13), .A5 (sample_cnt_11), .A6 (nx6478)
          ) ;
    OR6T0 ix6447 (.X (nx6446), .A1 (sample_cnt_18), .A2 (sample_cnt_20), .A3 (
          sample_cnt_19), .A4 (sample_cnt_15), .A5 (sample_cnt_17), .A6 (
          sample_cnt_16)) ;
    FD1I0 reg_sample_cnt_18 (.Q (sample_cnt_18), .XQ (\$dummy [15]), .D (nx542)
          , .CK (clk), .EN (nx6730), .CL (rst_n)) ;
    AN2T0 ix543 (.X (nx542), .A1 (sample_cnt_r_18), .A2 (nx6393)) ;
    FD1I0 reg_sample_cnt_20 (.Q (sample_cnt_20), .XQ (\$dummy [16]), .D (nx550)
          , .CK (clk), .EN (nx6730), .CL (rst_n)) ;
    AN2T0 ix551 (.X (nx550), .A1 (sample_cnt_r_20), .A2 (nx6393)) ;
    FD1I0 reg_sample_cnt_19 (.Q (sample_cnt_19), .XQ (\$dummy [17]), .D (nx558)
          , .CK (clk), .EN (nx6730), .CL (rst_n)) ;
    AN2T0 ix559 (.X (nx558), .A1 (sample_cnt_r_19), .A2 (nx6393)) ;
    FD1I0 reg_sample_cnt_15 (.Q (sample_cnt_15), .XQ (\$dummy [18]), .D (nx576)
          , .CK (clk), .EN (nx6730), .CL (rst_n)) ;
    AN2T0 ix577 (.X (nx576), .A1 (sample_cnt_r_15), .A2 (nx6393)) ;
    FD1I0 reg_sample_cnt_17 (.Q (sample_cnt_17), .XQ (\$dummy [19]), .D (nx584)
          , .CK (clk), .EN (nx6730), .CL (rst_n)) ;
    AN2T0 ix585 (.X (nx584), .A1 (sample_cnt_r_17), .A2 (nx6393)) ;
    FD1I0 reg_sample_cnt_16 (.Q (sample_cnt_16), .XQ (\$dummy [20]), .D (nx592)
          , .CK (clk), .EN (nx6730), .CL (rst_n)) ;
    AN2T0 ix593 (.X (nx592), .A1 (sample_cnt_r_16), .A2 (nx6393)) ;
    FD1I0 reg_sample_cnt_12 (.Q (sample_cnt_12), .XQ (\$dummy [21]), .D (nx612)
          , .CK (clk), .EN (nx6730), .CL (rst_n)) ;
    AN2T0 ix613 (.X (nx612), .A1 (sample_cnt_r_12), .A2 (nx6393)) ;
    FD1I0 reg_sample_cnt_14 (.Q (sample_cnt_14), .XQ (\$dummy [22]), .D (nx620)
          , .CK (clk), .EN (nx6730), .CL (rst_n)) ;
    AN2T0 ix621 (.X (nx620), .A1 (sample_cnt_r_14), .A2 (nx6393)) ;
    FD1I0 reg_sample_cnt_13 (.Q (sample_cnt_13), .XQ (\$dummy [23]), .D (nx628)
          , .CK (clk), .EN (nx6730), .CL (rst_n)) ;
    AN2T0 ix629 (.X (nx628), .A1 (sample_cnt_r_13), .A2 (nx6393)) ;
    FD1I0 reg_sample_cnt_11 (.Q (sample_cnt_11), .XQ (\$dummy [24]), .D (nx646)
          , .CK (clk), .EN (nx6730), .CL (rst_n)) ;
    AN2T0 ix647 (.X (nx646), .A1 (sample_cnt_r_11), .A2 (nx6393)) ;
    OA1R0 ix6479 (.X (nx6478), .A1 (sample_cnt_9), .A2 (nx6483), .B (
          sample_cnt_10)) ;
    FD1I0 reg_sample_cnt_9 (.Q (sample_cnt_9), .XQ (\$dummy [25]), .D (nx662), .CK (
          clk), .EN (nx6730), .CL (rst_n)) ;
    AN2T0 ix663 (.X (nx662), .A1 (sample_cnt_r_9), .A2 (nx6393)) ;
    FD1I0 reg_sample_cnt_7 (.Q (sample_cnt_7), .XQ (\$dummy [26]), .D (nx736), .CK (
          clk), .EN (nx6730), .CL (rst_n)) ;
    AN2T0 ix737 (.X (nx736), .A1 (sample_cnt_r_7), .A2 (nx6393)) ;
    FD1I0 reg_sample_cnt_8 (.Q (sample_cnt_8), .XQ (\$dummy [27]), .D (nx728), .CK (
          clk), .EN (nx6730), .CL (rst_n)) ;
    AN2T0 ix729 (.X (nx728), .A1 (sample_cnt_r_8), .A2 (nx6393)) ;
    AO3I0 ix721 (.X (nx720), .A1 (sample_cnt_3), .A2 (sample_cnt_4), .A3 (
          sample_cnt_2), .B (sample_cnt_5)) ;
    FD1I0 reg_sample_cnt_3 (.Q (sample_cnt_3), .XQ (\$dummy [28]), .D (nx702), .CK (
          clk), .EN (nx6730), .CL (rst_n)) ;
    AN2T0 ix703 (.X (nx702), .A1 (sample_cnt_r_3), .A2 (nx6393)) ;
    FD1I0 reg_sample_cnt_4 (.Q (sample_cnt_4), .XQ (\$dummy [29]), .D (nx694), .CK (
          clk), .EN (nx6730), .CL (rst_n)) ;
    AN2T0 ix695 (.X (nx694), .A1 (sample_cnt_r_4), .A2 (nx6393)) ;
    FD1I0 reg_sample_cnt_2 (.Q (sample_cnt_2), .XQ (\$dummy [30]), .D (nx686), .CK (
          clk), .EN (nx6730), .CL (rst_n)) ;
    AN2T0 ix687 (.X (nx686), .A1 (sample_cnt_r_2), .A2 (nx6393)) ;
    FD1I0 reg_sample_cnt_5 (.Q (sample_cnt_5), .XQ (\$dummy [31]), .D (nx678), .CK (
          clk), .EN (nx6730), .CL (rst_n)) ;
    AN2T0 ix679 (.X (nx678), .A1 (sample_cnt_r_5), .A2 (nx6393)) ;
    FD1I0 reg_sample_cnt_6 (.Q (sample_cnt_6), .XQ (\$dummy [32]), .D (nx670), .CK (
          clk), .EN (nx6730), .CL (rst_n)) ;
    AN2T0 ix671 (.X (nx670), .A1 (sample_cnt_r_6), .A2 (nx6393)) ;
    FD1I0 reg_sample_cnt_10 (.Q (sample_cnt_10), .XQ (\$dummy [33]), .D (nx654)
          , .CK (clk), .EN (nx6730), .CL (rst_n)) ;
    AN2T0 ix655 (.X (nx654), .A1 (sample_cnt_r_10), .A2 (nx6393)) ;
    FD1I0 reg_bit_idx_1 (.Q (bit_idx_1), .XQ (nx6607), .D (nx814), .CK (clk), .EN (
          nx788), .CL (rst_n)) ;
    AO2L0 ix815 (.X (nx814), .A1 (bit_idx_1), .A2 (bit_idx_0), .B1 (nx804), .B2 (
          nx776)) ;
    FD1I0 reg_bit_idx_0 (.Q (bit_idx_0), .XQ (nx6605), .D (nx794), .CK (clk), .EN (
          nx788), .CL (rst_n)) ;
    NR2R0 ix795 (.X (nx794), .A1 (bit_idx_0), .A2 (nx776)) ;
    ND2N0 ix777 (.X (nx776), .A1 (presence_done), .A2 (enable)) ;
    MX2T2 ix789 (.X (nx788), .A (nx6519), .B (nx6395), .S (nx776)) ;
    FD1I0 reg_pres_cnt_28 (.Q (pres_cnt_28), .XQ (\$dummy [34]), .D (nx68), .CK (
          clk), .EN (nx6732), .CL (rst_n)) ;
    AN2T0 ix69 (.X (nx68), .A1 (pres_cnt_r_28), .A2 (nx6366)) ;
    FD1I0 reg_pres_cnt_27 (.Q (pres_cnt_27), .XQ (\$dummy [35]), .D (nx76), .CK (
          clk), .EN (nx6732), .CL (rst_n)) ;
    AN2T0 ix77 (.X (nx76), .A1 (pres_cnt_r_27), .A2 (nx6366)) ;
    FD1I0 reg_pres_cnt_24 (.Q (pres_cnt_24), .XQ (\$dummy [36]), .D (nx92), .CK (
          clk), .EN (nx6732), .CL (rst_n)) ;
    AN2T0 ix93 (.X (nx92), .A1 (pres_cnt_r_24), .A2 (nx6366)) ;
    FD1I0 reg_pres_cnt_26 (.Q (pres_cnt_26), .XQ (\$dummy [37]), .D (nx100), .CK (
          clk), .EN (nx6732), .CL (rst_n)) ;
    AN2T0 ix101 (.X (nx100), .A1 (pres_cnt_r_26), .A2 (nx6366)) ;
    FD1I0 reg_pres_cnt_25 (.Q (pres_cnt_25), .XQ (\$dummy [38]), .D (nx108), .CK (
          clk), .EN (nx6732), .CL (rst_n)) ;
    AN2T0 ix109 (.X (nx108), .A1 (pres_cnt_r_25), .A2 (nx6366)) ;
    FD1I0 reg_pres_cnt_23 (.Q (pres_cnt_23), .XQ (\$dummy [39]), .D (nx126), .CK (
          clk), .EN (nx6732), .CL (rst_n)) ;
    AN2T0 ix127 (.X (nx126), .A1 (pres_cnt_r_23), .A2 (nx6366)) ;
    FD1I0 reg_pres_cnt_22 (.Q (pres_cnt_22), .XQ (\$dummy [40]), .D (nx134), .CK (
          clk), .EN (nx6732), .CL (rst_n)) ;
    AN2T0 ix135 (.X (nx134), .A1 (pres_cnt_r_22), .A2 (nx6366)) ;
    OR3T0 ix6545 (.X (nx6544), .A1 (pres_cnt_19), .A2 (pres_cnt_21), .A3 (
          pres_cnt_20)) ;
    FD1I0 reg_pres_cnt_19 (.Q (pres_cnt_19), .XQ (\$dummy [41]), .D (nx152), .CK (
          clk), .EN (nx6732), .CL (rst_n)) ;
    AN2T0 ix153 (.X (nx152), .A1 (pres_cnt_r_19), .A2 (nx6366)) ;
    FD1I0 reg_pres_cnt_21 (.Q (pres_cnt_21), .XQ (\$dummy [42]), .D (nx160), .CK (
          clk), .EN (nx6732), .CL (rst_n)) ;
    AN2T0 ix161 (.X (nx160), .A1 (pres_cnt_r_21), .A2 (nx6366)) ;
    FD1I0 reg_pres_cnt_20 (.Q (pres_cnt_20), .XQ (\$dummy [43]), .D (nx168), .CK (
          clk), .EN (nx6732), .CL (rst_n)) ;
    AN2T0 ix169 (.X (nx168), .A1 (pres_cnt_r_20), .A2 (nx6366)) ;
    FD1I0 reg_pres_cnt_18 (.Q (pres_cnt_18), .XQ (\$dummy [44]), .D (nx186), .CK (
          clk), .EN (nx6732), .CL (rst_n)) ;
    AN2T0 ix187 (.X (nx186), .A1 (pres_cnt_r_18), .A2 (nx6366)) ;
    FD1I0 reg_pres_cnt_17 (.Q (pres_cnt_17), .XQ (\$dummy [45]), .D (nx194), .CK (
          clk), .EN (nx6732), .CL (rst_n)) ;
    AN2T0 ix195 (.X (nx194), .A1 (pres_cnt_r_17), .A2 (nx6366)) ;
    FD1I0 reg_pres_cnt_14 (.Q (pres_cnt_14), .XQ (\$dummy [46]), .D (nx210), .CK (
          clk), .EN (nx6732), .CL (rst_n)) ;
    AN2T0 ix211 (.X (nx210), .A1 (pres_cnt_r_14), .A2 (nx6366)) ;
    FD1I0 reg_pres_cnt_16 (.Q (pres_cnt_16), .XQ (\$dummy [47]), .D (nx218), .CK (
          clk), .EN (nx6732), .CL (rst_n)) ;
    AN2T0 ix219 (.X (nx218), .A1 (pres_cnt_r_16), .A2 (nx6366)) ;
    FD1I0 reg_pres_cnt_15 (.Q (pres_cnt_15), .XQ (\$dummy [48]), .D (nx226), .CK (
          clk), .EN (nx6732), .CL (rst_n)) ;
    AN2T0 ix227 (.X (nx226), .A1 (pres_cnt_r_15), .A2 (nx6366)) ;
    FD1I0 reg_pres_cnt_13 (.Q (pres_cnt_13), .XQ (\$dummy [49]), .D (nx244), .CK (
          clk), .EN (nx6732), .CL (rst_n)) ;
    AN2T0 ix245 (.X (nx244), .A1 (pres_cnt_r_13), .A2 (nx6366)) ;
    OA1R0 ix6574 (.X (nx6573), .A1 (pres_cnt_11), .A2 (nx6578), .B (pres_cnt_12)
          ) ;
    FD1I0 reg_pres_cnt_11 (.Q (pres_cnt_11), .XQ (\$dummy [50]), .D (nx260), .CK (
          clk), .EN (nx6732), .CL (rst_n)) ;
    AN2T0 ix261 (.X (nx260), .A1 (pres_cnt_r_11), .A2 (nx6366)) ;
    FD1I0 reg_pres_cnt_9 (.Q (pres_cnt_9), .XQ (\$dummy [51]), .D (nx334), .CK (
          clk), .EN (nx6732), .CL (rst_n)) ;
    AN2T0 ix335 (.X (nx334), .A1 (pres_cnt_r_9), .A2 (nx6366)) ;
    FD1I0 reg_pres_cnt_10 (.Q (pres_cnt_10), .XQ (\$dummy [52]), .D (nx326), .CK (
          clk), .EN (nx6732), .CL (rst_n)) ;
    AN2T0 ix327 (.X (nx326), .A1 (pres_cnt_r_10), .A2 (nx6366)) ;
    AO3I0 ix319 (.X (nx318), .A1 (pres_cnt_5), .A2 (pres_cnt_6), .A3 (pres_cnt_4
          ), .B (pres_cnt_7)) ;
    FD1I0 reg_pres_cnt_5 (.Q (pres_cnt_5), .XQ (\$dummy [53]), .D (nx300), .CK (
          clk), .EN (nx6732), .CL (rst_n)) ;
    AN2T0 ix301 (.X (nx300), .A1 (pres_cnt_r_5), .A2 (nx6366)) ;
    FD1I0 reg_pres_cnt_6 (.Q (pres_cnt_6), .XQ (\$dummy [54]), .D (nx292), .CK (
          clk), .EN (nx6732), .CL (rst_n)) ;
    AN2T0 ix293 (.X (nx292), .A1 (pres_cnt_r_6), .A2 (nx6366)) ;
    FD1I0 reg_pres_cnt_4 (.Q (pres_cnt_4), .XQ (\$dummy [55]), .D (nx284), .CK (
          clk), .EN (nx6732), .CL (rst_n)) ;
    AN2T0 ix285 (.X (nx284), .A1 (pres_cnt_r_4), .A2 (nx6366)) ;
    FD1I0 reg_pres_cnt_7 (.Q (pres_cnt_7), .XQ (\$dummy [56]), .D (nx276), .CK (
          clk), .EN (nx6732), .CL (rst_n)) ;
    AN2T0 ix277 (.X (nx276), .A1 (pres_cnt_r_7), .A2 (nx6366)) ;
    FD1I0 reg_pres_cnt_8 (.Q (pres_cnt_8), .XQ (\$dummy [57]), .D (nx268), .CK (
          clk), .EN (nx6732), .CL (rst_n)) ;
    AN2T0 ix269 (.X (nx268), .A1 (pres_cnt_r_8), .A2 (nx6366)) ;
    FD1I0 reg_pres_cnt_12 (.Q (pres_cnt_12), .XQ (\$dummy [58]), .D (nx252), .CK (
          clk), .EN (nx6732), .CL (rst_n)) ;
    AN2T0 ix253 (.X (nx252), .A1 (pres_cnt_r_12), .A2 (nx6366)) ;
    NR2R0 ix837 (.X (nx836), .A1 (nx776), .A2 (nx6611)) ;
    FD1I0 reg_bit_idx_2 (.Q (bit_idx_2), .XQ (nx6608), .D (nx836), .CK (clk), .EN (
          nx788), .CL (rst_n)) ;
    IV1N0 ix6615 (.X (nx6614), .A (enable)) ;
    FD1I0 reg_pres_cnt_31 (.Q (pres_cnt_31), .XQ (\$dummy [59]), .D (nx42), .CK (
          clk), .EN (nx6732), .CL (rst_n)) ;
    NR2R0 ix43 (.X (nx42), .A1 (nx6619), .A2 (nx6341)) ;
    XN2R0 ix6620 (.X (nx6619), .A1 (pres_cnt_31), .A2 (pres_cnt_ix133_carry_31)
          ) ;
    ND2N0 ix377 (.X (nx6341), .A1 (nx370), .A2 (presence_detect)) ;
    FD1I0 reg_pres_cnt_30 (.Q (pres_cnt_30), .XQ (\$dummy [60]), .D (nx50), .CK (
          clk), .EN (nx6732), .CL (rst_n)) ;
    AN2T0 ix51 (.X (nx50), .A1 (pres_cnt_r_30), .A2 (nx6366)) ;
    OR8T0 ix6627 (.X (nx6626), .A1 (nx6544), .A2 (pres_cnt_18), .A3 (pres_cnt_17
          ), .A4 (pres_cnt_14), .A5 (pres_cnt_16), .A6 (pres_cnt_15), .A7 (
          pres_cnt_13), .A8 (nx6573)) ;
    FD1I0 reg_pres_cnt_0 (.Q (pres_cnt_0), .XQ (\$dummy [61]), .D (nx902), .CK (
          clk), .EN (nx6732), .CL (rst_n)) ;
    NR2R0 ix903 (.X (nx902), .A1 (pres_cnt_0), .A2 (nx6341)) ;
    FD1I0 reg_pres_cnt_1 (.Q (pres_cnt_1), .XQ (\$dummy [62]), .D (nx910), .CK (
          clk), .EN (nx6732), .CL (rst_n)) ;
    AN2T0 ix911 (.X (nx910), .A1 (pres_cnt_r_1), .A2 (nx6366)) ;
    FD1I0 reg_pres_cnt_2 (.Q (pres_cnt_2), .XQ (\$dummy [63]), .D (nx918), .CK (
          clk), .EN (nx6732), .CL (rst_n)) ;
    AN2T0 ix919 (.X (nx918), .A1 (pres_cnt_r_2), .A2 (nx6366)) ;
    FD1I0 reg_pres_cnt_3 (.Q (pres_cnt_3), .XQ (\$dummy [64]), .D (nx926), .CK (
          clk), .EN (nx6732), .CL (rst_n)) ;
    AN2T0 ix927 (.X (nx926), .A1 (pres_cnt_r_3), .A2 (nx6366)) ;
    FD1I0 reg_sample_cnt_0 (.Q (sample_cnt_0), .XQ (\$dummy [65]), .D (nx884), .CK (
          clk), .EN (nx6730), .CL (rst_n)) ;
    NR2R0 ix885 (.X (nx884), .A1 (sample_cnt_0), .A2 (nx398)) ;
    FD1I0 reg_sample_cnt_1 (.Q (sample_cnt_1), .XQ (\$dummy [66]), .D (nx892), .CK (
          clk), .EN (nx6730), .CL (rst_n)) ;
    AN2T0 ix893 (.X (nx892), .A1 (sample_cnt_r_1), .A2 (nx6393)) ;
    FD1I0 reg_rx_byte_0 (.Q (rx_byte[0]), .XQ (\$dummy [67]), .D (nx6344), .CK (
          clk), .EN (nx856), .CL (rst_n)) ;
    FD1I0 reg_shift_reg_0 (.Q (shift_reg_0), .XQ (\$dummy [68]), .D (nx946), .CK (
          clk), .EN (nx788), .CL (rst_n)) ;
    NR2R0 ix947 (.X (nx946), .A1 (nx6650), .A2 (nx942)) ;
    MX2L0 ix6651 (.X (nx6650), .A (shift_reg_0), .B (one_wire_sync), .S (nx934)
          ) ;
    ND2N0 ix935 (.X (nx934), .A1 (nx804), .A2 (nx6608)) ;
    OR2T0 ix943 (.X (nx942), .A1 (nx776), .A2 (nx6654)) ;
    NR2R1 ix6655 (.X (nx6654), .A1 (nx6511), .A2 (nx6608)) ;
    NR3R2 ix857 (.X (nx856), .A1 (nx6342), .A2 (nx846), .A3 (nx776)) ;
    FD1I0 reg_rx_byte_1 (.Q (rx_byte[1]), .XQ (\$dummy [69]), .D (nx6345), .CK (
          clk), .EN (nx856), .CL (rst_n)) ;
    FD1I0 reg_shift_reg_1 (.Q (shift_reg_1), .XQ (\$dummy [70]), .D (nx974), .CK (
          clk), .EN (nx788), .CL (rst_n)) ;
    NR2R0 ix975 (.X (nx974), .A1 (nx6663), .A2 (nx942)) ;
    MX2L0 ix6664 (.X (nx6663), .A (one_wire_sync), .B (shift_reg_1), .S (nx6665)
          ) ;
    FD1I0 reg_rx_byte_2 (.Q (rx_byte[2]), .XQ (\$dummy [71]), .D (nx6346), .CK (
          clk), .EN (nx856), .CL (rst_n)) ;
    FD1I0 reg_shift_reg_2 (.Q (shift_reg_2), .XQ (\$dummy [72]), .D (nx1002), .CK (
          clk), .EN (nx788), .CL (rst_n)) ;
    NR2R0 ix1003 (.X (nx1002), .A1 (nx6673), .A2 (nx942)) ;
    MX2L0 ix6674 (.X (nx6673), .A (one_wire_sync), .B (shift_reg_2), .S (nx6675)
          ) ;
    FD1I0 reg_rx_byte_3 (.Q (rx_byte[3]), .XQ (\$dummy [73]), .D (nx6347), .CK (
          clk), .EN (nx856), .CL (rst_n)) ;
    FD1I0 reg_shift_reg_3 (.Q (shift_reg_3), .XQ (\$dummy [74]), .D (nx1022), .CK (
          clk), .EN (nx788), .CL (rst_n)) ;
    NR2R0 ix1023 (.X (nx1022), .A1 (nx6683), .A2 (nx942)) ;
    MX2L0 ix6684 (.X (nx6683), .A (one_wire_sync), .B (shift_reg_3), .S (nx6685)
          ) ;
    NR2R0 ix6686 (.X (nx6685), .A1 (nx6511), .A2 (bit_idx_2)) ;
    FD1I0 reg_rx_byte_4 (.Q (rx_byte[4]), .XQ (\$dummy [75]), .D (nx6348), .CK (
          clk), .EN (nx856), .CL (rst_n)) ;
    FD1I0 reg_shift_reg_4 (.Q (shift_reg_4), .XQ (\$dummy [76]), .D (nx1048), .CK (
          clk), .EN (nx788), .CL (rst_n)) ;
    NR2R0 ix1049 (.X (nx1048), .A1 (nx6693), .A2 (nx942)) ;
    MX2L0 ix6694 (.X (nx6693), .A (shift_reg_4), .B (one_wire_sync), .S (nx1040)
          ) ;
    ND2N0 ix1041 (.X (nx1040), .A1 (nx804), .A2 (bit_idx_2)) ;
    FD1I0 reg_rx_byte_5 (.Q (rx_byte[5]), .XQ (\$dummy [77]), .D (nx6349), .CK (
          clk), .EN (nx856), .CL (rst_n)) ;
    FD1I0 reg_shift_reg_5 (.Q (shift_reg_5), .XQ (\$dummy [78]), .D (nx1074), .CK (
          clk), .EN (nx788), .CL (rst_n)) ;
    NR2R0 ix1075 (.X (nx1074), .A1 (nx6702), .A2 (nx942)) ;
    MX2L0 ix6703 (.X (nx6702), .A (shift_reg_5), .B (one_wire_sync), .S (nx1066)
          ) ;
    FD1I0 reg_rx_byte_6 (.Q (rx_byte[6]), .XQ (\$dummy [79]), .D (nx6350), .CK (
          clk), .EN (nx856), .CL (rst_n)) ;
    FD1I0 reg_shift_reg_6 (.Q (shift_reg_6), .XQ (\$dummy [80]), .D (nx1100), .CK (
          clk), .EN (nx788), .CL (rst_n)) ;
    NR2R0 ix1101 (.X (nx1100), .A1 (nx6711), .A2 (nx942)) ;
    MX2L0 ix6712 (.X (nx6711), .A (shift_reg_6), .B (one_wire_sync), .S (nx1092)
          ) ;
    FD1I0 reg_rx_byte_7 (.Q (rx_byte[7]), .XQ (\$dummy [81]), .D (nx6351), .CK (
          clk), .EN (nx856), .CL (rst_n)) ;
    MX2T0 ix1129 (.X (nx6351), .A (one_wire_sync), .B (shift_reg_7), .S (nx6654)
          ) ;
    NR3R0 ix1121 (.X (nx1120), .A1 (nx6720), .A2 (nx6654), .A3 (nx776)) ;
    FD1I0 reg_shift_reg_7 (.Q (shift_reg_7), .XQ (nx6720), .D (nx1120), .CK (clk
          ), .EN (nx788), .CL (rst_n)) ;
    FD1B0 reg_rx_valid (.Q (rx_valid), .XQ (\$dummy [82]), .D (nx856), .CK (clk)
          , .CL (rst_n)) ;
    IV1N0 ix1109 (.X (nx6350), .A (nx6711)) ;
    IV1N0 ix1083 (.X (nx6349), .A (nx6702)) ;
    IV1N0 ix1057 (.X (nx6348), .A (nx6693)) ;
    IV1N0 ix1031 (.X (nx6347), .A (nx6683)) ;
    IV1N0 ix1011 (.X (nx6346), .A (nx6673)) ;
    IV1N0 ix983 (.X (nx6345), .A (nx6663)) ;
    IV1N0 ix955 (.X (nx6344), .A (nx6650)) ;
    IV1N0 ix847 (.X (nx846), .A (nx6654)) ;
    IV1N0 ix399 (.X (nx398), .A (nx6393)) ;
    IV1N0 ix393 (.X (nx392), .A (nx6395)) ;
    IV1N0 ix6408 (.X (nx6407), .A (nx390)) ;
    IV1N0 ix6520 (.X (nx6519), .A (nx370)) ;
    IV1NP ix6367 (.X (nx6366), .A (nx6341)) ;
    AN1V1 ix6729 (.X (nx6730), .A (nx6340)) ;
    AN1V1 ix6731 (.X (nx6732), .A (nx28)) ;
    AN2T0 ix379 (.X (nx378), .A1 (nx6341), .A2 (nx6732)) ;
    AO1A0 ix863 (.X (nx862), .A1 (nx776), .A2 (nx6519), .B (nx856)) ;
    AN4T0 ix6484 (.X (nx6483), .A1 (sample_cnt_7), .A2 (sample_cnt_8), .A3 (
          nx6738), .A4 (sample_cnt_6)) ;
    IV1N0 ix6737 (.X (nx6738), .A (nx720)) ;
    OR2T0 ix6512 (.X (nx6511), .A1 (nx6607), .A2 (nx6605)) ;
    AN4T0 ix6579 (.X (nx6578), .A1 (pres_cnt_9), .A2 (pres_cnt_10), .A3 (nx6740)
          , .A4 (pres_cnt_8)) ;
    IV1N0 ix6739 (.X (nx6740), .A (nx318)) ;
    AN2T0 ix805 (.X (nx804), .A1 (nx6607), .A2 (nx6605)) ;
    XN2R0 ix6612 (.X (nx6611), .A1 (nx6608), .A2 (nx6511)) ;
    AN3T0 ix6666 (.X (nx6665), .A1 (nx6607), .A2 (bit_idx_0), .A3 (nx6608)) ;
    AN3T0 ix6676 (.X (nx6675), .A1 (bit_idx_1), .A2 (nx6605), .A3 (nx6608)) ;
    OR3T0 ix1067 (.X (nx1066), .A1 (bit_idx_1), .A2 (nx6605), .A3 (nx6608)) ;
    OR3T0 ix1093 (.X (nx1092), .A1 (nx6607), .A2 (bit_idx_0), .A3 (nx6608)) ;
endmodule


module one_wire_tx ( clk, rst_n, start, tx_byte, busy, done, one_wire_data ) ;

    input clk ;
    input rst_n ;
    input start ;
    input [7:0]tx_byte ;
    output busy ;
    output done ;
    inout one_wire_data ;

    wire cnt_30, cnt_29, cnt_28, cnt_27, cnt_26, cnt_25, cnt_24, cnt_23, cnt_22, 
         cnt_21, cnt_20, cnt_19, cnt_18, cnt_17, cnt_16, cnt_15, cnt_14, cnt_13, 
         cnt_12, cnt_11, cnt_10, cnt_9, cnt_8, cnt_7, cnt_6, cnt_5, cnt_4, cnt_3, 
         cnt_2, cnt_1, cnt_0, cnt_r_30, cnt_r_29, cnt_r_28, cnt_r_27, cnt_r_26, 
         cnt_r_25, cnt_r_24, cnt_r_23, cnt_r_22, cnt_r_21, cnt_r_20, cnt_r_19, 
         cnt_r_18, cnt_r_17, cnt_r_16, cnt_r_15, cnt_r_14, cnt_r_13, cnt_r_12, 
         cnt_r_11, cnt_r_10, cnt_r_9, cnt_r_8, cnt_r_7, cnt_r_6, cnt_r_5, 
         cnt_r_4, cnt_r_3, cnt_r_2, cnt_r_1, cnt_ix132_carry_31, 
         cnt_ix132_carry_30, cnt_ix132_carry_29, cnt_ix132_carry_28, 
         cnt_ix132_carry_27, cnt_ix132_carry_26, cnt_ix132_carry_25, 
         cnt_ix132_carry_24, cnt_ix132_carry_23, cnt_ix132_carry_22, 
         cnt_ix132_carry_21, cnt_ix132_carry_20, cnt_ix132_carry_19, 
         cnt_ix132_carry_18, cnt_ix132_carry_17, cnt_ix132_carry_16, 
         cnt_ix132_carry_15, cnt_ix132_carry_14, cnt_ix132_carry_13, 
         cnt_ix132_carry_12, cnt_ix132_carry_11, cnt_ix132_carry_10, 
         cnt_ix132_carry_9, cnt_ix132_carry_8, cnt_ix132_carry_7, 
         cnt_ix132_carry_6, cnt_ix132_carry_5, cnt_ix132_carry_4, 
         cnt_ix132_carry_3, cnt_ix132_carry_2, GND, state_3, nx1319, state_1, 
         state_2, state_0, nx1320, nx2, nx1321, nx10, nx20, cnt_31, nx1322, 
         nx1323, nx34, nx38, nx48, nx62, nx70, nx86, nx94, nx108, nx116, nx134, 
         nx142, nx156, nx164, nx180, nx188, nx202, nx210, nx226, nx230, nx238, 
         nx246, nx254, nx262, nx270, nx278, nx296, nx304, nx312, nx324, nx334, 
         nx356, nx368, nx380, nx390, nx398, nx406, nx424, nx438, nx464, nx468, 
         nx478, nx484, nx490, nx516, nx530, nx534, nx544, nx562, nx566, nx570, 
         nx1324, nx606, bit_idx_1, bit_idx_0, nx610, nx622, nx632, nx634, nx654, 
         nx680, nx698, nx700, nx708, nx710, nx720, nx736, nx756, nx768, nx790, 
         nx812, nx824, nx836, nx842, nx894, nx902, nx916, nx1335, nx1338, nx1340, 
         nx1347, nx1349, nx1351, nx1353, nx1356, nx1358, nx1364, nx1366, nx1368, 
         nx1373, nx1376, nx1384, nx1386, nx1388, nx1391, nx1393, nx1396, nx1399, 
         nx1410, nx1412, nx1420, nx1423, nx1426, nx1427, nx1430, nx1436, nx1443, 
         nx1446, nx1450, nx1475, nx1501, nx1510, nx1512, nx1514, nx1518, nx1519, 
         nx1522, nx1538, nx1541, nx1547, nx1551, nx1554, nx1557, nx1560, nx1562, 
         nx1564, nx1568, nx1571, nx1573, nx1574, nx1576, nx1577, nx1584, nx1586, 
         nx1588, nx1591, nx1599, nx1606, nx1611, nx1617, nx1628, nx1630, nx1632;
    wire [24:0] \$dummy ;




    HA1A0 cnt_ix132_D0_I0_dup_511 (.S (cnt_r_1), .CO (cnt_ix132_carry_2), .A (
          cnt_1), .B (cnt_0)) ;
    HA1A0 cnt_ix132_D0_I0_dup_512 (.S (cnt_r_2), .CO (cnt_ix132_carry_3), .A (
          cnt_2), .B (cnt_ix132_carry_2)) ;
    HA1A0 cnt_ix132_D0_I0_dup_513 (.S (cnt_r_3), .CO (cnt_ix132_carry_4), .A (
          cnt_3), .B (cnt_ix132_carry_3)) ;
    HA1A0 cnt_ix132_D0_I0_dup_514 (.S (cnt_r_4), .CO (cnt_ix132_carry_5), .A (
          cnt_4), .B (cnt_ix132_carry_4)) ;
    HA1A0 cnt_ix132_D0_I0_dup_515 (.S (cnt_r_5), .CO (cnt_ix132_carry_6), .A (
          cnt_5), .B (cnt_ix132_carry_5)) ;
    HA1A0 cnt_ix132_D0_I0_dup_516 (.S (cnt_r_6), .CO (cnt_ix132_carry_7), .A (
          cnt_6), .B (cnt_ix132_carry_6)) ;
    HA1A0 cnt_ix132_D0_I0_dup_517 (.S (cnt_r_7), .CO (cnt_ix132_carry_8), .A (
          cnt_7), .B (cnt_ix132_carry_7)) ;
    HA1A0 cnt_ix132_D0_I0_dup_518 (.S (cnt_r_8), .CO (cnt_ix132_carry_9), .A (
          cnt_8), .B (cnt_ix132_carry_8)) ;
    HA1A0 cnt_ix132_D0_I0_dup_519 (.S (cnt_r_9), .CO (cnt_ix132_carry_10), .A (
          cnt_9), .B (cnt_ix132_carry_9)) ;
    HA1A0 cnt_ix132_D0_I0_dup_520 (.S (cnt_r_10), .CO (cnt_ix132_carry_11), .A (
          cnt_10), .B (cnt_ix132_carry_10)) ;
    HA1A0 cnt_ix132_D0_I0_dup_521 (.S (cnt_r_11), .CO (cnt_ix132_carry_12), .A (
          cnt_11), .B (cnt_ix132_carry_11)) ;
    HA1A0 cnt_ix132_D0_I0_dup_522 (.S (cnt_r_12), .CO (cnt_ix132_carry_13), .A (
          cnt_12), .B (cnt_ix132_carry_12)) ;
    HA1A0 cnt_ix132_D0_I0_dup_523 (.S (cnt_r_13), .CO (cnt_ix132_carry_14), .A (
          cnt_13), .B (cnt_ix132_carry_13)) ;
    HA1A0 cnt_ix132_D0_I0_dup_524 (.S (cnt_r_14), .CO (cnt_ix132_carry_15), .A (
          cnt_14), .B (cnt_ix132_carry_14)) ;
    HA1A0 cnt_ix132_D0_I0_dup_525 (.S (cnt_r_15), .CO (cnt_ix132_carry_16), .A (
          cnt_15), .B (cnt_ix132_carry_15)) ;
    HA1A0 cnt_ix132_D0_I0_dup_526 (.S (cnt_r_16), .CO (cnt_ix132_carry_17), .A (
          cnt_16), .B (cnt_ix132_carry_16)) ;
    HA1A0 cnt_ix132_D0_I0_dup_527 (.S (cnt_r_17), .CO (cnt_ix132_carry_18), .A (
          cnt_17), .B (cnt_ix132_carry_17)) ;
    HA1A0 cnt_ix132_D0_I0_dup_528 (.S (cnt_r_18), .CO (cnt_ix132_carry_19), .A (
          cnt_18), .B (cnt_ix132_carry_18)) ;
    HA1A0 cnt_ix132_D0_I0_dup_529 (.S (cnt_r_19), .CO (cnt_ix132_carry_20), .A (
          cnt_19), .B (cnt_ix132_carry_19)) ;
    HA1A0 cnt_ix132_D0_I0_dup_530 (.S (cnt_r_20), .CO (cnt_ix132_carry_21), .A (
          cnt_20), .B (cnt_ix132_carry_20)) ;
    HA1A0 cnt_ix132_D0_I0_dup_531 (.S (cnt_r_21), .CO (cnt_ix132_carry_22), .A (
          cnt_21), .B (cnt_ix132_carry_21)) ;
    HA1A0 cnt_ix132_D0_I0_dup_532 (.S (cnt_r_22), .CO (cnt_ix132_carry_23), .A (
          cnt_22), .B (cnt_ix132_carry_22)) ;
    HA1A0 cnt_ix132_D0_I0_dup_533 (.S (cnt_r_23), .CO (cnt_ix132_carry_24), .A (
          cnt_23), .B (cnt_ix132_carry_23)) ;
    HA1A0 cnt_ix132_D0_I0_dup_534 (.S (cnt_r_24), .CO (cnt_ix132_carry_25), .A (
          cnt_24), .B (cnt_ix132_carry_24)) ;
    HA1A0 cnt_ix132_D0_I0_dup_535 (.S (cnt_r_25), .CO (cnt_ix132_carry_26), .A (
          cnt_25), .B (cnt_ix132_carry_25)) ;
    HA1A0 cnt_ix132_D0_I0_dup_536 (.S (cnt_r_26), .CO (cnt_ix132_carry_27), .A (
          cnt_26), .B (cnt_ix132_carry_26)) ;
    HA1A0 cnt_ix132_D0_I0_dup_537 (.S (cnt_r_27), .CO (cnt_ix132_carry_28), .A (
          cnt_27), .B (cnt_ix132_carry_27)) ;
    HA1A0 cnt_ix132_D0_I0_dup_538 (.S (cnt_r_28), .CO (cnt_ix132_carry_29), .A (
          cnt_28), .B (cnt_ix132_carry_28)) ;
    HA1A0 cnt_ix132_D0_I0_dup_539 (.S (cnt_r_29), .CO (cnt_ix132_carry_30), .A (
          cnt_29), .B (cnt_ix132_carry_29)) ;
    HA1A0 cnt_ix132_D0_I0_dup_540 (.S (cnt_r_30), .CO (cnt_ix132_carry_31), .A (
          cnt_30), .B (cnt_ix132_carry_30)) ;
    CONZ0 ix1244 (.X (GND)) ;
    NR2R0 ix889 (.X (done), .A1 (nx1319), .A2 (nx20)) ;
    AOA4I1 ix793 (.X (nx1320), .A1 (nx1338), .A2 (nx1351), .B (nx1335), .C (
           nx1606)) ;
    OAI3N1 ix875 (.X (nx1323), .A1 (nx1347), .A2 (nx1335), .B1 (nx1349), .B2 (
           nx1599)) ;
    FD1B1 reg_state_3 (.Q (state_3), .XQ (nx1347), .D (nx1323), .CK (clk), .CL (
          rst_n)) ;
    ND3N0 ix1350 (.X (nx1349), .A1 (nx1351), .A2 (state_2), .A3 (state_1)) ;
    AO2L1 ix1352 (.X (nx1351), .A1 (nx1353), .A2 (nx424), .B1 (nx710), .B2 (
          nx1368)) ;
    AO1A0 ix701 (.X (nx700), .A1 (tx_byte[7]), .A2 (nx1356), .B (nx698)) ;
    NR2R0 ix1357 (.X (nx1356), .A1 (nx1358), .A2 (nx1577)) ;
    FD1I0 reg_bit_idx_1 (.Q (bit_idx_1), .XQ (nx1576), .D (nx622), .CK (clk), .EN (
          nx606), .CL (rst_n)) ;
    AO2L0 ix623 (.X (nx622), .A1 (bit_idx_1), .A2 (bit_idx_0), .B1 (nx1574), .B2 (
          nx1364)) ;
    FD1I0 reg_bit_idx_0 (.Q (bit_idx_0), .XQ (nx1573), .D (nx610), .CK (clk), .EN (
          nx606), .CL (rst_n)) ;
    NR2R0 ix611 (.X (nx610), .A1 (bit_idx_0), .A2 (nx1364)) ;
    ND3N0 ix1365 (.X (nx1364), .A1 (nx1366), .A2 (nx1560), .A3 (nx1562)) ;
    FD1B1 reg_state_0 (.Q (state_0), .XQ (nx1368), .D (nx1322), .CK (clk), .CL (
          rst_n)) ;
    FD1B0 reg_state_1 (.Q (state_1), .XQ (nx1340), .D (nx1321), .CK (clk), .CL (
          rst_n)) ;
    AO2L2 ix1377 (.X (nx1376), .A1 (nx720), .A2 (nx562), .B1 (nx842), .B2 (nx836
          )) ;
    FD1I0 reg_cur_bit (.Q (\$dummy [0]), .XQ (nx1353), .D (nx700), .CK (clk), .EN (
          nx570), .CL (rst_n)) ;
    AN6T0 ix571 (.X (nx570), .A1 (nx530), .A2 (nx1519), .A3 (nx1522), .A4 (nx356
          ), .A5 (nx490), .A6 (nx566)) ;
    NR8R0 ix531 (.X (nx530), .A1 (nx1368), .A2 (cnt_11), .A3 (cnt_10), .A4 (
          cnt_8), .A5 (cnt_7), .A6 (cnt_6), .A7 (cnt_4), .A8 (cnt_2)) ;
    AN2T0 ix247 (.X (nx246), .A1 (cnt_r_11), .A2 (nx1384)) ;
    FD1B1 reg_state_2 (.Q (state_2), .XQ (nx1335), .D (nx1320), .CK (clk), .CL (
          rst_n)) ;
    AO2I1 ix1394 (.X (nx1393), .A1 (nx1320), .A2 (nx2), .B1 (nx1373), .B2 (nx438
          )) ;
    OAI3N0 ix439 (.X (nx438), .A1 (nx1319), .A2 (nx1396), .B1 (nx1368), .B2 (
           nx1512)) ;
    OR2T0 ix1397 (.X (nx1396), .A1 (state_1), .A2 (nx424)) ;
    AOA4I0 ix425 (.X (nx424), .A1 (nx1399), .A2 (cnt_4), .B (nx1410), .C (nx1501
           )) ;
    AN2T0 ix1400 (.X (nx1399), .A1 (cnt_5), .A2 (cnt_6)) ;
    FD1B0 reg_cnt_5 (.Q (cnt_5), .XQ (\$dummy [1]), .D (nx406), .CK (clk), .CL (
          rst_n)) ;
    AN2T0 ix407 (.X (nx406), .A1 (cnt_r_5), .A2 (nx1384)) ;
    FD1B0 reg_cnt_6 (.Q (cnt_6), .XQ (\$dummy [2]), .D (nx398), .CK (clk), .CL (
          rst_n)) ;
    AN2T0 ix399 (.X (nx398), .A1 (cnt_r_6), .A2 (nx1384)) ;
    FD1B0 reg_cnt_4 (.Q (cnt_4), .XQ (\$dummy [3]), .D (nx390), .CK (clk), .CL (
          rst_n)) ;
    AN2T0 ix391 (.X (nx390), .A1 (cnt_r_4), .A2 (nx1384)) ;
    ND2N0 ix1411 (.X (nx1410), .A1 (nx1412), .A2 (nx368)) ;
    FD1B0 reg_cnt_7 (.Q (cnt_7), .XQ (nx1412), .D (nx262), .CK (clk), .CL (rst_n
          )) ;
    AN2T0 ix263 (.X (nx262), .A1 (cnt_r_7), .A2 (nx1384)) ;
    FD1B0 reg_cnt_13 (.Q (cnt_13), .XQ (nx1420), .D (nx304), .CK (clk), .CL (
          rst_n)) ;
    AN2T0 ix305 (.X (nx304), .A1 (cnt_r_13), .A2 (nx1384)) ;
    FD1B0 reg_cnt_15 (.Q (cnt_15), .XQ (nx1423), .D (nx230), .CK (clk), .CL (
          rst_n)) ;
    AN2T0 ix231 (.X (nx230), .A1 (cnt_r_15), .A2 (nx1384)) ;
    FD1B0 reg_cnt_14 (.Q (cnt_14), .XQ (nx1426), .D (nx238), .CK (clk), .CL (
          rst_n)) ;
    AN2T0 ix239 (.X (nx238), .A1 (cnt_r_14), .A2 (nx1384)) ;
    AOA4I0 ix1428 (.X (nx1427), .A1 (nx1426), .A2 (nx324), .B (nx1423), .C (
           nx226)) ;
    FD1B0 reg_cnt_12 (.Q (cnt_12), .XQ (nx1430), .D (nx312), .CK (clk), .CL (
          rst_n)) ;
    AN2T0 ix313 (.X (nx312), .A1 (cnt_r_12), .A2 (nx1384)) ;
    AO3I0 ix297 (.X (nx296), .A1 (cnt_8), .A2 (cnt_9), .A3 (cnt_7), .B (cnt_10)
          ) ;
    FD1B0 reg_cnt_8 (.Q (cnt_8), .XQ (nx1436), .D (nx278), .CK (clk), .CL (rst_n
          )) ;
    AN2T0 ix279 (.X (nx278), .A1 (cnt_r_8), .A2 (nx1384)) ;
    FD1B0 reg_cnt_9 (.Q (cnt_9), .XQ (\$dummy [4]), .D (nx270), .CK (clk), .CL (
          rst_n)) ;
    AN2T0 ix271 (.X (nx270), .A1 (cnt_r_9), .A2 (nx1384)) ;
    FD1B0 reg_cnt_10 (.Q (cnt_10), .XQ (\$dummy [5]), .D (nx254), .CK (clk), .CL (
          rst_n)) ;
    AN2T0 ix255 (.X (nx254), .A1 (cnt_r_10), .A2 (nx1384)) ;
    FD1B0 reg_cnt_11 (.Q (cnt_11), .XQ (nx1443), .D (nx246), .CK (clk), .CL (
          rst_n)) ;
    NR2R0 ix227 (.X (nx226), .A1 (nx1446), .A2 (nx1475)) ;
    OR8T0 ix1447 (.X (nx1446), .A1 (cnt_31), .A2 (cnt_30), .A3 (cnt_29), .A4 (
          cnt_28), .A5 (cnt_27), .A6 (cnt_26), .A7 (cnt_25), .A8 (cnt_24)) ;
    FD1B0 reg_cnt_31 (.Q (cnt_31), .XQ (\$dummy [6]), .D (nx38), .CK (clk), .CL (
          rst_n)) ;
    NR2R0 ix39 (.X (nx38), .A1 (nx1450), .A2 (nx34)) ;
    XN2R0 ix1451 (.X (nx1450), .A1 (cnt_31), .A2 (cnt_ix132_carry_31)) ;
    ND4N0 ix35 (.X (nx34), .A1 (nx1386), .A2 (nx1388), .A3 (nx1373), .A4 (nx1391
          )) ;
    FD1B0 reg_cnt_30 (.Q (cnt_30), .XQ (\$dummy [7]), .D (nx48), .CK (clk), .CL (
          rst_n)) ;
    AN2T0 ix49 (.X (nx48), .A1 (cnt_r_30), .A2 (nx1384)) ;
    FD1B0 reg_cnt_29 (.Q (cnt_29), .XQ (\$dummy [8]), .D (nx62), .CK (clk), .CL (
          rst_n)) ;
    AN2T0 ix63 (.X (nx62), .A1 (cnt_r_29), .A2 (nx1384)) ;
    FD1B0 reg_cnt_28 (.Q (cnt_28), .XQ (\$dummy [9]), .D (nx70), .CK (clk), .CL (
          rst_n)) ;
    AN2T0 ix71 (.X (nx70), .A1 (cnt_r_28), .A2 (nx1384)) ;
    FD1B0 reg_cnt_27 (.Q (cnt_27), .XQ (\$dummy [10]), .D (nx86), .CK (clk), .CL (
          rst_n)) ;
    AN2T0 ix87 (.X (nx86), .A1 (cnt_r_27), .A2 (nx1384)) ;
    FD1B0 reg_cnt_26 (.Q (cnt_26), .XQ (\$dummy [11]), .D (nx94), .CK (clk), .CL (
          rst_n)) ;
    AN2T0 ix95 (.X (nx94), .A1 (cnt_r_26), .A2 (nx1384)) ;
    FD1B0 reg_cnt_25 (.Q (cnt_25), .XQ (\$dummy [12]), .D (nx108), .CK (clk), .CL (
          rst_n)) ;
    AN2T0 ix109 (.X (nx108), .A1 (cnt_r_25), .A2 (nx1384)) ;
    FD1B0 reg_cnt_24 (.Q (cnt_24), .XQ (\$dummy [13]), .D (nx116), .CK (clk), .CL (
          rst_n)) ;
    AN2T0 ix117 (.X (nx116), .A1 (cnt_r_24), .A2 (nx1384)) ;
    OR8T0 ix1476 (.X (nx1475), .A1 (cnt_23), .A2 (cnt_22), .A3 (cnt_21), .A4 (
          cnt_20), .A5 (cnt_19), .A6 (cnt_18), .A7 (cnt_17), .A8 (cnt_16)) ;
    FD1B0 reg_cnt_23 (.Q (cnt_23), .XQ (\$dummy [14]), .D (nx134), .CK (clk), .CL (
          rst_n)) ;
    AN2T0 ix135 (.X (nx134), .A1 (cnt_r_23), .A2 (nx1384)) ;
    FD1B0 reg_cnt_22 (.Q (cnt_22), .XQ (\$dummy [15]), .D (nx142), .CK (clk), .CL (
          rst_n)) ;
    AN2T0 ix143 (.X (nx142), .A1 (cnt_r_22), .A2 (nx1384)) ;
    FD1B0 reg_cnt_21 (.Q (cnt_21), .XQ (\$dummy [16]), .D (nx156), .CK (clk), .CL (
          rst_n)) ;
    AN2T0 ix157 (.X (nx156), .A1 (cnt_r_21), .A2 (nx1384)) ;
    FD1B0 reg_cnt_20 (.Q (cnt_20), .XQ (\$dummy [17]), .D (nx164), .CK (clk), .CL (
          rst_n)) ;
    AN2T0 ix165 (.X (nx164), .A1 (cnt_r_20), .A2 (nx1384)) ;
    FD1B0 reg_cnt_19 (.Q (cnt_19), .XQ (\$dummy [18]), .D (nx180), .CK (clk), .CL (
          rst_n)) ;
    AN2T0 ix181 (.X (nx180), .A1 (cnt_r_19), .A2 (nx1384)) ;
    FD1B0 reg_cnt_18 (.Q (cnt_18), .XQ (\$dummy [19]), .D (nx188), .CK (clk), .CL (
          rst_n)) ;
    AN2T0 ix189 (.X (nx188), .A1 (cnt_r_18), .A2 (nx1384)) ;
    FD1B0 reg_cnt_17 (.Q (cnt_17), .XQ (\$dummy [20]), .D (nx202), .CK (clk), .CL (
          rst_n)) ;
    AN2T0 ix203 (.X (nx202), .A1 (cnt_r_17), .A2 (nx1384)) ;
    FD1B0 reg_cnt_16 (.Q (cnt_16), .XQ (\$dummy [21]), .D (nx210), .CK (clk), .CL (
          rst_n)) ;
    AN2T0 ix211 (.X (nx210), .A1 (cnt_r_16), .A2 (nx1384)) ;
    AO3I0 ix1502 (.X (nx1501), .A1 (nx356), .A2 (nx1430), .A3 (nx334), .B (nx380
          )) ;
    AO3I0 ix381 (.X (nx380), .A1 (cnt_9), .A2 (cnt_10), .A3 (cnt_8), .B (nx1510)
          ) ;
    AO6I0 ix1513 (.X (nx1512), .A1 (nx1514), .A2 (nx1335), .A3 (nx1427), .B1 (
          nx1340), .B2 (nx1347), .B3 (start)) ;
    FD1B0 reg_cnt_2 (.Q (cnt_2), .XQ (nx1518), .D (nx516), .CK (clk), .CL (rst_n
          )) ;
    AN2T0 ix517 (.X (nx516), .A1 (cnt_r_2), .A2 (nx1384)) ;
    FD1B0 reg_cnt_1 (.Q (cnt_1), .XQ (nx1519), .D (nx534), .CK (clk), .CL (rst_n
          )) ;
    AN2T0 ix535 (.X (nx534), .A1 (cnt_r_1), .A2 (nx1384)) ;
    NR2R0 ix545 (.X (nx544), .A1 (cnt_0), .A2 (nx34)) ;
    FD1B0 reg_cnt_0 (.Q (cnt_0), .XQ (nx1522), .D (nx544), .CK (clk), .CL (rst_n
          )) ;
    NR2R0 ix491 (.X (nx490), .A1 (cnt_12), .A2 (cnt_9)) ;
    AN3T0 ix567 (.X (nx566), .A1 (nx562), .A2 (nx226), .A3 (nx478)) ;
    NR2R0 ix563 (.X (nx562), .A1 (nx1335), .A2 (nx10)) ;
    NR2R0 ix479 (.X (nx478), .A1 (cnt_5), .A2 (cnt_3)) ;
    FD1B0 reg_cnt_3 (.Q (cnt_3), .XQ (\$dummy [22]), .D (nx468), .CK (clk), .CL (
          rst_n)) ;
    AN2T0 ix469 (.X (nx468), .A1 (cnt_r_3), .A2 (nx1384)) ;
    AOA4I0 ix1539 (.X (nx1538), .A1 (nx368), .A2 (nx490), .B (nx484), .C (nx708)
           ) ;
    NR4R0 ix485 (.X (nx484), .A1 (cnt_12), .A2 (cnt_8), .A3 (nx1410), .A4 (
          nx1541)) ;
    NR2R0 ix1542 (.X (nx1541), .A1 (nx478), .A2 (nx464)) ;
    OAI1A0 ix465 (.X (nx464), .A1 (cnt_5), .A2 (cnt_4), .B (cnt_6)) ;
    NR2R0 ix709 (.X (nx708), .A1 (nx1353), .A2 (cnt_10)) ;
    NR2R0 ix843 (.X (nx842), .A1 (nx1368), .A2 (nx1319)) ;
    OAI3R0 ix837 (.X (nx836), .A1 (nx1340), .A2 (nx1347), .A3 (nx1335), .B (
           nx1547)) ;
    AO3I0 ix1548 (.X (nx1547), .A1 (nx824), .A2 (nx1347), .A3 (nx1366), .B (
          nx812)) ;
    AOA4I0 ix769 (.X (nx768), .A1 (nx1551), .A2 (cnt_7), .B (nx1510), .C (nx1501
           )) ;
    AO1I0 ix1552 (.X (nx1551), .A1 (nx1518), .A2 (nx478), .B (nx464)) ;
    AO2L0 ix813 (.X (nx812), .A1 (nx1554), .A2 (state_0), .B1 (state_2), .B2 (
          nx10)) ;
    ND3N0 ix1555 (.X (nx1554), .A1 (nx756), .A2 (nx1443), .A3 (nx768)) ;
    OAOI0 ix757 (.X (nx756), .A1 (cnt_9), .A2 (nx1557), .B (cnt_10), .C (cnt_12)
          ) ;
    NR4R0 ix1558 (.X (nx1557), .A1 (nx1412), .A2 (nx1436), .A3 (nx736), .A4 (
          nx464)) ;
    AO1I0 ix737 (.X (nx736), .A1 (cnt_2), .A2 (cnt_3), .B (cnt_5)) ;
    NR4R1 ix1563 (.X (nx1562), .A1 (nx1393), .A2 (nx1376), .A3 (nx1564), .A4 (
          nx1323)) ;
    OAI3R0 ix791 (.X (nx790), .A1 (nx1356), .A2 (nx1347), .A3 (nx1324), .B (
           nx1568)) ;
    OAI3R2 ix607 (.X (nx606), .A1 (state_3), .A2 (nx1335), .A3 (nx1571), .B (
           nx1364)) ;
    ND3N0 ix1572 (.X (nx1571), .A1 (nx1562), .A2 (nx1368), .A3 (state_1)) ;
    FD1I0 bit_idx_2 (.Q (\$dummy [23]), .XQ (nx1577), .D (nx634), .CK (clk), .EN (
          nx606), .CL (rst_n)) ;
    MX2L0 ix699 (.X (nx698), .A (nx1584), .B (nx1591), .S (nx632)) ;
    AN2T0 ix1585 (.X (nx1584), .A1 (nx1586), .A2 (nx1588)) ;
    AO2I0 ix1587 (.X (nx1586), .A1 (tx_byte[3]), .A2 (nx1577), .B1 (tx_byte[4])
          , .B2 (nx1574)) ;
    AO3I0 ix1589 (.X (nx1588), .A1 (nx1573), .A2 (tx_byte[6]), .A3 (bit_idx_1), 
          .B (nx680)) ;
    AN3T0 ix681 (.X (nx680), .A1 (bit_idx_0), .A2 (tx_byte[5]), .A3 (nx1576)) ;
    AO2I0 ix1592 (.X (nx1591), .A1 (tx_byte[0]), .A2 (nx1574), .B1 (nx1577), .B2 (
          nx654)) ;
    AO2A0 ix655 (.X (nx654), .A1 (tx_byte[2]), .A2 (bit_idx_1), .B1 (tx_byte[1])
          , .B2 (bit_idx_0)) ;
    OAI3N0 ix1600 (.X (nx1599), .A1 (nx1356), .A2 (nx1324), .B1 (nx1560), .B2 (
           nx20)) ;
    TS1R1 tri_one_wire_data (.X (one_wire_data), .A (GND), .C (nx1611)) ;
    FD1B0 reg_drive_low (.Q (\$dummy [24]), .XQ (nx1611), .D (nx902), .CK (clk)
          , .CL (rst_n)) ;
    OR2T0 ix919 (.X (busy), .A1 (nx916), .A2 (state_2)) ;
    AOA4I0 ix917 (.X (nx916), .A1 (nx1319), .A2 (nx1340), .B (done), .C (nx1617)
           ) ;
    AOA4I0 ix1618 (.X (nx1617), .A1 (nx1340), .A2 (nx894), .B (nx562), .C (
           state_0)) ;
    IV1N0 ix903 (.X (nx902), .A (nx1617)) ;
    IV1N0 ix1607 (.X (nx1606), .A (nx790)) ;
    IV1N0 ix721 (.X (nx720), .A (nx1351)) ;
    IV1N0 ix711 (.X (nx710), .A (nx1538)) ;
    IV1N0 ix855 (.X (nx1324), .A (nx1366)) ;
    IV1N0 ix1511 (.X (nx1510), .A (nx368)) ;
    IV1N0 ix335 (.X (nx334), .A (nx1427)) ;
    IV1N2 ix1385 (.X (nx1384), .A (nx34)) ;
    IV1N0 ix445 (.X (nx1322), .A (nx1393)) ;
    IV1N0 ix1515 (.X (nx1514), .A (nx20)) ;
    IV1N0 ix1339 (.X (nx1338), .A (nx10)) ;
    IV1N0 ix847 (.X (nx1321), .A (nx1376)) ;
    IV1N0 ix1565 (.X (nx1564), .A (nx1320)) ;
    IV1N0 ix1561 (.X (nx1560), .A (nx1319)) ;
    OR2T0 ix883 (.X (nx1319), .A1 (state_2), .A2 (nx1347)) ;
    OR2T0 ix1359 (.X (nx1358), .A1 (nx1576), .A2 (nx1573)) ;
    AN2T0 ix1367 (.X (nx1366), .A1 (state_0), .A2 (nx1340)) ;
    XN2R0 ix3 (.X (nx2), .A1 (nx1347), .A2 (nx1368)) ;
    XN2R0 ix1374 (.X (nx1373), .A1 (nx1340), .A2 (nx1376)) ;
    XR2T0 ix1387 (.X (nx1386), .A1 (nx1347), .A2 (nx1323)) ;
    XR2T0 ix1389 (.X (nx1388), .A1 (nx1335), .A2 (nx1320)) ;
    XN2R0 ix1392 (.X (nx1391), .A1 (nx1368), .A2 (nx1393)) ;
    AN3T0 ix369 (.X (nx368), .A1 (nx356), .A2 (nx1443), .A3 (nx334)) ;
    AN3T0 ix357 (.X (nx356), .A1 (nx1420), .A2 (nx1423), .A3 (nx1426)) ;
    ND4N0 ix1506 (.X (nx324), .A1 (cnt_12), .A2 (cnt_13), .A3 (nx1628), .A4 (
          cnt_11)) ;
    IV1N0 ix1627 (.X (nx1628), .A (nx296)) ;
    OR2T0 ix11 (.X (nx10), .A1 (nx1340), .A2 (state_3)) ;
    MX2L0 ix825 (.X (nx824), .A (nx334), .B (nx768), .S (nx1335)) ;
    OR4T0 ix1569 (.X (nx1568), .A1 (state_2), .A2 (nx1368), .A3 (nx1630), .A4 (
          nx10)) ;
    IV1N0 ix1629 (.X (nx1630), .A (nx1554)) ;
    AN2T0 ix1575 (.X (nx1574), .A1 (nx1573), .A2 (nx1576)) ;
    NR2R0 ix635 (.X (nx634), .A1 (nx1632), .A2 (nx1364)) ;
    IV1N0 ix1631 (.X (nx1632), .A (nx632)) ;
    XR2T0 ix633 (.X (nx632), .A1 (nx1358), .A2 (nx1577)) ;
    OR2T0 ix21 (.X (nx20), .A1 (state_0), .A2 (nx1340)) ;
    AN2T0 ix895 (.X (nx894), .A1 (nx1347), .A2 (nx1335)) ;
endmodule

