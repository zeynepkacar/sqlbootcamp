CREATE TABLE Members ( 
    uye_id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY, 
    kullanici_adi VARCHAR(50) UNIQUE NOT NULL, 
    sifre VARCHAR(255) NOT NULL, 
    e_posta VARCHAR(100) UNIQUE NOT NULL, 
    ad VARCHAR(50) NOT NULL, 
    soyad VARCHAR(50) NOT NULL, 
    kayit_tarihi TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
); 

CREATE TABLE Courses ( 
    egitim_id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY, 
    adi VARCHAR(200) NOT NULL, 
    aciklamasi TEXT, 
    baslangic_tarihi DATE, 
    bitis_tarihi DATE, 
    egitmen VARCHAR(100), 
    kayit_tarihi TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
); 

CREATE TABLE Categories ( 
    kategori_id SMALLINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY, 
    adi VARCHAR(100) UNIQUE NOT NULL, 
    aciklamasi VARCHAR(255), 
    ust_kategori_id SMALLINT, 
    FOREIGN KEY (ust_kategori_id) REFERENCES Categories(kategori_id) 
); 

CREATE TABLE Enrollments ( 
    kayit_id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY, 
    uye_id BIGINT NOT NULL, 
    egitim_id BIGINT NOT NULL, 
    kayit_tarihi TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    FOREIGN KEY (uye_id) REFERENCES Members(uye_id), 
    FOREIGN KEY (egitim_id) REFERENCES Courses(egitim_id), 
    UNIQUE (uye_id, egitim_id) 
); 

CREATE TABLE Certificates ( 
    sertifika_id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY, 
    sertifika_kodu VARCHAR(100) UNIQUE NOT NULL, 
    verilis_tarihi DATE, 
    kayit_tarihi TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
); 

CREATE TABLE CertificateAssignments ( 
    atama_id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY, 
    uye_id BIGINT NOT NULL, 
    sertifika_id BIGINT NOT NULL, 
    alinma_tarihi TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    FOREIGN KEY (uye_id) REFERENCES Members(uye_id), 
    FOREIGN KEY (sertifika_id) REFERENCES Certificates(sertifika_id), 
    UNIQUE (uye_id, sertifika_id) 
); 

CREATE TABLE BlogPosts ( 
    gonderi_id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY, 
    baslik VARCHAR(255) NOT NULL, 
    icerik TEXT, 
    yayin_tarihi TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    yazar_id BIGINT, 
    FOREIGN KEY (yazar_id) REFERENCES Members(uye_id) 
); 

-- Veri Ekleme Komutları 

INSERT INTO Members (kullanici_adi, sifre, e_posta, ad, soyad) 
VALUES 
('ali123', 'gizli123', 'ali.can@example.com', 'Ali', 'Can'), 
('ayse456', 'parola789', 'ayse.demir@example.com', 'Ayşe', 'Demir'), 
('veli.kaya', 'securepass', 'veli.kaya@sample.org', 'Veli', 'Kaya'), 
('fatma.yildiz', 'strongpwd', 'fatma.yildiz@test.net', 'Fatma', 'Yıldız'), 
('mehmet.oz', 'mysecret', 'mehmet.oz@work.com', 'Mehmet', 'Öz'); 

INSERT INTO Courses (adi, aciklamasi, baslangic_tarihi, bitis_tarihi, egitmen) 
VALUES 
('Temel Python Programlama', 'Python diline giriş ve temel kavramlar.', '2025-05-10', '2025-06-15', 'Ahmet Yılmaz'), 
('İleri Java Geliştirme', 'Java ileri seviye konular ve frameworkler.', '2025-06-01', '2025-07-30', 'Burak Şen'), 
('Veritabanı Yönetimi ve SQL', 'Veritabanı temelleri ve SQL sorgulama.', '2025-05-15', '2025-06-30', 'Cem Güneş'), 
('Web Tasarımı Temelleri (HTML, CSS)', 'HTML ve CSS kullanarak temel web sitesi oluşturma.', '2025-05-20', '2025-06-25', 'Deniz Ece'), 
('React ile Frontend Geliştirme', 'React kütüphanesi ile dinamik kullanıcı arayüzleri geliştirme.', '2025-07-01', '2025-08-15', 'Elif Kaya'); 

INSERT INTO Categories (adi, aciklamasi, ust_kategori_id) 
VALUES 
('Programlama', 'Yazılım geliştirme ile ilgili konular.', NULL), 
('Web Geliştirme', 'İnternet uygulamaları geliştirme.', 1), 
('Veritabanı', 'Veri depolama ve yönetimi.', 1), 
('Tasarım', 'Görsel ve kullanıcı deneyimi tasarımı.', NULL), 
('Mobil Geliştirme', 'Mobil uygulamalar geliştirme.', 1); 

INSERT INTO Enrollments (uye_id, egitim_id) 
VALUES 
(1, 1), 
(2, 1), 
(1, 3), 
(3, 2), 
(4, 4); 

INSERT INTO Certificates (sertifika_kodu, verilis_tarihi) 
VALUES 
('PYT101-2025', '2025-06-15'), 
('JAVA201-2025', '2025-07-30'), 
('SQL301-2025', '2025-06-30'), 
('WEB101-2025', '2025-06-25'), 
('REACT401-2025', '2025-08-15'); 

INSERT INTO CertificateAssignments (uye_id, sertifika_id) 
VALUES 
(1, 1), 
(2, 1), 
(3, 2), 
(1, 3), 
(4, 4); 

INSERT INTO BlogPosts (baslik, icerik, yazar_id) 
VALUES 
('Python ile İlk Adımlar', 'Python programlamaya yeni başlayanlar için temel bilgiler...', 1), 
('Javada Nesne Yönelimli Programlama', 'OOP kavramları ve Java uygulamaları...', 3), 
('SQL Sorgularında Performans İpuçları', 'Daha hızlı ve verimli SQL sorguları yazmak için öneriler.', 2), 
('HTML5 ve CSS3 ile Modern Web Siteleri', 'Yeni nesil web teknolojileri ile etkileyici tasarımlar.', 4), 
('React Komponentleri ve State Yönetimi', 'React uygulamalarında bileşen oluşturma ve veri akışı.', 5); 


ALTER TABLE Courses 
ADD COLUMN kategori_id SMALLINT, 
ADD CONSTRAINT fk_kategori FOREIGN KEY (kategori_id) REFERENCES Categories(kategori_id); 

-- Courses kayıtlarının kategori_id'sini güncelleyelim: 
UPDATE Courses SET kategori_id = 1 WHERE adi = 'Temel Python Programlama'; 
UPDATE Courses SET kategori_id = 1 WHERE adi = 'İleri Java Geliştirme'; 
UPDATE Courses SET kategori_id = 3 WHERE adi = 'Veritabanı Yönetimi ve SQL'; 
UPDATE Courses SET kategori_id = 2 WHERE adi = 'Web Tasarımı Temelleri (HTML, CSS)'; 
UPDATE Courses SET kategori_id = 2 WHERE adi = 'React ile Frontend Geliştirme';



