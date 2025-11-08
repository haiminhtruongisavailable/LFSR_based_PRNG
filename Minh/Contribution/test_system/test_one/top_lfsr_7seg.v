module top_lfsr_7seg (
    input clock_10Mhz,
    input reset,
    input i_enable,
    output [3:0] Anode_Activate,
    output [6:0] LED_out
);
    wire slow_clk;
    wire [3:0] random_bits;

    Clock_divider clkdiv_inst (
        .clock_in(clock_10Mhz),
        .clock_out(slow_clk)
    );

    lfsr_top lfsr_inst (
        .clk(slow_clk),
        .rst(reset),
        .i_enable(i_enable),
        .o_lfsr(random_bits)
    );

    Seven_segment_LED_display_Controller display_inst (
        .clock_10Mhz(clock_10Mhz),
        .reset(reset),
        .binary_data(random_bits),
        .Anode_Activate(Anode_Activate),
        .LED_out(LED_out)
    );
endmodule