`include "mac_unit.v"

module tb_mac_unit;

    reg clk;
    reg rst;
    reg en;
    reg signed [7:0] X;
    reg signed [7:0] Y;
    reg acc_load;
    reg signed [31:0] Z;

    wire signed [31:0] Result;

    mac_unit uut (
        .clk(clk),
        .rst(rst),
        .en(en),
        .X(X),
        .Y(Y),
        .acc_load(acc_load),
        .Z(Z),
        .Result(Result)
    );

    always #5 clk = ~clk;

    initial begin

	$fsdbDumpvars();
        clk = 0;
        rst = 1;
        en = 0;
        X = 0; Y = 0; acc_load = 0; Z = 0;

        #10 rst = 0;
        en = 1;

        acc_load = 1; Z = 50; #10;
        acc_load = 0; X = 10; Y = 3; #10;
        #20;
        $display("Test Case 1 Result: %d", Result); // 80

        acc_load = 1; Z = -20; #10;
        acc_load = 0; X = -5; Y = 4; #10;
        #20;
        $display("Test Case 2 Result: %d", Result); // -40

        acc_load = 1; Z = 0; #10;
        acc_load = 0; X = 7; Y = -6; #10;
        #20;
        $display("Test Case 3 Result: %d", Result); // -42

        #10;
        $finish;
    end

endmodule

