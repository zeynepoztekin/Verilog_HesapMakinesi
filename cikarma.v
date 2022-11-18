`timescale 1ns / 1ps


module cikarma(sayi1,
    sayi2,
    sonuc,
    tasma,
    hazir,
    gecerli
    
);
   
    input [31:0] sayi1, sayi2;
    
    output reg [63:0] sonuc;
    
    output reg tasma = 1'b0;
    output reg hazir = 1'b0;
    output reg gecerli = 1'b0;
    reg [64:0] ara_deger;
    reg carry= 1'b0;
    reg [31:0] complement;
    
    integer i;
    
    always @(sayi1 or sayi2)
    begin
        for(i=0 ; i<32 ; i = i+1) begin// sayi1'den sayi2 yi cikarmak icin sayi2'nin 2'ye tumleyeni alinmistir
            complement[i] = ~(sayi2[i]);
        end
        
        complement = (complement)+1;
        
        for(i=0 ; i<65 ; i = i+1) begin
            ara_deger[i] = 0;
        end
      
      
        for (i=0; i<32; i =i+1)//sayi2'nin tumleyeni alindiktan sonra toplama modulunde kullanilan islemler yapilmistir
        begin
            ara_deger[i+16] = (sayi1[i]^complement[i])^carry;
            tasma = (sayi1[i]&complement[i])|(complement[i]&carry)|(carry&sayi1[i]);
            carry = tasma;
        end
        sonuc = ara_deger[63:0];
        tasma=0;//cikarma isleminde bir tasma durumu olmadigindan tasma 0 a esitlenmistir
        hazir=1;//islem bitince ana module gondermek uzere hazir ve gecerli cikisi mantik 1 
        gecerli=1;
    
    
    
    end


endmodule