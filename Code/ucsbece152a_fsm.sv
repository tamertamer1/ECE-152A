/*
 * Copyright (c) 2023, University of California; Santa Barbara
 * Distribution prohibited. All rights reserved.
 *
 * File: ucsbece152a_fsm.sv
 * Description: Starter code for fsm.
 */

module ucsbece152a_fsm import taillights_pkg::*; (
    input   logic       clk,
    input   logic       rst_n,

    input   logic       left_i,
    input   logic       right_i,
    input   logic       hazard_i,

    output  state_t     state_o,
    output  logic [5:0] pattern_o
);

state_t state_d, state_q = S000_000;
assign state_o = state_q;

// TODO: Implement the FSM and drive `pattern_o`
always_comb begin
  case (state_q)
    S000_000: pattern_o = 6'b000000;
    S001_000: pattern_o = 6'b001000;
    S011_000: pattern_o = 6'b011000;
    S111_000: pattern_o = 6'b111000;
    S000_100: pattern_o = 6'b000100;
    S000_110: pattern_o = 6'b000110;
    S000_111: pattern_o = 6'b000111;
    S111_111: pattern_o = 6'b111111;
    default: pattern_o = 6'b000000;
  endcase;
 if ((left_i & right_i) | hazard_i ) begin
    case (state_q)
      S111_111: state_d =S000_000;
      default: state_d=S111_111;
    endcase;
  end else if (right_i) begin
    case (state_q)
      S000_000: state_d = S000_100;
      S000_100: state_d = S000_110;
      S000_110: state_d = S000_111;
      default: state_d = S000_000;
    endcase;
  end else if (left_i) begin
    case (state_q)
      S000_000: state_d = S001_000;
      S001_000: state_d = S011_000;
      S011_000: state_d = S111_000;
      default: state_d = S000_000;
    endcase;
  end else begin
    state_d = S000_000;
  end
end
always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    state_q <= S000_000;
  end else begin
    state_q <= state_d;
  end
end
endmodule

