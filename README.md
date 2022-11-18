# Verilog_HesapMakinesi

Verilog ile Hesap Makinesi Donanımı

## Proje Tasarımı

Projede toplam 10 modül tasarlanıldı.Toplama, çıkarma, çarpma, bölme , karekök alma, 
verilen radyan değerine göre tanjant ve kotanjant bulma işlemlerini yapan 9 tane modülün ana 
modülde saat uyumlu bir şekilde çalıştırılması sağlanıldı. Girdi olarak alınan 2 adet 32 bitlik 
sayi ve 2 bitlik tur girişi kullanılarak hesap makinesi beklenilen şekilde çalıştırıldı. Bu 
işlemler sonucunda 64 bitlik sonuc ve 1 bitlik tasma çıkışları elde edildi.
Girişlerden biri değiştiğinde çıkan sonuçlar da değişir. sayi1 ve sayi2, tur girişine göre işlem 
modüllerinde giriş olarak kullanılacaktır. Ek olarak, 1 bitlik giriş olarak aldığımız rst değeri, 
asenkron olarak devreyi sıfırlamaya yaramaktadır. rst girişi 1 geldiği anda sonuc çıkışın 
değeri 0 olarak güncellenecektir.

Tur girişinin durumlarına göre yapılacak işlem belirlenecektir.

000 – Toplama

001 – Çıkarma

010 –Çarpma

011 –Bölme

100 –Karekök

101 –Tanjant

110 –Kotanjant

111 –Önemsiz Durum

