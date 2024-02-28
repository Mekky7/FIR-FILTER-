// TESTBENCH `
`timescale 1ns / 1ps
module fir_tb();
  localparam CODRIC_CLK_PERIOD = 2;
  localparam FIR_CLK_PERIOD = 10;
  localparam signed [15:0] PI_POS = 16'h6488;
  localparam signed [15:0] PI_NEG = 16'h9B78;
  localparam PHASE_INC_2MHZ = 200; 
  localparam PHASE_INC_30MHZ = 3000;

  logic cordic_clk = 0;
  logic fir_clk = 0;
  reg signed[15:0] phase_2MHZ = 0;
  reg  signed [15:0] phase_30MHZ = 0;
  logic phase_tvalid = 0;
  wire sincos_2MHZ_tvalid;
  wire signed [15:0] sin_2MHZ, cos_2MHZ;
  wire sincos_30MHZ_tvalid;
  wire signed [15:0] sin_30MHZ, cos_30MHZ;
  reg [15:0] noisy_signal;
 bit signed  [40:0] filtered_signal;
   digital_filter_15_tap_lowpass DUT(.clk(fir_clk), .input_signal(noisy_signal), .filtered_signal(filtered_signal));
  // Instantiating CORDIC modules
  cordic_0 crodic_inst_0 (
    .aclk(cordic_clk),
    .s_axis_phase_tvalid(phase_tvalid),
    .s_axis_phase_tdata(phase_2MHZ),
    .m_axis_dout_tvalid(sincos_2MHZ_tvalid),
    .m_axis_dout_tdata({sin_2MHZ, cos_2MHZ})
  );

  cordic_0 crodic_inst_1 (
    .aclk(cordic_clk),
    .s_axis_phase_tvalid(phase_tvalid),
    .s_axis_phase_tdata(phase_30MHZ),
    .m_axis_dout_tvalid(sincos_30MHZ_tvalid),
    .m_axis_dout_tdata({sin_30MHZ, cos_30MHZ})
  );

  always @(posedge cordic_clk) begin
    phase_tvalid <= 1'b1;

    if (phase_2MHZ + PHASE_INC_2MHZ <= PI_POS)
      phase_2MHZ <= phase_2MHZ + PHASE_INC_2MHZ;
    else
      phase_2MHZ <=PI_NEG ;

    if (phase_30MHZ + PHASE_INC_30MHZ <= PI_POS)
      phase_30MHZ <= phase_30MHZ + PHASE_INC_30MHZ;
    else
      phase_30MHZ <= PI_NEG;

  end

  always begin
    #(CODRIC_CLK_PERIOD/2)
    cordic_clk <= !cordic_clk;
  end

  always begin
    #(FIR_CLK_PERIOD/2)
    fir_clk <= !fir_clk;
  end

  always @(posedge cordic_clk) begin
    noisy_signal = (sin_2MHZ + sin_30MHZ) / 2;
  end

endmodule
