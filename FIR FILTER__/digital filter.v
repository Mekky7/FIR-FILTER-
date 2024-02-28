//DESIGN
module digital_filter_15_tap_lowpass (input clk, input [15:0] input_signal, output [31:0] filtered_signal);
//cutoff frequenncy 3 MHZ
// SAMPLING RATE 100 MHZ
// DESIGN METHOD OF THE FILTER IS WINDOW  (KAISER WITH BETA OF 0.5 )
 wire [31:0] prod14, prod13, prod12, prod11, prod10, prod9, prod8, prod7, prod6, prod5, prod4, prod3, prod2, prod1, prod0;
  reg [15:0] buff0, buff1, buff2, buff3, buff4, buff5, buff6, buff7, buff8,buff9,buff10,buff11,buff12,buff13,buff14;
 reg [15:0] coeff0 = 1719;
  reg [15:0] coeff1 =1904; 
  reg [15:0] coeff2 = 2072;
  reg [15:0] coeff3 = 2216;
  reg [15:0] coeff4 = 2333;
  reg [15:0] coeff5 = 2419;
  reg [15:0] coeff6 =2472;
  reg [15:0] coeff7 = 2490;
  reg [15:0] coeff8 = 2472;
  reg [15:0] coeff9=2419;
  reg [15:0] coeff10=2333;
  reg [15:0] coeff11=2216;
  reg [15:0] coeff12=2072;
  reg [15:0] coeff13=1904;
  reg [15:0] coeff14=1719;
  dadda_multiplier DM_14(buff14, coeff14, prod14);
  dadda_multiplier DM_13(buff13, coeff13, prod13);
  dadda_multiplier DM_12(buff12, coeff12, prod12);
  dadda_multiplier DM_11(buff11, coeff11, prod11);
  dadda_multiplier DM_10(buff10, coeff10, prod10);
  dadda_multiplier DM_9(buff9, coeff9, prod9);
  dadda_multiplier DM_8(buff8, coeff8, prod8);
  dadda_multiplier DM_7(buff7, coeff7, prod7);
  dadda_multiplier DM_6(buff6, coeff6, prod6);
  dadda_multiplier DM_5(buff5, coeff5, prod5);
  dadda_multiplier DM_4(buff4, coeff4, prod4);
  dadda_multiplier DM_3(buff3, coeff3, prod3);
  dadda_multiplier DM_2(buff2, coeff2, prod2);
  dadda_multiplier DM_1(buff1, coeff1, prod1);
  dadda_multiplier DM_0(buff0, coeff0, prod0);

   always @(posedge clk) begin
    buff0 <= input_signal;
    buff1 <= buff0;
    buff2 <= buff1;
    buff3 <= buff2;
    buff4 <= buff3;
    buff5 <= buff4;
    buff6 <= buff5;
    buff7 <= buff6;
    buff8 <= buff7;
    buff9 <= buff8; 
    buff10 <= buff9;
    buff11 <= buff10; 
    buff12 <= buff11; 
    buff13 <= buff12;
    buff14 <= buff13;
  end
  assign filtered_signal = prod14 + prod13 + prod12 + prod11 + prod10 + prod9 + prod8 + prod7 + prod6 + prod5 + prod4 + prod3 + prod2 + prod1 + prod0;
endmodule