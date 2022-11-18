`timescale 1ns / 1ps



module tanjant(sayi1,sonuc, tasma,hazir, gecerli

    );
    input [31:0] sayi1;
    output tasma;
    output reg [63:0] sonuc;
    output reg hazir = 1'b0;
    output reg gecerli = 1'b0;
    wire t1, t2;
    wire [63:0] s1, s2;
    sinus sin(
    .sayi1(sayi1),
    .tasma(t1),
    .sonuc(s1));
    cosinus cos(
    .sayi1(sayi1),
    .tasma(t2),
    .sonuc(s2));
    and(tasma, t1, t2);
    initial
    begin
        sonuc=s1/s2;
        hazir=1;//islem bitince ana module gondermek uzere hazir ve gecerli cikisi mantik 1 yapildi
        gecerli=1;
    end
endmodule
