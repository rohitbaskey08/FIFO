module mod_a(
 input [7:0] data_in,
 input clk,
 input rst,
 input full,
 output reg [7:0] data_out,
 output reg wr_en
);

always @(posedge clk)
begin
    if(rst ^ full)
    begin
        data_out <= 0;
        wr_en <= 0;
    end
    else
    begin
        data_out <= data_in;
        wr_en <= 1;
    end
end
endmodule