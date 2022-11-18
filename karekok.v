`timescale 1ns / 1ps


module karekok
(sayi,sonuc,tasma,a,hazir,gecerli

    );
    input [31:0] sayi;
    output reg [63:0] sonuc;
    output reg tasma;
    output reg [63:0] a;
    output reg hazir = 1'b0;
    output reg gecerli = 1'b0;
    always@(*)begin
    if(sayi[31:16]>=0 && sayi[31:16]<2)begin
    a=sayi[16]*(2**(0));
    sonuc[63:32]=a;
    sonuc[31:16]=sayi[15:0]*(2**15);
    sonuc[15:0]='b0;
    tasma=1'b0;
    end
    if(sayi[31:16]>=2 && sayi[31:16]<4)begin
    a=0;
    sonuc[63:32]=1+a;
    sonuc[31:30]=sayi[17:16];
    sonuc[29:0]=sayi[15:0]*(2**13);
    tasma=1'b0;
    end
    if(sayi[31:16]>=4 && sayi[31:16]<8)begin
    a=sayi[18]*(2**(0));
    sonuc[63:32]=1+a;
    sonuc[31:30]=sayi[17:16];
    sonuc[29:0]=sayi[15:0]*(2**13);
    tasma=1'b0;
    end
    if(sayi[31:16]>=8 && sayi[31:16]<16)begin
    a=sayi[19]*(2**(0));
    sonuc[63:32]=2+a;
    sonuc[28:0]=sayi[15:0]*(2**12);
    sonuc[31:29]=sayi[18:16];
    tasma=1'b0;
    end
    if(sayi[31:16]>=16 && sayi[31:16]<32)begin
    a=sayi[20]*(2**(1))+sayi[19]*(2**(0));
    sonuc[63:32]=2+a;
    sonuc[28:0]=sayi[15:0]*(2**12);
    sonuc[31:29]=sayi[18:16];
    tasma=1'b0;
    end
    if(sayi[31:16]>=32 && sayi[31:16]<64)begin
    a=sayi[21]*(2**(1))+sayi[20]*(2**(0));
    sonuc[63:32]=4+a;
    sonuc[27:0]=sayi[15:0]*(2**(11));
    sonuc[31:28]=sayi[19:16];
    tasma=1'b0;
    end
    if(sayi[31:16]>=64 && sayi[31:16]<128)begin
    a=sayi[22]*(2**(2))+sayi[21]*(2**(1))+sayi[20]*(2**(0));
    sonuc[63:32]=4+a;
    sonuc[27:0]=sayi[15:0]*(2**(11));
    sonuc[31:28]=sayi[19:16];
    tasma=1'b0;
    end
    if(sayi[31:16]>=128 && sayi[31:16]<256)begin
    a=4*sayi[23]*(2**(0))+sayi[22]*(2**(1))+sayi[21]*(2**(0));
    sonuc[63:32]=8+a;
    sonuc[26:0]=sayi[15:0]*(2**(10));
    sonuc[31:27]=sayi[20:16];
    tasma=1'b0;
    end
    if(sayi[31:16]>=256 && sayi[31:16]<512)begin
    a=8*sayi[24]*(2**(0))+sayi[23]*(2**(2))+sayi[22]*(2**(1))+sayi[21]*(2**(0));
    sonuc[63:32]=8+a;
    sonuc[26:0]=sayi[15:0]*(2**(10));
    sonuc[31:27]=sayi[20:16];
    tasma=1'b0;
    end
    if(sayi[31:16]>=512 && sayi[31:16]<1024)begin
    a=8*sayi[25]*(2**(0))+sayi[24]*(2**(2))+sayi[23]*(2**(1))+sayi[22]*(2**(0));
    sonuc[63:32]=16+a;
    sonuc[25:0]=sayi[15:0]**(2**(9));
    sonuc[31:26]=sayi[21:16];
    tasma=1'b0;
    end
    if(sayi[31:16]>=1024 && sayi[31:16]<2048)begin
    a=16*sayi[26]*(2**(0))+sayi[25]*(2**(3))+sayi[24]*(2**(2))+sayi[23]*(2**(1))+sayi[22]*(2**(0));
    sonuc[63:32]=16+a;
    sonuc[25:0]=sayi[15:0]*(2**(9));
    sonuc[31:26]=sayi[21:16];
    tasma=1'b0;
    end
    if(sayi[31:16]>=2048 && sayi[31:16]<4096)begin
    a=16*sayi[27]*(2**(0))+sayi[26]*(2**(3))+sayi[25]*(2**(2))+sayi[24]*(2**(1))+sayi[23]*(2**(0));
    sonuc[63:32]=32+a;
    sonuc[24:0]=sayi[15:0]*(2**(8));
    sonuc[31:25]=sayi[22:16];
    tasma=1'b0;
    end
    if(sayi[31:16]>=4096 && sayi[31:16]<8192)begin
    a=32*sayi[28]*(2**(0))+sayi[27]*(2**(4))+sayi[26]*(2**(3))+sayi[25]*(2**(2))+sayi[24]*(2**(1))+sayi[23]*(2**(0));
    sonuc[63:32]=32+a;
    sonuc[24:0]=sayi[15:0]*(2**(8));
    sonuc[31:25]=sayi[22:16];
    tasma=1'b0;
    end
    if(sayi[31:16]>=8192 && sayi[31:16]<16384)begin
    a=sayi[29]*(2**(5))+sayi[28]*(2**(4))+sayi[27]*(2**(3))+sayi[26]*(2**(2))+sayi[25]*(2**(1))+sayi[24]*(2**(0));
    sonuc[63:32]=64+a;
    sonuc[23:0]=sayi[15:0]*(2**(7));
    sonuc[31:24]=sayi[23:16];
    tasma=1'b0;
    end
    if(sayi[31:16]>=16384 && sayi[31:16]<32768)begin
    a=sayi[30]*(2**(6))+sayi[29]*(2**(5))+sayi[28]*(2**(4))+sayi[27]*(2**(3))+sayi[26]*(2**(2))+sayi[25]*(2**(1))+sayi[24]*(2**(0));
    sonuc[63:32]=64+a;
    sonuc[23:0]=sayi[15:0]*(2**(7));
    sonuc[31:24]=sayi[23:16];
    tasma=1'b0;
    end
    if(sayi[31:16]>=32768 && sayi[31:16]<65536)begin
    a=sayi[31]*(2**(6))+sayi[30]*(2**(5))+sayi[29]*(2**(4))+sayi[28]*(2**(3))+sayi[27]*(2**(2))+sayi[26]*(2**(1))+sayi[25]*(2**(0));
    sonuc[63:32]=128+a;
    sonuc[24:0]=sayi[15:0]*(2**(8));
    sonuc[31:23]=sayi[24:16];
    tasma=1'b0;
    hazir=1;//islem bitince ana module gondermek uzere hazir ve gecerli cikisi mantik 1 
    gecerli=1;
    end
    
 
 end
 endmodule