![Screenshot 2022-11-18 110428](https://user-images.githubusercontent.com/72623702/202651871-3340d80d-41a6-4654-9f1a-ce142aae6685.png)

### Toplama ve Çıkarma

Girdi olarak alınan sayi1 ve sayi2 değerlerindeki her bir bit 0. bitten başlanarak sırasıyla teker 
teker belirli mantık işlemleri yardımlarıyla toplama işlemi yapılmıştır.İşlemler sonucu çıkan 
elde değeri carry olarak belirlenen 1 bitlik değişkende tutulmuştur. İşlemler sonucunda çıkan 
değer tasma değerini bulmak için ilk önce 65 bit olarak tanımlanan aradeger'e tanımlanmıştır. 
65. bit tasma olarak alınıp geri kalan değer sonuç olarak bulunmuştur. Çıkarma işleminde ise 
sayi2'nin ilk önce ikiye tümleyeni alınarak toplama işleminde kullanılan kodlar 
tekrarlanmıştır.

### Çarpma

Çarpma işlemini yapan modülü tasarlarken Booth’un Çarpma Algoritması kullanılmıştır. Bu 
algoritmanın uygulanabilmesi için gerekli 5 giriş tanımlanmıştır:

• reg [63:0] carpan

• reg [31:0] carpilan

• reg [31:0] twos_complement_carpilan

• reg booth_bit

• reg ilk_bit

İşlemin en başında booth_bit 0 olarak alınmıştır. carpilan değişkeninin değeri, 32 bitlik sayi2 
girişine eşitlenmiştir. carpan değişkeninin ilk 32 biti 0 değerini alırken son 32 bitinde sayi1 
girişinin değeri bulunacaktır. ilk_bit değişkeni algoritmada kaydırma işlemi yapılırken işaretin 
korunması amacıyla kullanılacaktır.
Algoritmaya göre yapılan işlemde her turda booth_bit ile carpan değişkeninin son biti 
karşılaştırılmaktadır. 

• Eğer bu iki bit 00 veya 11 olarak gelmişse hiçbir işlem yapılmamaktadır. 

• booth_bit = 0 ve carpan[0] = 1 olarak geldiyse carpilan değeri, carpan değişkeninin ilk 
32 bitinden (carpan[63:32]) çıkarılmalıdır ve bulunan sonuç tekrar carpan[63:32] kısmına 
yazılacaktır. Burada twos_complement_carpilan değişkeni çıkarma işlemi yapabilmek 
amacıyla kullanılmıştır.

• Son olarak booth_bit = 1 ve carpan[0] = 0 ise carpilan değeri, carpan değişkeninin ilk 
32 biti ile (carpan[63:32]) toplanacaktır ve bulunan sonuç tekrar carpan[63:32] kısmına 
yazılacaktır. Eğer toplama sonucunda elde gelirse bu göz ardı edilmelidir.

Her tur bitişinde carpan değeri 1 sağa kaydırılacaktır ve bu aşamada carpan değerinin işareti 
dikkate alınarak kaydırma yapılmalıdır. Yani işaret korunmalıdır. booth_bit, carpan[0] bitine 
eşitlenecektir ve her turda güncellenmiş olacaktır.
Bu işlemler dizisi, girilen sayılar 32 bit olduğundan 32 tur dönmelidir ve bitişte carpan’ın 
içinde bulunan değer bize sonucu vermiş olacaktır.
Tek bitlik tasma çıkışı her zaman 0 olacaktır çünkü N bitlik bir sayıyla N bitlik bir sayının 
çarpımı en fazla 2N bittir. Girilen sayılar 32 bitlik ve sonuç çıkışı da 64 bitlik olacağından 
taşma olmayacaktır.

### Bolme 

Bölme
Bölme işlemini yapacak modülü tasarlarken kullanılan mantık, aslında elle kağıt üzerine 
yapılan bölmenin mantığına dayanmaktadır. Bu işlem yapılırken 6 adet değişken 
kullanılmıştır:

• reg [31:0] bolen

• reg [31:0] islemdeki_kalan

• reg [63:0] kalan

• reg [31:0] sonuc_ikinci_yari

• reg [31:0] twos_complement_bolen

• reg yeni_bit

32 bitlik bölen değişkeni, sayi2’nin değerine eşitlenmiştir. 64 bitlik kalan değişkeninin ilk 32 
biti 0’a, son 32 biti sayi1’in değerine eşitlenmiştir ve bu değişkenin üzerinden asıl işlem 
yapılacaktır. islemdeki_kalan ve sonuc_ikinci_yari değişkenleri, sonucun virgülden sonraki 
kısmını (son 32 bit) bulmak için kullanılacaktır.
İşlemin en başında yeni_bit = 0 olarak eşitlenmiştir. kalan, 1 kere sola kaydırılmıştır. İşleme 
başlanılmıştır.
Her turda kalan[63:32] değeri ile bolen değeri karşılaştırılmaktadır.

• Eğer bolen <= kalan ise (kalan[63:32] – bolen) işlemi yapılır ve sonucu kalan[63:32] 
kısmına yazılır. Ayrıca yeni_bit = 1 olur.

• Eğer bolen > kalan ise yeni_bit = 0 olur.
Yeni tura başlamadan önce kalan değişkeni 1 kere sola kaydırılır ve kalan[0] = yeni_bit 
yapılır. Bu işlem, sayılar 32şer bit olacağından 32 tur tekrarlanır.

sonuc[63:32] = kalan[31:0] olur.

kalan[63:32] değeri 1 kere sola kaydırılır ve bu, islemdeki_kalan değişkenine atanır. Bu değer 
işlemin kalanıdır. Yukarıda anlatılan algoritmanın aynısı aynı bolen değişkeni kullanılarak 
virgülden sonraki kısım bulmak için kullanılacaktır. İşlemin sonucu sonuc[31:0] kısmına 
eşitlenecektir.
N bitlik bir sayıyı N bitlik sayıya bölünürse sonuç 2N biti geçmeyeceğinden tasma çıkışı da 
her zaman 0 olacaktır.

### Karekök

Projeye başlarken karekökü bulmak için “if” ve “else” yapılarıyla bir sayının karekökünün 
kendisinin yarısından küçük olması esasına dayanarak verilog kodunu yazmak planlanıyordu 
ancak verilog da diğer kodlama dillerinde bulunan “double” ya da “float” değişkenlerinin 
birebir karşılığı bulunmadığından bu şekilde karekök hesaplaması yapıldığında hata oranının 
çok yüksek olduğu görüldü. Bunun üzerine yapılan araştırmalarda binary numaralarda 
karekökü bulunurken (0.5+0.5a)*2^(n) formatında bir formül kullanıldığı bulundu. Karekök işleminin kodunu temel olarak bu formüle dayalı olarak yapıldı. Buradaki “a” ifadesi binary 
olarak 0.1 ile 10 arasında bir değerdir. Karekökü alınacak olan sayı 0.1 ile 10 arasındaki bir 
değer ile 2^(2n) ifadesinin çarpımı formatına dönüştürülür. Ve (0.5+0.5a)*2^(n) formülü 
kullanılarak sayının karekökü bulunur. Bu formül kullanılarak bulunan karekök değerlerinin 
maksimum hata payı %6.1 olarak bulunur. Bu hata payının temel nedeni orijinali 
(0.485+0.485a)*2^(n) olan formülün (0.5+0.5a)*2^(n) formatına uyarlanmasıdır.

### Tanjant ve Kotanjant

Tanjant ve kotanjant hesaplaması için Taylor serisinin sinüs ve kosinüs formülleri kullanıldı.

tan(x) = sin(x)/cos(x)

cot(x) = cos(x)/sin(x)

tan(x)*cot(x) = 1 

Trigonometride kullanılan bu 3 eşitlik, modülleri birbirleri içerisinde kullanmamıza imkan 
verdi.Tanjant ve kotanjant sinüs ve kosinüs cinsinden tanımlanabildiği için sinüs ve kosinüs
modülleri tasarlanıldı.
Bu yöntemin seçilmesinin sebeplerinden biri tanjant ve kotanjantın Taylor serilerinin 
Verilog’a uyumunun daha zor olmasına karşın sinüs ve kosinüsün Taylor serilerinin Verilog’a 
uyumunun daha rahat olmasıdır. İkinci sebep ise tanjant ve kotanjantın Taylor serisi 
formüllerinde kullanılan radyan değeri için bir sınır varken aksine sinüs ve kosinüste böyle 
bir sınır yoktur.

![1](https://user-images.githubusercontent.com/72623702/202652979-1acb67ca-5c54-49ce-bb2f-197ae576ca64.png)


![2](https://user-images.githubusercontent.com/72623702/202652996-215aae9b-8903-416d-913f-235cc130a191.png)
