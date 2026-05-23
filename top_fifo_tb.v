`timescale 1ns/1ps

module top_fifo_tb;

reg clk;
reg rst;
reg [7:0] data_top;

wire [7:0] data_out_top;
wire wr_en;
wire rd_en;
wire full;
wire empty;

// DUT Instantiation
top_fifo uut (
    .clk(clk),
    .rst(rst),
    .data_top(data_top),
    .data_out_top(data_out_top),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .full(full),
    .empty(empty)
);

// ==================================
// COVERAGE
// ==================================
covergroup fifo_cg @(posedge clk);
    option.per_instance =1;

    wr_cp : coverpoint wr_en {
        bins wr_on  = {1};
        bins wr_off = {0};
    }

    rd_cp : coverpoint rd_en {
        bins rd_on  = {1};
        bins rd_off = {0};
    }

    full_cp : coverpoint full {
        bins fifo_full     = {1};
        bins fifo_not_full = {0};
    }

    empty_cp : coverpoint empty {
        bins fifo_empty     = {1};
        bins fifo_not_empty = {0};
    }

    // Corner case
    wr_rd_cross : cross wr_en, rd_en;
    option.auto_bin_max =256;

endgroup

fifo_cg cg = new();

// Clock Generation
always #5 clk = ~clk;

// ==================================
// TESTCASE
// ==================================
initial begin

    clk = 0;
    rst = 1;
    data_top = 8'h00;

    // Reset
    #20 rst = 0;

    // Write data
    #10 data_top = 8'h11;
    #10 data_top = 8'h22;
    #10 data_top = 8'h33;
    #10 data_top = 8'h44;
    #100;

    $display("Coverage = %0.2f%%",
              cg.get_inst_coverage());

    $finish;
end

// ==================================
// MONITOR
// ==================================
initial begin
    $monitor(
    "T=%0t rst=%b wr=%b rd=%b full=%b empty=%b data_in=%h data_out=%h",
    $time,
    rst,
    wr_en,
    rd_en,
    full,
    empty,
    data_top,
    data_out_top
    );
end

endmodule