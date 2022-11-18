`timescale 1ns / 1ps

module bolme(
        input [31:0] sayi1,
        input [31:0] sayi2,
        output reg [63:0] sonuc,
        output reg tasma,
        output reg hazir = 1'b0,
        output reg gecerli = 1'b0
    );
    
    reg [31:0] bolen;
    reg [31:0] islemdeki_kalan;
    reg [63:0] kalan;
    reg [31:0] sonuc_ikinci_yari;
    reg [31:0] twos_complement_bolen;
    integer i;
    reg yeni_bit = 0;
    
    always@(*) begin
        bolen = sayi2;
        kalan[31:0] = sayi1;
        kalan[63:32] = 32'd0;
    
        for(i=0 ; i<32 ; i = i+1) begin
            twos_complement_bolen[i] = ~(bolen[i]);
        end 
        
        twos_complement_bolen = (twos_complement_bolen) + 1;
        kalan = kalan<<1;
        kalan[0] = yeni_bit;
        
        for(i = 0; i<32; i = i+1) begin
            if(bolen > kalan[63:32]) begin
                yeni_bit = 0;
            end  
            
            else if(bolen <= kalan[63:32]) begin
                yeni_bit = 1;
                kalan[63:32] = kalan[63:32] + twos_complement_bolen;
            end  
           
            kalan = kalan<<1;
            kalan[0] = yeni_bit;
        end
        
        tasma = 0;
        sonuc[63:32] = kalan[31:0];
        
        islemdeki_kalan[31:0] = kalan[63:32];
        islemdeki_kalan = islemdeki_kalan>>1;
        
        kalan[31:0] = islemdeki_kalan;
        kalan[63:32] = 32'd0;
        yeni_bit = 0;
        
        kalan = kalan<<1;
        kalan[0] = yeni_bit;
        
        sonuc_ikinci_yari = 32'd0;
        for(i = 0; i<32; i = i+1) begin
            if(bolen > kalan[63:32]) begin
                yeni_bit = 0;
                sonuc_ikinci_yari[0] = 0;
            end  
            
            else if(bolen <= kalan[63:32]) begin
                yeni_bit = 1;
                sonuc_ikinci_yari[0] = 1;
                kalan[63:32] = kalan[63:32] + twos_complement_bolen;
            end  
       
            kalan = kalan<<1;
            kalan[0] = yeni_bit;
            sonuc_ikinci_yari = sonuc_ikinci_yari<<1;
        end
        
        sonuc[31:0] = sonuc_ikinci_yari;
        hazir=1;//islem bitince ana module gondermek uzere hazir ve gecerli cikisi mantik 1 
        gecerli=1;
    end
       
endmodule
