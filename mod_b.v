module mod_b(
 input clk,
 input rst,
 input empty,
 input [7:0] data_in,
 output reg [7:0] data_out,
 output reg rd_en
);

parameter idle = 2'b00;
parameter s1 = 2'b01;
parameter data_state = 2'b10;

reg [1:0] ps, ns;

always @(posedge clk)
begin
    if(rst)
        ps <= idle;
    else
        ps <= ns;
end

always @(*)
begin
    ns = ps;
    rd_en = 0;

    case(ps)

        idle: ns = s1;

        s1: ns = data_state;

        data_state:
        begin
            ns = idle;
            if(!empty)
                rd_en = 1;
        end

    endcase
end

always @(posedge clk)
begin
    if(rst)
        data_out <= 0;
    else if(rd_en)
        data_out <= data_in;
end

endmodule