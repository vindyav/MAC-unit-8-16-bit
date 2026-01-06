module mac_unit (
    input  wire        clk,
    input  wire        rst,
    input  wire        en,
    input  wire signed [7:0]  X,
    input  wire signed [7:0]  Y,
    input  wire        acc_load,   
    input  wire signed [31:0] Z,
    output wire signed [31:0] Result
);

    reg signed [15:0] prod_reg;
    reg signed [31:0] prod_ext_reg;
    reg signed [31:0] acc_reg;

    always @(posedge clk) begin
        if (rst)
            prod_reg <= 16'sd0;
        else if (en)
            prod_reg <= acc_load ? 16'sd0 : X * Y;
    end

    always @(posedge clk) begin
        if (rst)
            prod_ext_reg <= 32'sd0;
        else if (en)
            prod_ext_reg <= acc_load ? 32'sd0 : prod_reg;
    end

    always @(posedge clk) begin
        if (rst)
            acc_reg <= 32'sd0;
        else if (en)
            acc_reg <= acc_load ? Z : acc_reg + prod_ext_reg;
    end

    assign Result = acc_reg;

endmodule

