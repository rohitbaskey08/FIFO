module fifo_8_8_tb;

reg clk;
reg rst;
reg [7:0] data_top;

wire [7:0] data_out_top;

// DUT
top_fifo dut(
    .clk(clk),
    .rst(rst),
    .data_top(data_top),
    .data_out_top(data_out_top)
);

// Clock generation
initial clk = 0;
always #5 clk = ~clk;


// Monitor internal signals using hierarchy
initial
$monitor("T=%0t data_in=%d data_out=%d wr=%b rd=%b full=%b empty=%b",
         $time,
         data_top,
         data_out_top,
         dut.wr_en,
         dut.rd_en,
         dut.full,
         dut.empty);


// Stimulus
initial
begin
    rst = 1;
    data_top = 0;
    #10;

    rst = 0;

    // Send multiple values
    repeat(12)
    begin
        #10 data_top = $random % 256;
    end

    #100;
    $finish;
end

endmodule