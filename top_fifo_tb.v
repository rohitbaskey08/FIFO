`timescale 1ns/1ps

module top_fifo_tb;

reg clk;
reg rst;
reg [7:0] data_top;

wire [7:0] data_out_top;

// DUT Instantiation
top_fifo uut (
    .clk(clk),
    .rst(rst),
    .data_top(data_top),
    .data_out_top(data_out_top)
);


// Clock Generation (10ns period)
always #5 clk = ~clk;

initial
begin
    // Initialize signals
    clk = 0;
    rst = 1;
    data_top = 8'b00000000;

    // Apply reset
    #20;
    rst = 0;

    // ==========================
    // Write Data 1
    // ==========================
    #10;
    data_top = 8'h11;   // Expected output: 11

    // ==========================
    // Write Data 2
    // ==========================
    #10;
    data_top = 8'h22;   // Expected output: 22

    // ==========================
    // Write Data 3
    // ==========================
    #10;
    data_top = 8'h33;   // Expected output: 33

    // ==========================
    // Write Data 4
    // ==========================
    #10;
    data_top = 8'h44;   // Expected output: 44

    // Wait for FIFO reads
    #100;

    // Stop simulation
    $finish;
end

// Monitor Values in Console
initial
begin
    $monitor(
        "Time=%0t | rst=%b | data_in=%h | data_out=%h",
        $time, rst, data_top, data_out_top
    );
end

endmodule