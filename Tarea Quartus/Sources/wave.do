onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /MIPS_Processor_TB/clk_tb
add wave -noupdate /MIPS_Processor_TB/reset_tb
add wave -noupdate -radix decimal /MIPS_Processor_TB/alu_result_tb
add wave -noupdate -expand -group PROGRAM_COUNTER -radix hexadecimal /MIPS_Processor_TB/DUV/PC/new_pc_i
add wave -noupdate -expand -group PROGRAM_COUNTER -radix hexadecimal /MIPS_Processor_TB/DUV/PC/pc_value_o
add wave -noupdate -expand -group PROGRAM_MEMORY -radix hexadecimal /MIPS_Processor_TB/DUV/ROM/address_i
add wave -noupdate -expand -group PROGRAM_MEMORY -radix hexadecimal /MIPS_Processor_TB/DUV/ROM/instruction_o
add wave -noupdate -expand -group REGISTER /MIPS_Processor_TB/DUV/REGISTER_FILE_UNIT/reg_write_i
add wave -noupdate -expand -group REGISTER -label t0 -radix decimal /MIPS_Processor_TB/DUV/REGISTER_FILE_UNIT/t0/data_o
add wave -noupdate -expand -group REGISTER -label t1 -radix decimal /MIPS_Processor_TB/DUV/REGISTER_FILE_UNIT/t1/data_o
add wave -noupdate -expand -group REGISTER -label t2 -radix decimal /MIPS_Processor_TB/DUV/REGISTER_FILE_UNIT/t2/data_o
add wave -noupdate -expand -group REGISTER -label t3 -radix decimal /MIPS_Processor_TB/DUV/REGISTER_FILE_UNIT/t3/data_o
add wave -noupdate -expand -group REGISTER -label s0 -radix decimal /MIPS_Processor_TB/DUV/REGISTER_FILE_UNIT/s0/data_o
add wave -noupdate -expand -group REGISTER -label s1 -radix decimal /MIPS_Processor_TB/DUV/REGISTER_FILE_UNIT/s1/data_o
add wave -noupdate -expand -group REGISTER -label s2 -radix decimal /MIPS_Processor_TB/DUV/REGISTER_FILE_UNIT/s2/data_o
add wave -noupdate -expand -group REGISTER -label s3 -radix decimal /MIPS_Processor_TB/DUV/REGISTER_FILE_UNIT/s3/data_o
add wave -noupdate -expand -group REGISTER -label s7 -radix decimal /MIPS_Processor_TB/DUV/REGISTER_FILE_UNIT/s7/data_o
add wave -noupdate -expand -group REGISTER -color Magenta -label sp -radix hexadecimal /MIPS_Processor_TB/DUV/REGISTER_FILE_UNIT/sp/data_o
add wave -noupdate -expand -group ALU_UNIT /MIPS_Processor_TB/DUV/ALU_UNIT/alu_operation_i
add wave -noupdate -expand -group ALU_UNIT -radix decimal /MIPS_Processor_TB/DUV/ALU_UNIT/a_i
add wave -noupdate -expand -group ALU_UNIT -radix decimal /MIPS_Processor_TB/DUV/ALU_UNIT/b_i
add wave -noupdate -expand -group ALU_UNIT -radix decimal /MIPS_Processor_TB/DUV/ALU_UNIT/shamt
add wave -noupdate -expand -group ALU_UNIT /MIPS_Processor_TB/DUV/ALU_UNIT/zero_o
add wave -noupdate -expand -group ALU_UNIT -radix decimal /MIPS_Processor_TB/DUV/ALU_UNIT/alu_data_o
add wave -noupdate -group CONTROL_UNIT -color Magenta -radix hexadecimal -radixshowbase 0 /MIPS_Processor_TB/DUV/CONTROL_UNIT/opcode_i
add wave -noupdate -group CONTROL_UNIT /MIPS_Processor_TB/DUV/CONTROL_UNIT/reg_dst_o
add wave -noupdate -group CONTROL_UNIT /MIPS_Processor_TB/DUV/CONTROL_UNIT/branch_eq_o
add wave -noupdate -group CONTROL_UNIT /MIPS_Processor_TB/DUV/CONTROL_UNIT/branch_ne_o
add wave -noupdate -group CONTROL_UNIT /MIPS_Processor_TB/DUV/CONTROL_UNIT/mem_read_o
add wave -noupdate -group CONTROL_UNIT /MIPS_Processor_TB/DUV/CONTROL_UNIT/mem_to_reg_o
add wave -noupdate -group CONTROL_UNIT /MIPS_Processor_TB/DUV/CONTROL_UNIT/mem_write_o
add wave -noupdate -group CONTROL_UNIT /MIPS_Processor_TB/DUV/CONTROL_UNIT/alu_src_o
add wave -noupdate -group CONTROL_UNIT /MIPS_Processor_TB/DUV/CONTROL_UNIT/reg_write_o
add wave -noupdate -group CONTROL_UNIT /MIPS_Processor_TB/DUV/CONTROL_UNIT/alu_op_o
add wave -noupdate -expand -group REG_CONTROL -radix decimal /MIPS_Processor_TB/DUV/REGISTER_FILE_UNIT/reg_write_i
add wave -noupdate -expand -group REG_CONTROL -radix unsigned /MIPS_Processor_TB/DUV/REGISTER_FILE_UNIT/write_register_i
add wave -noupdate -expand -group REG_CONTROL -radix unsigned /MIPS_Processor_TB/DUV/REGISTER_FILE_UNIT/read_register_1_i
add wave -noupdate -expand -group REG_CONTROL -radix unsigned /MIPS_Processor_TB/DUV/REGISTER_FILE_UNIT/read_register_2_i
add wave -noupdate -expand -group REG_CONTROL -radix decimal /MIPS_Processor_TB/DUV/REGISTER_FILE_UNIT/write_data_i
add wave -noupdate -expand -group REG_CONTROL -radix decimal /MIPS_Processor_TB/DUV/REGISTER_FILE_UNIT/read_data_1_o
add wave -noupdate -expand -group REG_CONTROL -radix decimal /MIPS_Processor_TB/DUV/REGISTER_FILE_UNIT/read_data_2_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 149
configure wave -valuecolwidth 53
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {32 ps}
