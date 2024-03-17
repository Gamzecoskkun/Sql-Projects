create schema eczane;
use eczane;

create table personel
(
sicilNumarasi int  not null primary key, 
adi varchar(50),
soyadi varchar(50),
yasi int,
gorevBilgisi int,                         -- gorev tablosundan cekilecek
egitimBilgisi int,                        -- egitimDuzey tablosundan cekilecek
iseBaslamaTarihi varchar(10) not null,
istenAyrilmaTarihi varchar(10)
);

create table gorev
(
gorevNumarasi int not null primary key,
adi varchar(50)
);

create table egitimDuzey
(
egitimNumarasi int not null primary key,
egitimDuzey varchar(50)                  -- ilkokul,ortaokul,lise,universite
);

create table ilac
(
ilacKod int not null primary key,
ilacAdi varchar(50),
stokMiktari int,
sonKullanmaTarihi varchar(10),
aciklama varchar(100),
fiyat int
);

create table musteri
(
musteriNo int not null primary key,
musteriAd varchar(50),
musteriSoyad varchar(50),
egitimBilgisi int,                    -- egitimDuzey tablosundan cekilecek
adres varchar(200),
telefon varchar(11)
);

create table siparis
(
siparisNo int not null primary key,
musteriNo int,
ilacKod int,
personelNumarasi int,                -- personel tablosundan cekilecek
ilacAdeti int,
siparisTarihi varchar(10)
);

alter table personel add constraint anahtar1 foreign key (gorevBilgisi)  	references gorev(gorevNumarasi);
alter table personel add constraint anahtar2 foreign key (egitimBilgisi) 	references egitimDuzey(egitimNumarasi);
alter table musteri  add constraint anahtar3 foreign key (egitimBilgisi) 	references egitimDuzey(egitimNumarasi);
alter table siparis  add constraint anahtar4 foreign key (musteriNo)     	references musteri(musteriNo);
alter table siparis  add constraint anahtar5 foreign key (ilacKod)       	references ilac(ilacKod) ;
alter table siparis  add constraint anahtar6 foreign key (personelNumarasi) references personel(sicilNumarasi);


insert into personel(sicilNumarasi,adi,soyadi,yasi,gorevBilgisi,egitimBilgisi,iseBaslamaTarihi,istenAyrilmaTarihi) values (1,"gamze","coskun",21,1,4,'20-07-2018','20-07-2020'),
																														  (2,"ali","usta",22,2,3,'02-08-2020',null),
                                                                                                                          (3,"nazli","tok",28,3,2,'19-05-2018','27-07-2021'),
                                                                                                                          (4,"faruk","tanrikulu",53,4,1,'25-07-2008',null),
                                                                                                                          (5,"zehra","gul",30,5,5,'20-07-2015','10-07-2018'),
                                                                                                                          (6,"sena","sever",23,6,6,'20-03-2021',null),
                                                                                                                          (7,"eda","cakır",29,7,8,'20-07-2010','08-07-2020'),
                                                                                                                          (8,"zeynep","altun",20,8,7,'20-04-2017','09-05-2018'),
                                                                                                                          (9,"mustafa","coskun",40,9,10,'20-03-2018','08-07-2021'),
                                                                                                                          (10,"hakan","dural",26,10,9,'20-04-2016','01-07-2020'); -- personel tablosuna veri eklememizi saglar

insert into gorev(gorevNumarasi,adi) values (1,"hemsire"),
											(2,"doktor"),
                                            (3,"diyaliz"),
                                            (4,"ilk yardim"),
                                            (5,"eczacı"),
                                            (6,"fizyoterapist"),
                                            (7,"psikolog"),
                                            (8,"diyetisyen"),
                                            (9,"biyolog"),
                                            (10,"ebe"); -- gorev tablosundan veri eklememizi saglar
                                            
insert into egitimDuzey(egitimNumarasi,egitimDuzey) values  (1,"ilkokul"),
														    (2,"ortaokul"),
                                                            (3,"lise"),
                                                            (4,"onlisans"),
                                                            (5,"lisans"),
                                                            (6,"yuksek lisans"),
                                                            (7,"anaokulu"),
                                                            (8,"arastirma profesoru"),
                                                            (9,"ordinaryus"),
                                                            (10,"profesor"); -- egitimduzey tablosuna veri eklememizi saglar
                                                            
insert into ilac(ilacKod,ilacAdi,stokMiktari,sonKullanmaTarihi,aciklama,fiyat) values   (1,"Nurofen",50,'10-06,2030',"Grip İlaci",20),
                                                                                        (2,"Parol",50,'10-03-2025',"Agri Kesici",30),
                                                                                        (3,"Karmezapin",50,'10-09,2030',"Agri Kesici",35),
                                                                                        (4,"Tramadol",50,'10-06,2030',"Agri Kesici",25),
                                                                                        (5,"Muscoflex",50,'10-06,2038',"Kas Gevseti",20),
                                                                                        (6,"Dolares",50,'10-02,2018',"Agri Kesici",26),
                                                                                        (7,"Advil",50,'01-12,2010',"Agri Kesici",30),
																						(8,"Majezik",50,'13-05,2028',"Agri Kesici",50),
																						(9,"Aferin",50,'21-11,2020',"Agri Kesici",15),
																						(10,"Vermidon",50,'01-12,2010',"Agri Kesici",30); -- ilac tablosuna veri eklememizi saglar
                                                                                        
