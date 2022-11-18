`timescale 1ns / 1ps

module topmodule(
    input clk,
    input rst,
    input [2:0] tur,
    input [31:0] sayi1,
    input [31:0] sayi2,
    output reg hazir=1,
    output reg [63:0] sonuc,
    output reg tasma,
    output reg gecerli=0  
    );
    
   //modullerden cikislarin tutulacagi matrisler
   wire [63:0] sonuc_matrisi [6:0];
   wire [6:0] tasma_matrisi;
   wire [6:0] hazir_matrisi;
   wire [6:0] gecerli_matrisi;
   
   
   //sirasiyle butun modulleri cagirip sirasiyla tanimladigimiz matrislere esitledik
   toplama mod1(sayi1, sayi2, sonuc_matrisi[0], tasma_matrisi[0], hazir_matrisi[0], gecerli_matrisi[0]);
   cikarma mod2(sayi1, sayi2, sonuc_matrisi[1], tasma_matrisi[1], hazir_matrisi[1], gecerli_matrisi[1]);
   carpma mod3(sayi1, sayi2, sonuc_matrisi[2], tasma_matrisi[2], hazir_matrisi[2], gecerli_matrisi[2]);
   bolme mod4(sayi1, sayi2, sonuc_matrisi[3], tasma_matrisi[3], hazir_matrisi[3], gecerli_matrisi[3]);
   karekok mod5(sayi1, sayi2, sonuc_matrisi[4], tasma_matrisi[4], hazir_matrisi[4], gecerli_matrisi[4]);
   tanjant mod6(sayi1, sayi2, sonuc_matrisi[5], tasma_matrisi[5], hazir_matrisi[5], gecerli_matrisi[5]);
   kotanjant mod7(sayi1, sayi2, sonuc_matrisi[6], tasma_matrisi[6], hazir_matrisi[6], gecerli_matrisi[6]);
   
   //bulunan degerleri atamak icin tutulan reg degerleri
   reg tasma_sonraki, hazir_sonraki, gecerli_sonraki;
   reg [63:0] sonuc_sonraki;
   
   always @* begin
        
        if(!rst)//rst girisinin 0 oldugu durumlarda calistirdik
        begin
            case(tur)//tur girisine gore yapilan islem sonuc tasma hazir gecerli cikislarini belirlenen reg degiskenlerine esitledik
            3'b000:begin sonuc_sonraki=sonuc_matrisi[0]; tasma_sonraki=tasma_matrisi[0];hazir_sonraki=hazir_matrisi[0];gecerli_sonraki=gecerli_matrisi[0];end
            3'b001:begin sonuc_sonraki=sonuc_matrisi[1]; tasma_sonraki=tasma_matrisi[1];hazir_sonraki=hazir_matrisi[1];gecerli_sonraki=gecerli_matrisi[1];end
            3'b010:begin sonuc_sonraki=sonuc_matrisi[2]; tasma_sonraki=tasma_matrisi[2];hazir_sonraki=hazir_matrisi[2];gecerli_sonraki=gecerli_matrisi[2];end
            3'b011:begin sonuc_sonraki=sonuc_matrisi[3]; tasma_sonraki=tasma_matrisi[3];hazir_sonraki=hazir_matrisi[3];gecerli_sonraki=gecerli_matrisi[3];end
            3'b100:begin sonuc_sonraki=sonuc_matrisi[4]; tasma_sonraki=tasma_matrisi[4];hazir_sonraki=hazir_matrisi[4];gecerli_sonraki=gecerli_matrisi[4];end
            3'b101:begin sonuc_sonraki=sonuc_matrisi[5]; tasma_sonraki=tasma_matrisi[5];hazir_sonraki=hazir_matrisi[5];gecerli_sonraki=gecerli_matrisi[5];end
            3'b110:begin sonuc_sonraki=sonuc_matrisi[6]; tasma_sonraki=tasma_matrisi[6];hazir_sonraki=hazir_matrisi[6];gecerli_sonraki=gecerli_matrisi[6];end
            endcase
        end
        else begin//rst girisi 1 oldugu durumda hazir gecerli cikisini 1'e sonuc cikisini 0'a esitledik
            hazir_sonraki=1;
            gecerli_sonraki=1;
            sonuc_sonraki=0;
        end
   end
   
   
   always @(posedge clk)//her clk vurusunda cikislar guncellenecektir
   begin
   
        tasma<= tasma_sonraki;
        hazir<= hazir_sonraki;
        gecerli<= gecerli_sonraki;
        sonuc<= sonuc_sonraki;
   
   end
   
   
    
endmodule

