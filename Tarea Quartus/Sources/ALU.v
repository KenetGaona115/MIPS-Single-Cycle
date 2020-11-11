/******************************************************************
* Description
*	This is an 32-bit arithetic logic unit that can execute the next set of operations:
*		add
*		sub
*		or
*		and
*		nor
* This ALU is written by using behavioral description.
* Version:
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	05/07/2020
******************************************************************/

module ALU 
(
	input [3:0] alu_operation_i,
	input [31:0] a_i,//RS
	input [31:0] b_i,//RT
	input [4:0] shamt,
	output reg zero_o,
	output reg [31:0] alu_data_o//RD
);

//declarar operaciones
//variables locales
localparam ADD = 4'b0011;
localparam LUI = 4'b0010;
localparam OR  = 4'b0110;
localparam SLL = 4'b0101;
localparam SRL = 4'b0001;
localparam SUB = 4'b0000;

   
   always @ (a_i or b_i or alu_operation_i)
     begin
		case (alu_operation_i)
		
		  ADD: // add
			alu_data_o = a_i + b_i;
		  LUI: //lui	
			alu_data_o = {b_i[15:0],16'b0};//Tomamos la parte
		  OR: //ori
			alu_data_o = a_i | b_i;
		  SLL: // sll
			alu_data_o = b_i << shamt;
		  SRL: // srl
			alu_data_o = b_i >> shamt;
		  SUB: //sub
			alu_data_o = a_i - b_i;
			
		default:
			alu_data_o = 0;
		endcase // case(control)
		
		zero_o = (alu_data_o == 0) ? 1'b1 : 1'b0;
		
     end // always @ (A or B or control)
	  
endmodule // ALU