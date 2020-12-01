/******************************************************************
* Description
*	This is the top-level of a MIPS processor that can execute the next set of instructions:
*		add
*		addi
*		sub
*		ori
*		or
*		bne
*		beq
*		and
*		nor
* This processor is written Verilog-HDL. Also, it is synthesizable into hardware.
* Parameter MEMORY_DEPTH configures the program memory to allocate the program to
* be execute. If the size of the program changes, thus, MEMORY_DEPTH must change.
* This processor was made for computer organization class at ITESO.
* Version:
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	05/07/2020
******************************************************************/


module MIPS_Processor
#(
	parameter MEMORY_DEPTH = 256
)
(
	// Inputs
	input clk,
	input reset,
	// Output
	output [31:0] alu_result_o
);
//******************************************************************/
//******************************************************************/
// Data types to connect modules

wire reg_dst_w;
wire alu_rc_w;
wire reg_write_w;
wire zero_w;
wire [2:0] alu_op_w;
wire [3:0] alu_operation_w;
wire [4:0] write_register_w;
wire [31:0] pc_w;
wire [31:0] instruction_w;
wire [31:0] read_data_1_w;
wire [31:0] read_data_2_w;
wire [31:0] inmmediate_extend_w;
wire [31:0] read_ata_2_r_nmmediate_w;
wire [31:0] alu_result_w;
wire [31:0] pc_plus_4_w;

//nuevos
wire [31:0] jumpAddressAux;
wire [31:0] result_Adder_1;
wire [31:0] result_Mux_PC_PLUS_4_OR_SIGEX_1;
wire [31:0] result_Mux_PC_PLUS_4_OR_Mux1_2;
wire [31:0] result_sub_pc_w;
wire [31:0] MuxJROutput_wire;
wire [31:0] MuxJalWROutput_wire;
wire [31:0] MuxJal_PC_Output_wire;
wire [31:0] Mux_DataMem_Output_wire;
wire [31:0] Data_output;
wire true_wire_beq;
wire true_wire_bne;
wire jump_wire;
wire jal_wire;
wire jr_wire;
wire mem_wr;
wire mem_read;
wire mem_to_reg_wire;

//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
Control
CONTROL_UNIT
(
	.opcode_i(instruction_w[31:26]),
	.reg_dst_o(reg_dst_w),
	.branch_ne_o(branch_ne_w),
	.branch_eq_o(branch_eq_w),
	.alu_op_o(alu_op_w),
	.alu_src_o(alu_rc_w),
	.reg_write_o(reg_write_w),
	.Jump(jump_wire),//cable del Jump
	.mem_read_o(mem_read),
	.mem_write_o(mem_wr),
	.mem_to_reg_o(mem_to_reg_wire)
);

Program_Counter
PC
(
	.clk(clk),
	.reset(reset),
	.new_pc_i(MuxJROutput_wire),
	.pc_value_o(pc_w)
);

Program_Memory
#
(
	.MEMORY_DEPTH(MEMORY_DEPTH)
)
ROM
(
	.address_i(result_sub_pc_w),
	.instruction_o(instruction_w)//tomamos los bits correspondientes
);


Adder
PC_Puls_4
(
	.data_0_i(pc_w),
	.data_1_i(32'h4),
	
	.result_o(pc_plus_4_w)
);


//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
Multiplexer_2_to_1
#(
	.N_BITS(5)
)
MUX_R_TYPE_OR_I_Type
(
	.selector_i(reg_dst_w),
	.data_0_i(instruction_w[20:16]),
	.data_1_i(instruction_w[15:11]),
	
	.mux_o(write_register_w)

);



Register_File
REGISTER_FILE_UNIT
(
	.clk(clk),
	.reset(reset),
	.reg_write_i(reg_write_w),//numero de registro donde escribimos
	.write_register_i(MuxJalWROutput_wire),
	.read_register_1_i(instruction_w[25:21]),
	.read_register_2_i(instruction_w[20:16]),
	.write_data_i(MuxJal_PC_Output_wire),
	.read_data_1_o(read_data_1_w),
	.read_data_2_o(read_data_2_w)

);

Sign_Extend
SIGNED_EXTEND_FOR_CONSTANTS
(   
	.data_i(instruction_w[15:0]),
   .sign_extend_o(inmmediate_extend_w)
);



