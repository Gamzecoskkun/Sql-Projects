create schema sinema;
use sinema;

create table film
(
film_id int primary key auto_increment not null,
film_adi varchar(100),
film_turu varchar(100),
sure int,
vizyonTarihi date 
);

create table salon 
(
salon_id int primary key,
salon_adi varchar(100),
kapasite int,
film_id int
);

create table personel
(
personel_id int primary key,
personel_ad varchar(100),
personel_soyad varchar(100)
);

create table koltuk
(
koltuk_id int primary key,
salon_id int
);

create table seans
(
seans_id int primary key,
seans_saat datetime
);

create table film_seans
(
film_seans_id int primary key,
film_id int,
seans_id int
);

create table bilet
(
bilet_id int primary key,
film_id int,
salon_id int,
seans_id int,
koltuk_id int,
biletTarih date,
musteri_id int,
personel_id int,
bilet_fiyat int
);

create table musteri
(
musteri_id int primary key,
musteri_adi varchar(100),
musteri_soyad varchar(100)
);

create table salon_seans
(
salon_seans_id int primary key,
salon_id int,
seans_id int
);

alter table bilet add constraint anahtar1 foreign key (film_id) references film(film_id);
alter table bilet add constraint anahtar2 foreign key (salon_id) references salon(salon_id);
alter table bilet add constraint anahtar3 foreign key (seans_id) references seans(seans_id);
alter table bilet add constraint anahtar4 foreign key(koltuk_id) references koltuk(koltuk_id);
alter table bilet add constraint anahtar5 foreign key(musteri_id) references musteri(musteri_id);
alter table bilet add constraint  anahtar6 foreign key(personel_id) references personel(personel_id);
alter table film_seans add constraint anahtar7 foreign key(film_id) references film(film_id); 
alter table film_seans add constraint anahtar8 foreign key(seans_id) references seans(seans_id);
alter table koltuk add constraint anahtar9 foreign key(salon_id) references salon(salon_id);
alter table salon add constraint anahtar10 foreign key(film_id) references film(film_id);
alter table salon_seans add constraint anahtar11 foreign key(seans_id) references seans(seans_id); 
alter table salon_seans add constraint anahtar12 foreign key(salon_id) references salon(salon_id);

insert into film values(1,'Bergen','Biyografi',140,'2022-03-04'),
                       (2,'Hızlı ve Öfkeli','Aksiyon',160,'2015-11-02'),
                       (3,'Sonsuz Aşk','Romantik',114,'2017-03-24'),
                       (4,'Av','Korku',90,'2020-11-04'),
                       (5,'Hayat','Bilim Kurgu',100,'2015-02-09');
                       
insert into salon values(10,'Salon1',100,1),
						(20,'Salon2',150,2),
                        (30,'Salon3',200,3),
                        (40,'Salon4',250,4),
                        (50,'Salon5',300,5);
                        
insert into personel values(6,'Mehmet','Çavuş'),
                            (7,'Ayşe','Varol'),
                            (8,'Gülşen','Güneş'),
                            (9,'Ali','Koç'),
                            (10,'Zeynep','Ay');
                            
insert into koltuk values(12,10),(14,20),(16,30),(18,40),(20,50);

insert into seans values(11,'2022-03-05 16:00:00'),
                        (13,'2015-11-03 18:00:00'),
                        (15,'2017-03-25 19:15:00'),
                        (17,'2020-11-05 20:00:00'),
                        (19,'2015-02-10 11:30:00');
                        
insert into film_seans values(23,1,11),
							 (24,2,13),
							 (25,3,15),
                             (26,4,17),
                             (27,5,19);
                             

                        
insert into musteri values(45,'Merve','Şen'),
						  (44,'Fatma','Gül'),
                          (43,'Mustafa','Usta'),
                          (42,'Fuat','Ak'),
                          (41,'İsmail','Üner');
                          
insert into salon_seans values(51,10,11),
							  (52,20,13),
                              (53,30,15),
                              (54,40,17),
                              (55,50,19);
                              
                              
insert into bilet values(32,1,10,11,12,'2022-03-05',41,6,30),
                        (33,2,20,13,14,'2015-11-03',42,7,35),
                        (34,3,30,15,16,'2017-03-25',43,8,35),
                        (35,4,40,17,18,'2020-11-05',44,9,25),
                        (36,5,50,19,20,'2015-02-10',45,10,45);
                              
-- (Alt Sorgu)
-- Film ismini bergen olanın süresini getirsin
select film.sure from film where film_adi =
											( select film_adi from film where film_id=1);
                                            
--  hayat filmin hangi salonda olduğu göstersin
select salon.salon_adi from salon where film_id in
												(select film_id from film where film_adi='Hayat' );
                                                
-- ismi mustafa olan müşterinin gittiği film
select film.film_adi from film where film_id =
											(select bilet.film_id from bilet where musteri_id =
                                            (select musteri.musteri_id from musteri where musteri_adi='Mustafa'));
                                            
-- kapasitesi 200 olan salonun isminin getirsin
select salon.salon_adi from salon where salon_id=
                                             (select salon_id from salon where kapasite=200);
                                             
-- (inner join)
-- Hızlı ve öfke filmine gidenin ismini ve soyismini getiren sorgu
Select musteri.musteri_adi, musteri.musteri_soyad from musteri inner join bilet on musteri.musteri_id=bilet.musteri_id inner join
film on bilet.film_id=film.film_id where film_adi="Hızlı ve Öfkeli";

-- salon2 de olan filmlerin listesi (views)

-- Wiew Görnümün sORGULar
create view film_view as 
select film.sure from film where film_adi =
										( select film_adi from film where film_id=1);

select* from film_view;

show tables; 
show full tables;

-- saklı yordam

-- film listesi 
delimiter //
CREATE PROCEDURE film_getir()
begin
select film.film_adi from film;
END //
delimiter ;
call film_getir;

-- bilet_id giren biletin hangi filme ait olduğuna gösteren sorgu

delimiter //
create procedure gidilenn_filmler(in bilet_no int)
begin
select musteri.musteri_adi,musteri.musteri_soyad,film.film_adi,bilet.bilet_id from bilet inner join film on bilet.film_id=film.film_id inner join 
musteri on bilet.musteri_id=musteri.musteri_id where bilet.bilet_id=bilet_no;
end //
delimiter ;

call gidilenn_filmler(32);
-- LOG işlemleri
create table islem_tarihcesi(
id int primary key auto_increment,
tablo varchar(50),
islem varchar(50),
islem_tarihi datetime);

DELIMITER //
create trigger film_log_insert after insert
on film
for each row
BEGIN
insert into islem_tarihcesi(tablo,islem,islem_tarihi) values ('Film','INSERT',date(now()));
END //
DELIMITER ;

DELIMITER //
create trigger film_log_update after update
on film
for each row
BEGIN
insert into islem_tarihcesi(tablo,islem,islem_tarihi) values ('Film','UPDATE',date(now()));
END //
DELIMITER ;

DELIMITER //
create trigger film_log_delete before delete
on film
for each row
BEGIN
insert into islem_tarihcesi(tablo,islem,islem_tarihi) values ('Film','DELETE',date(now()));
END //
DELIMITER ;