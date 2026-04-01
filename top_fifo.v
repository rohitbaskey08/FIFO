module top_fifo(
 input clk,
 input rst,
 input [7:0] data_top,
 output [7:0] data_out_top
);

wire [7:0] data_out_temp;
wire wr_en, rd_en;
wire full, empty;
wire [7:0] data_out_fifo;

mod_a mod1(
    .data_in(data_top),
    .clk(clk),
    .rst(rst),
    .data_out(data_out_temp),
    .wr_en(wr_en),
    .full(full)
    
);

fifo_8_8 fifo(
    .clk(clk),
    .rst(rst),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .data_in(data_out_temp),
    .data_out(data_out_fifo),
    .full(full),
    .empty(empty)
);

mod_b mod2(
    .clk(clk),
    .rst(rst),
    .empty(empty),        // CONNECT THIS
    .data_in(data_out_fifo),
    .data_out(data_out_top),
    .rd_en(rd_en)
);

endmodule