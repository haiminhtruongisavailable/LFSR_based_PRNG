module lfsr_top #(
    parameter SEED = 4'b1011
)(
    input  clk,
    input  rst,         
    input  i_enable,
    output reg [3:0] o_lfsr
);
    wire feedback;
    assign feedback = o_lfsr[1] ^ o_lfsr[0]; // polynomial taps

    always @(posedge clk or posedge rst) begin 
        if (rst)
            o_lfsr <= SEED;
        else if (i_enable)
            o_lfsr <= {feedback, o_lfsr[3:1]};
    end
endmodule