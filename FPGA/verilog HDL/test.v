module clock_gen(clk);
output clk;
reg clk;

parameter period =50,duty_cycle=50 ;

initial begin
    clk=1`b0;
end

always @() begin
    #(duty_cycle*period/100) clk=~clk
end

initial begin
    # 100 $finish
end

endmodule