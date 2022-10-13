`timescale 1ns / 1ps

module top_LightStand
(
    input i_clk,
    input i_reset,
    input [2:0] i_button,
    output o_lightState
);

    wire w_clk;
    wire [9:0] w_counter;
    wire [3:0] w_x;
    wire [2:0] w_button;
    wire [2:0] w_lightState;
 
    Clock_Divider clkDiv
    (
        .i_clk(i_clk),
        .i_reset(i_reset),
        .o_clk(w_clk)
    );

    counter counter
    (
        .i_clk(w_clk),
        .i_reset(i_reset),
        .o_counter(w_counter)
    );

    Comparator compare
    (
        .i_counter(w_counter),
        .o_light_1(w_x[0]),
        .o_light_2(w_x[1]), 
        .o_light_3(w_x[2]), 
        .o_light_4(w_x[3])
    );

    Button_Controller btn1
    (
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_button(i_button[0]),
        .o_button(w_button[0])
    );

    Button_Controller btn2
    (
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_button(i_button[1]),
        .o_button(w_button[1])
    );

    Button_Controller btn3
    (
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_button(i_button[2]),
        .o_button(w_button[2])
    );

    FSM fsm   
    (
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_button(w_button),
        .o_lightState(w_lightState)
    );

    mux MUX
    (
        .i_x(w_x),
        .sel(w_lightState),
        .o_y(o_lightState)
    );
endmodule
