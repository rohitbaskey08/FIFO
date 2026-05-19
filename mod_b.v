module mod_b(
 input clk,
 input rst,
 input empty,
 input [7:0] data_in,
 output reg [7:0] data_out,
 output reg rd_en
);

always @(posedge clk)
begin
    if(rst)
    begin
        data_out <= 8'b0;
        rd_en <= 1'b0;
    end
    else
    begin
        if(!empty)
        begin
            rd_en <= 1'b1;
            data_out <= data_in;
        end
        else
        begin
            rd_en <= 1'b0;
        end
    end
end

endmodule