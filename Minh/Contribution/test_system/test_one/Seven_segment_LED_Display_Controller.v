module Seven_segment_LED_display_Controller (
    input clock_10Mhz,
    input reset,
    input [3:0] binary_data,  // 4-bit binary input
    output reg [3:0] Anode_Activate,
    output reg [6:0] LED_out
);
    reg [19:0] refresh_counter;
    wire [1:0] active_digit;
    reg bit_to_display;

    always @(posedge clock_10Mhz or posedge reset) begin
        if (reset)
            refresh_counter <= 0;
        else
            refresh_counter <= refresh_counter + 1;
    end

    assign active_digit = refresh_counter[19:18];

    always @(*) begin
        case (active_digit)
            2'b00: begin
                Anode_Activate = 3'b001; // rightmost digit
                bit_to_display = binary_data[3];
            end
            2'b01: begin
                Anode_Activate = 3'b010;
                bit_to_display = binary_data[2];
            end
            2'b10: begin
                Anode_Activate = 3'b011;
                bit_to_display = binary_data[1];
            end
            2'b11: begin
                Anode_Activate = 3'b100; // leftmost digit
                bit_to_display = binary_data[0];
            end
        endcase
    end

    // show "1" or "0" on 7-seg
    always @(*) begin
        case (bit_to_display)
            1'b0: LED_out = 7'b0111111; // "0"
            1'b1: LED_out = 7'b0000110; // "1"
            default: LED_out = 7'b0000000;
        endcase
    end
endmodule


