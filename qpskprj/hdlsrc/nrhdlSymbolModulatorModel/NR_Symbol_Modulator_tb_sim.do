onbreak resume
onerror resume
vsim -voptargs=+acc work.NR_Symbol_Modulator_tb

add wave sim:/NR_Symbol_Modulator_tb/u_NR_Symbol_Modulator/clk
add wave sim:/NR_Symbol_Modulator_tb/u_NR_Symbol_Modulator/reset
add wave sim:/NR_Symbol_Modulator_tb/u_NR_Symbol_Modulator/clk_enable
add wave sim:/NR_Symbol_Modulator_tb/u_NR_Symbol_Modulator/dataIn
add wave sim:/NR_Symbol_Modulator_tb/u_NR_Symbol_Modulator/validIn
add wave sim:/NR_Symbol_Modulator_tb/u_NR_Symbol_Modulator/modSel
add wave sim:/NR_Symbol_Modulator_tb/u_NR_Symbol_Modulator/load
add wave sim:/NR_Symbol_Modulator_tb/u_NR_Symbol_Modulator/ce_out
add wave sim:/NR_Symbol_Modulator_tb/u_NR_Symbol_Modulator/dataOut_re
add wave sim:/NR_Symbol_Modulator_tb/dataOut_re_ref
add wave sim:/NR_Symbol_Modulator_tb/u_NR_Symbol_Modulator/dataOut_im
add wave sim:/NR_Symbol_Modulator_tb/dataOut_im_ref
add wave sim:/NR_Symbol_Modulator_tb/u_NR_Symbol_Modulator/validOut
add wave sim:/NR_Symbol_Modulator_tb/validOut_ref
run -all