Multiplexer_2_to_1
#(
	.N_BITS(32)
)
MUX_READ_DATA_2_OR_IMMEDIATE
(
	.selector_i(alu_rc_w),
	.data_0_i(read_data_2_w),
	.data_1_i(inmmediate_extend_w),
	
	.mux_o(read_ata_2_r_nmmediate_w)

);


ALU_Control
ALU_CTRL
(
	.alu_op_i(alu_op_w),
	.alu_function_i(instruction_w[5:0]),
	.alu_operation_o(alu_operation_w),
	.jr(jr_wire)
);



ALU
ALU_UNIT
(
	.alu_operation_i(alu_operation_w),
	.a_i(read_data_1_w),
	.b_i(read_ata_2_r_nmmediate_w),
	.zero_o(zero_w),
	.alu_data_o(alu_result_w),
	.shamt(instruction_w[10:6])//shamt
);

Adder
#
(
	.N_BITS(32)
)
ADDER
(
	.data_0_i(pc_plus_4_w),
	.data_1_i({inmmediate_extend_w[29:0],2'b00}),
	.result_o(result_Adder_1)
);
//multiplexor para validar el beq


Data_Memory 
#(	.DATA_WIDTH(32),
	.MEMORY_DEPTH(256)

)
DATA_MEMORY_INST
(
	.write_data_i(read_data_2_w),//bien
	.address_i({read_data_1_w - 32'h10010000}),//direccion de la ALu **problema??
	.mem_write_i(mem_wr),//banderas
	.mem_read_i(mem_read), 
	.clk(clk),
	.data_o(Data_output)
);

//salida de memoria y de la Alu
Multiplexer_2_to_1
#(
	.N_BITS(32)
)
MUX_ALU_MEM
(
	.selector_i(mem_to_reg_wire),
	.data_0_i(alu_result_w),//**problema??
	.data_1_i(Data_output),
	.mux_o(Mux_DataMem_Output_wire)//salida para el j

);

//mux para validar el beq
Multiplexer_2_to_1
#(
	.N_BITS(32)
)
MUX_PC_PLUS_4_OR_SIEXTN
(
	.selector_i(true_wire_beq |true_wire_bne),
	.data_0_i(pc_plus_4_w),
	.data_1_i(result_Adder_1),
	
	.mux_o(result_Mux_PC_PLUS_4_OR_SIGEX_1)

);
//multiplexor para validar el jump
Multiplexer_2_to_1
#(
	.N_BITS(32)
)
MUX_PC_PLUS_4_INSTRUC_OR_MUX_Branch
(
	.selector_i(jump_wire),
	.data_0_i(result_Mux_PC_PLUS_4_OR_SIGEX_1),
	.data_1_i({pc_plus_4_w[31:28],instruction_w[25:0],2'b00}),
	
	.mux_o(result_Mux_PC_PLUS_4_OR_Mux1_2)


);

//Multiplexores para decidir si hacemos jal
//**COMPLETAR
Multiplexer_2_to_1
#(
	.N_BITS(32)
)
MuxJal
(
	.selector_i(jump_wire),
	.data_0_i(Mux_DataMem_Output_wire),
	.data_1_i(pc_plus_4_w),
	.mux_o(MuxJal_PC_Output_wire)

);

//Escribimos la direccion en $ra
Multiplexer_2_to_1
#(
	.N_BITS(5)
)
MuxJalWR
(
	.selector_i(jump_wire),
	.data_0_i(write_register_w),
	.data_1_i(5'b11111),
	.mux_o(MuxJalWROutput_wire)

);


Multiplexer_2_to_1
#(
	.N_BITS(32)
)
MuxJR
(
	.selector_i(jr_wire),
	.data_0_i(result_Mux_PC_PLUS_4_OR_Mux1_2),
	.data_1_i(read_data_1_w),
	.mux_o(MuxJROutput_wire)

);


Adder
#
(
	 .N_BITS(32)
)
ADDER_PC
(
	.data_0_i(pc_w),
	.data_1_i(-32'h00400000),
	.result_o(result_sub_pc_w)
);

assign alu_result_o = alu_result_w;
assign true_wire_beq = (zero_w & branch_eq_w);
assign true_wire_bne = (~zero_w & branch_ne_w);


endmodule

