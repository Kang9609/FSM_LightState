`timescale 1ns / 1ps

module FSM
(
    input i_clk,
    input i_reset,
    input [2:0] i_button,
    output [2:0] o_lightState
);
    parameter S_LED_0 = 3'd0,
              S_LED_1 = 3'd1,
              S_LED_2 = 3'd2,
              S_LED_3 = 3'd3,
              S_LED_4 = 3'd4;



    reg [2:0] curState, nextState;
    reg [2:0] r_lightState;

    assign o_lightState = r_lightState;

    always @(posedge i_clk or posedge i_reset) begin
        if (i_reset) curState <= S_LED_0;
        else         curState <= nextState;
    end

    always @(curState or i_button) begin
        case (curState)
            S_LED_0 : begin
                if (i_button[1]) nextState <= S_LED_1;
                else             nextState <= S_LED_0;
            end

            S_LED_1 : begin
                if (i_button[0])       nextState <= S_LED_0;
                else if (i_button [1]) nextState <= S_LED_2;
                else if (i_button [2]) nextState <= S_LED_0;
                else                   nextState <= S_LED_1;
            end

            S_LED_2 : begin
                if (i_button[0])       nextState <= S_LED_0;
                else if (i_button [1]) nextState <= S_LED_3;
                else if (i_button [2]) nextState <= S_LED_1;
                else                   nextState <= S_LED_2;
            end
            S_LED_3 : begin
                if (i_button[0])       nextState <= S_LED_0;
                else if (i_button [1]) nextState <= S_LED_4;
                else if (i_button [2]) nextState <= S_LED_2;
                else                   nextState <= S_LED_3;
            end

            S_LED_4 : begin
                if (i_button[0])       nextState <= S_LED_0;
                else if (i_button [2]) nextState <= S_LED_3;
                else                   nextState <= S_LED_4;
            end
        endcase
    end

    always @(curState) begin
        r_lightState <= 3'bxxx;

        case (curState)
            S_LED_0 : r_lightState <= 3'd0;
            S_LED_1 : r_lightState <= 3'd1;
            S_LED_2 : r_lightState <= 3'd2;
            S_LED_3 : r_lightState <= 3'd3;
            S_LED_4 : r_lightState <= 3'd4;
        endcase
    end
endmodule
