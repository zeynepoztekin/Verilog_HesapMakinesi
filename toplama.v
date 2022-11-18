`timescale 1ns / 1ps


module toplama(sayi1,
    sayi2,
    sonuc,
    tur,
    tasma,
    hazir,
    gecerli
    
);

   
    input [31:0] sayi1, sayi2;
    input [2:0] tur;
    
    output reg [63:0] sonuc;

    
    output reg tasma = 1'b0; 
    output reg hazir = 1'b0;
    output reg gecerli = 1'b0;
    reg [64:0] ara_deger;
    reg carry= 1'b0;
    integer i;
    

    always @*
    begin
    
        for(i=0 ; i<65 ; i = i+1) begin //tasmayi bulmak icin tutulan ve islemlerin sonucu aktarilan ara degerin butun bitleri 0 a esitlenmistir
            ara_deger[i] = 0;
        end
    
        for (i=0; i<32; i =i+1)// sayi1 ve sayi2 nin sondaki bitlerinden baslanarak teker teker toplama islemi yapilmistir
        begin
            ara_deger[i+16] = (sayi1[i]^sayi2[i])^carry;
            tasma = (sayi1[i]&sayi2[i])|(sayi2[i]&carry)|(carry&sayi1[i]);//ustteki islemin sonucunda cikan tasma degeri hesaplanmistir
            carry = tasma;// bulunan tasma degeri diger turda kullanilmak icin carry degerine atanmistir
        end
       
        sonuc = ara_deger[63:0];// ara degerin 64 biti sonuca aktarilmistir
        hazir=1;//islem bitince ana module hazir icin mantik-1 cikisi gonderiliyor
        gecerli=1;//islem bitince ana module gecerlio icin mantik-1 cikisi gonderiliyor
    end
    


endmodule
