module Clock_divider(
    input  clock_in,
    output reg clock_out
);
    parameter Divisor = 28'd10_000_000; // 0.5 Hz output from 10 MHz . 2s/1 cycle
    reg [27:0] counter = 28'd0;

    always @(posedge clock_in) begin
        if (counter >= (Divisor - 1))
            counter <= 0;
        else
            counter <= counter + 1;

        clock_out <= (counter < (Divisor / 2)) ? 1'b0 : 1'b1;
    end
endmodule