insert into musteri(musteriNo,musteriAd,musteriSoyad,egitimBilgisi,adres,telefon) values (1,"ibrahim","altin",6,"İstanbul/Uskudar",'05555555555'),
																						 (2,"gamze","ayak",7,"İstanbul/Umraniye",'05555555555'),
                                                                                         (3,"gul","gun",5,"İstanbul/Kadikoy",'05555555555'),
                                                                                         (4,"sebnem","gunes",2,"İstanbul/Pendik",'05555555555'),
                                                                                         (5,"bugra","dag",1,"İstanbul/Sancaktepe",'05555555555'),
                                                                                         (6,"aygun","kul",3,"İstanbul/Kartal",'05555555555'),
                                                                                         (7,"busra","koc",4,"İstanbul/Cekmekoy",'05555555555'),
                                                                                         (8,"hilal","soner",9,"İstanbul/Beykoz",'05555555555'),
                                                                                         (9,"huseyin","ozer",8,"İstanbul/Levent",'05555555555'),
                                                                                         (10,"eda","dagır",10,"İstanbul/Bagcilar",'05555555555'); -- musteri tablosuna veri eklememizi saglar
                                                                                         
insert into siparis(siparisNo,musteriNo,ilacKod,personelNumarasi,ilacAdeti,siparisTarihi) values (1,1,1,10,16,'18-01,2020'),
                                                                                                  (2,2,2,9,45,'18-01,2020'),
                                                                                                  (3,3,3,8,54,'18-01,2020'),
                                                                                                  (5,5,5,7,18,'18-01,2020'),
                                                                                                  (7,7,7,6,25,'18-01,2020'),
                                                                                                  (6,6,6,5,34,'18-01,2020'),
                                                                                                  (8,8,8,4,23,'18-01,2020'),
                                                                                                  (9,9,9,3,19,'18-01,2020'),
                                                                                                  (10,10,10,1,48,'18-01,2020'),
                                                                                                  (4,4,4,2,23,'18-01,2020'); -- siparis tablosuna veri eklememizi saglar
                                                                                                  
update ilac set fiyat=38 where ilacKod=1; -- ilac tablosunda ilac kodu 1 olanin fiyatini 38 olarak günceller

select musteri.musteriAd,musteri.musteriSoyad,ilac.ilacAdi
        FROM siparis join musteri join ilac 
        on siparis.musteriNo=musteri.musteriNo and siparis.ilacKod=ilac.ilacKod 
        where ilacAdi like 'A%' or 'D%'; -- İlaç adı A veya D ile başlayan ürünlerin hangi müşteriler tarafından alındığını ilaç adı bilgisi ile görüntüleyen sorguyu yazın.
        
        set foreign_key_checks=0;
        
select musteri.musteriAd,musteri.musteriSoyad,ilac.ilacAdi,siparis.ilacAdeti from siparis inner join ilac on siparis.ilacKod = ilac.ilacKod
																								  inner join musteri on siparis.musteriNo=musteri.MusteriNo
                                                                                                  order by siparis.ilacAdeti desc limit 1 ; -- En cok ilac alan musterinin bilgilerini ve ilacın bilgilerini getiren sorguyu yazın.

select egitimduzey.egitimDuzey , count(musteri.egitimBilgisi) as "musteri mezun bilgisi"from musteri inner join egitimduzey on egitimduzey.egitimNumarasi = musteri.egitimBilgisi
                                                                                                    group by  musteri.egitimBilgisi ;  -- Müşterileri eğitim düzeylerine göre kategorize eden sorguyu yazın.

select musteri.musteriAd,musteri.musteriSoyad,egitimduzey.egitimDuzey,ilac.ilacAdi,siparis.ilacAdeti
        as "Satılan İlaç Sayısı" from siparis inner join egitimduzey inner join ilac inner join musteri 
        on musteri.egitimBilgisi=egitimduzey.egitimNumarasi and ilac.ilacKod=siparis.ilacKod 
        and siparis.musteriNo=musteri.musteriNo group by egitimduzey.egitimDuzey order by ilacAdeti desc; -- Hangi eğitim düzeyinde hangi ilaç en çok alınmış kategorik olarak gösteren sorguyu yazın. 
        
select sum(ilac.fiyat*siparis.ilacAdeti) as fiyat,musteri.musteriAd,musteri.musteriSoyad,musteri.adres,musteri.telefon from siparis inner join musteri on musteri.musteriNo = siparis.musteriNo
																																	inner join ilac on ilac.ilacKod =siparis.ilacKod
                                                                                                                                    group by siparis.siparisNo order by fiyat desc; -- İlaçlara en çok ücret ödeyen müşteriden en az ücret ödeyen müşteriye doğru sıralama yapan sorguyu yazınız.

-- Bu soruların dışında 3 adet soru üretip yanıtlayınız

-- ilaç tablosunda kaç  stok miktarı var
select sum(stokMiktari) from ilac;

-- 25'den daha fazla fiyat bilgisine sahip olan veriler
select * from ilac where fiyat >25;

-- musteri tablosundaki musteri adlarını alfabeye göre sırala
select * from musteri order by musteriAd asc;

                                                                                                                                    


                                                                                                  
        
        
        

        
                                                                                                  

                                                                                                  
                                                                                        


