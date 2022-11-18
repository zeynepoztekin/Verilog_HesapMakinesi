`timescale 1ns / 1ps

module carpma(
        input [31:0] sayi1,
        input [31:0] sayi2,
        output reg [63:0] sonuc,
        output reg tasma,
        output reg hazir = 1'b0,
        output reg gecerli = 1'b0
    );
    
    reg [63:0] carpan;
    reg [31:0] carpilan;
    reg [31:0] twos_complement_carpilan;
    reg booth_bit;
    reg ilk_bit;
    integer i;
    
    
    always@(*) begin
        for(i=63 ; i>31 ; i = i-1) begin
            carpan[i] = 0;
        end
        
        booth_bit = 0;
        carpilan = sayi1;   
        carpan[31:0] = sayi2;
        tasma = 0;
        
        for(i=0 ; i<32 ; i = i+1) begin
            twos_complement_carpilan[i] = ~(carpilan[i]);
        end 
        twos_complement_carpilan = (twos_complement_carpilan) + 1;
        
        
               
        for(i=0 ; i<32 ; i = i+1) begin
            if(booth_bit == 0 && carpan[0] == 1) begin
                carpan[63:32] = carpan[63:32] + twos_complement_carpilan;
            end
            
            else if(booth_bit == 1 && carpan[0] == 0) begin
                carpan[63:32] = carpan[63:32] + carpilan;
            end
            
            ilk_bit = carpan[63];
            booth_bit = carpan[0];
            carpan = carpan >> 1;
            carpan[63] = ilk_bit;
        end 
        
        sonuc = carpan;
        tasma = 0;
        hazir=1;//islem bitince ana module gondermek uzere hazir ve gecerli cikisi mantik 1 
        gecerli=1;
    end
   
endmodule


