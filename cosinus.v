`timescale 1ns / 1ps


module cosinus(
       sayi1, sonuc, tasma
    );
    input [31:0] sayi1;
    output reg [63:0] sonuc;
    output reg tasma;
    
    real pozitif =2**(-32);
    real deger;
    reg temp;//boolean
    reg isaret;//0 ise pozitif 1 ise negatif olmas?n? tutacagim.
    initial
    begin
    //sinus degeri her zaman 1 ile 0 aras?nda gezer.
    //bu sebeple tasma her zaman 0'd?r.
        
        tasma=1'b0;
        temp=1'b1;
    end
    reg [15:0] tam, kusurat;
    real x;//radyanimizi real cinsine gecirmek icin
    real ara_deger;//taylor serisinin ifadesini surekli guncelleyerek bara degerde tutacagim
 
    integer n=0;// taylor serisindeki n
    integer i;// en asagidaki for dongusu icin
    real fact=1;//factoriyeli hesaplatmak icin 
    reg [63:0] son_deger;
    always@(sayi1)
    begin
        deger=0;
        tam=sayi1[31:16];
        kusurat=sayi1[15:0];
        x=tam+kusurat*(2**(-32));
        
        while(temp)
        begin
            if(n==0)
            begin
                fact=1;
            end
            if(n>=1)
            begin
                fact=fact*(2*n-1)*(2*n);
            end
            ara_deger=(x**(2*n))/fact;
            if(ara_deger>pozitif)
            begin
                if(n%2==0)
                begin
                    deger=deger+ara_deger;
                end
                else if(n%2==1)
                begin
                    deger=deger-ara_deger;
                end
                n=n+1; 
            end
            else if(ara_deger<=pozitif)
            begin
                temp=1'b0;
            end
                
            
              
        end
        //bunndan sonras? degeri 32 ye 32 tam ve kusurat?n? sonuca tas?ma islemi
        son_deger=0;
        if(deger<0)
        begin
            isaret=1'b1;
            deger=deger*(-1);
        end
        else if(deger>=0)
        begin
            isaret=1'b0;
        end
        //-1<=cos<=1 ve degeri yukar?da - ise + hale cevirdi?imden art?k
        //0<=cos<=1
        if(deger==1)
        begin
            son_deger[32]=1;
        end
        else if(1>deger>0)
        begin
            for(i=0;i<=31; i=i+1)
            begin
                deger=deger*2;
                if(deger>=1)
                begin
                    son_deger[31-i]=1;
                    deger=deger-1;
                end
                else if(deger<1)
                begin
                    son_deger[31-i]=0;
                end
            end
        end
        //isaret biti 1 ise sayinin 2 ye tumleyenini almam laz?m.
        if(isaret==1'b1)
        begin
            for(i=0; i<=63;i=i+1)
            begin
                son_deger[i]=~son_deger[i];
            end
            sonuc=son_deger+1;
        end
        else if(isaret==1'b0)
        begin
            sonuc=son_deger;
        end
    end
endmodule