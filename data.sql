-- --------------------------------------------------------
-- Sunucu:                       127.0.0.1
-- Sunucu sürümü:                8.4.3 - MySQL Community Server - GPL
-- Sunucu İşletim Sistemi:       Win64
-- HeidiSQL Sürüm:               12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- appapartman için veritabanı yapısı dökülüyor
CREATE DATABASE IF NOT EXISTS `appapartman` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `appapartman`;

-- tablo yapısı dökülüyor appapartman.aidat
CREATE TABLE IF NOT EXISTS `aidat` (
  `aidat_no` int NOT NULL AUTO_INCREMENT,
  `site_no` int NOT NULL,
  `daire_no` int NOT NULL,
  `aidat_tipi_no` int NOT NULL,
  `donem_yil` smallint NOT NULL,
  `donem_ay` tinyint NOT NULL,
  `tutar` decimal(10,2) NOT NULL,
  `odenen_tutar` decimal(10,2) NOT NULL DEFAULT '0.00',
  `son_odeme_tarihi` date NOT NULL,
  `durum` enum('BEKLIYOR','KISMI_ODENDI','ODENDI','GECIKMIS','IPTAL') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'BEKLIYOR',
  `otomatik_islendi_mi` tinyint(1) NOT NULL DEFAULT '0',
  `olusturma_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `guncellenme_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`aidat_no`),
  UNIQUE KEY `daire_no` (`daire_no`,`donem_yil`,`donem_ay`,`aidat_tipi_no`),
  KEY `aidat_tipi_no` (`aidat_tipi_no`),
  KEY `idx_aidat_site_donem` (`site_no`,`donem_yil`,`donem_ay`),
  KEY `idx_aidat_site_durum` (`site_no`,`durum`),
  KEY `idx_aidat_daire_durum` (`daire_no`,`durum`),
  KEY `idx_aidat_son_odeme` (`son_odeme_tarihi`,`durum`),
  CONSTRAINT `aidat_ibfk_1` FOREIGN KEY (`site_no`) REFERENCES `site` (`site_no`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `aidat_ibfk_2` FOREIGN KEY (`daire_no`) REFERENCES `daire` (`daire_no`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `aidat_ibfk_3` FOREIGN KEY (`aidat_tipi_no`) REFERENCES `aidat_tipi` (`tip_no`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.aidat: ~11 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `aidat` (`aidat_no`, `site_no`, `daire_no`, `aidat_tipi_no`, `donem_yil`, `donem_ay`, `tutar`, `odenen_tutar`, `son_odeme_tarihi`, `durum`, `otomatik_islendi_mi`, `olusturma_tarihi`, `guncellenme_tarihi`) VALUES
	(1, 1, 1, 1, 2026, 9, 1500.00, 1500.00, '2026-09-30', 'ODENDI', 1, '2026-09-27 16:08:57', '2026-09-27 16:08:57'),
	(2, 1, 2, 1, 2026, 9, 1800.00, 0.00, '2026-09-30', 'BEKLIYOR', 1, '2026-09-27 16:08:57', '2026-09-27 23:34:09'),
	(3, 1, 3, 1, 2026, 9, 1500.00, 1500.00, '2026-09-30', 'ODENDI', 1, '2026-09-27 16:08:57', '2026-09-27 16:08:57'),
	(4, 1, 4, 1, 2026, 9, 1500.00, 0.00, '2026-09-30', 'BEKLIYOR', 1, '2026-09-27 16:08:57', '2026-09-27 16:08:57'),
	(5, 2, 5, 1, 2026, 9, 2000.00, 0.00, '2026-09-30', 'BEKLIYOR', 1, '2026-09-27 16:08:57', '2026-09-27 16:08:57'),
	(6, 2, 6, 1, 2026, 9, 2000.00, 0.00, '2026-09-30', 'GECIKMIS', 1, '2026-09-27 16:08:57', '2026-09-27 16:08:57'),
	(7, 1, 1, 1, 2026, 8, 1500.00, 1500.00, '2026-08-30', 'ODENDI', 1, '2026-09-27 16:08:57', '2026-09-27 16:08:57'),
	(8, 1, 1, 1, 2027, 1, 1500.00, 0.00, '2027-01-31', 'BEKLIYOR', 1, '2026-09-27 23:25:09', '2026-09-27 23:25:09'),
	(9, 1, 2, 1, 2027, 1, 1800.00, 0.00, '2027-01-31', 'BEKLIYOR', 1, '2026-09-27 23:25:09', '2026-09-27 23:25:09'),
	(10, 1, 3, 1, 2027, 1, 1500.00, 0.00, '2027-01-31', 'BEKLIYOR', 1, '2026-09-27 23:25:09', '2026-09-27 23:25:09'),
	(11, 1, 4, 1, 2027, 1, 1500.00, 0.00, '2027-01-31', 'BEKLIYOR', 1, '2026-09-27 23:25:09', '2026-09-27 23:25:09');

-- tablo yapısı dökülüyor appapartman.aidat_tipi
CREATE TABLE IF NOT EXISTS `aidat_tipi` (
  `tip_no` int NOT NULL AUTO_INCREMENT,
  `ad` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `aciklama` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `periyodik_mi` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`tip_no`),
  UNIQUE KEY `ad` (`ad`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.aidat_tipi: ~6 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `aidat_tipi` (`tip_no`, `ad`, `aciklama`, `periyodik_mi`) VALUES
	(1, 'NORMAL_AIDAT', 'Aylik normal aidat', 1),
	(2, 'DEMIRBAS_KATILIM', 'Demirbas katilim payi', 0),
	(3, 'EK_HIZMET', 'Otopark/spor salonu vb.', 1),
	(4, 'AVANS', 'Pesin odenen aidat', 0),
	(5, 'SU_FATURA', 'Sayac bazli su', 1),
	(6, 'DOGALGAZ_FATURA', 'Sayac bazli dogalgaz', 1);

-- tablo yapısı dökülüyor appapartman.alembic_version
CREATE TABLE IF NOT EXISTS `alembic_version` (
  `version_num` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.alembic_version: ~0 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `alembic_version` (`version_num`) VALUES
	('0001_baseline');

-- tablo yapısı dökülüyor appapartman.anahtar_teslim
CREATE TABLE IF NOT EXISTS `anahtar_teslim` (
  `teslim_no` int NOT NULL AUTO_INCREMENT,
  `daire_no` int NOT NULL,
  `anahtar_tipi` enum('DAIRE','BINA_GIRIS','OTOPARK','POSTA_KUTUSU','DIGER') COLLATE utf8mb4_unicode_ci NOT NULL,
  `adet` tinyint NOT NULL DEFAULT '1',
  `teslim_edilen_kullanici_no` int DEFAULT NULL,
  `teslim_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `iade_tarihi` datetime DEFAULT NULL,
  `aciklama` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`teslim_no`),
  KEY `daire_no` (`daire_no`),
  KEY `teslim_edilen_kullanici_no` (`teslim_edilen_kullanici_no`),
  CONSTRAINT `anahtar_teslim_ibfk_1` FOREIGN KEY (`daire_no`) REFERENCES `daire` (`daire_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `anahtar_teslim_ibfk_2` FOREIGN KEY (`teslim_edilen_kullanici_no`) REFERENCES `kullanici` (`kullanici_no`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.anahtar_teslim: ~3 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `anahtar_teslim` (`teslim_no`, `daire_no`, `anahtar_tipi`, `adet`, `teslim_edilen_kullanici_no`, `teslim_tarihi`, `iade_tarihi`, `aciklama`) VALUES
	(1, 1, 'DAIRE', 2, 4, '2026-09-27 16:08:57', NULL, '2 adet daire anahtari teslim edildi'),
	(2, 1, 'BINA_GIRIS', 1, 4, '2026-09-27 16:08:57', NULL, 'Ortak giris anahtari'),
	(3, 3, 'DAIRE', 1, 5, '2026-09-27 16:08:57', NULL, 'Kiralayan tarafindan teslim');

-- tablo yapısı dökülüyor appapartman.anket
CREATE TABLE IF NOT EXISTS `anket` (
  `anket_no` bigint NOT NULL AUTO_INCREMENT,
  `site_no` int NOT NULL,
  `soru` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `aciklama` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `baslangic_tarihi` datetime NOT NULL,
  `bitis_tarihi` datetime NOT NULL,
  `olusturan_no` int NOT NULL,
  `aktif_mi` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`anket_no`),
  KEY `olusturan_no` (`olusturan_no`),
  KEY `idx_anket_site_tarih` (`site_no`,`bitis_tarihi`),
  CONSTRAINT `anket_ibfk_1` FOREIGN KEY (`site_no`) REFERENCES `site` (`site_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `anket_ibfk_2` FOREIGN KEY (`olusturan_no`) REFERENCES `kullanici` (`kullanici_no`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.anket: ~0 rows (yaklaşık) tablosu için veriler indiriliyor

-- tablo yapısı dökülüyor appapartman.anket_oyu
CREATE TABLE IF NOT EXISTS `anket_oyu` (
  `oy_no` bigint NOT NULL AUTO_INCREMENT,
  `secenek_no` int NOT NULL,
  `kullanici_no` int NOT NULL,
  `oy_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`oy_no`),
  UNIQUE KEY `secenek_no` (`secenek_no`,`kullanici_no`),
  KEY `kullanici_no` (`kullanici_no`),
  CONSTRAINT `anket_oyu_ibfk_1` FOREIGN KEY (`secenek_no`) REFERENCES `anket_secenegi` (`secenek_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `anket_oyu_ibfk_2` FOREIGN KEY (`kullanici_no`) REFERENCES `kullanici` (`kullanici_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.anket_oyu: ~0 rows (yaklaşık) tablosu için veriler indiriliyor

-- tablo yapısı dökülüyor appapartman.anket_oy_hakki
CREATE TABLE IF NOT EXISTS `anket_oy_hakki` (
  `hak_no` int NOT NULL AUTO_INCREMENT,
  `anket_no` bigint NOT NULL,
  `kullanici_no` int NOT NULL,
  `oy_kullandi_mi` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`hak_no`),
  UNIQUE KEY `anket_no` (`anket_no`,`kullanici_no`),
  KEY `kullanici_no` (`kullanici_no`),
  CONSTRAINT `anket_oy_hakki_ibfk_1` FOREIGN KEY (`anket_no`) REFERENCES `anket` (`anket_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `anket_oy_hakki_ibfk_2` FOREIGN KEY (`kullanici_no`) REFERENCES `kullanici` (`kullanici_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.anket_oy_hakki: ~0 rows (yaklaşık) tablosu için veriler indiriliyor

-- tablo yapısı dökülüyor appapartman.anket_secenegi
CREATE TABLE IF NOT EXISTS `anket_secenegi` (
  `secenek_no` int NOT NULL AUTO_INCREMENT,
  `anket_no` bigint NOT NULL,
  `secenek_metni` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`secenek_no`),
  KEY `anket_no` (`anket_no`),
  CONSTRAINT `anket_secenegi_ibfk_1` FOREIGN KEY (`anket_no`) REFERENCES `anket` (`anket_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.anket_secenegi: ~0 rows (yaklaşık) tablosu için veriler indiriliyor

-- tablo yapısı dökülüyor appapartman.arac
CREATE TABLE IF NOT EXISTS `arac` (
  `arac_no` int NOT NULL AUTO_INCREMENT,
  `site_no` int NOT NULL,
  `daire_no` int DEFAULT NULL,
  `plaka` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `marka` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `renk` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `otopark_yer_no` int DEFAULT NULL,
  `aktif_mi` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`arac_no`),
  UNIQUE KEY `site_no` (`site_no`,`plaka`),
  KEY `otopark_yer_no` (`otopark_yer_no`),
  KEY `idx_arac_daire` (`daire_no`),
  CONSTRAINT `arac_ibfk_1` FOREIGN KEY (`site_no`) REFERENCES `site` (`site_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `arac_ibfk_2` FOREIGN KEY (`daire_no`) REFERENCES `daire` (`daire_no`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `arac_ibfk_3` FOREIGN KEY (`otopark_yer_no`) REFERENCES `otopark_yeri` (`yer_no`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.arac: ~3 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `arac` (`arac_no`, `site_no`, `daire_no`, `plaka`, `marka`, `model`, `renk`, `otopark_yer_no`, `aktif_mi`) VALUES
	(1, 1, 1, '34ABC123', 'Toyota', 'Corolla', 'Beyaz', 1, 1),
	(2, 1, 3, '34XYZ789', 'Honda', 'Civic', 'Siyah', 2, 1),
	(3, 2, 5, '06DEF456', 'Ford', 'Focus', 'Gri', 5, 1);

-- tablo yapısı dökülüyor appapartman.audit_log
CREATE TABLE IF NOT EXISTS `audit_log` (
  `log_no` bigint NOT NULL AUTO_INCREMENT,
  `kullanici_no` int DEFAULT NULL,
  `site_no` int DEFAULT NULL,
  `tablo_adi` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kayit_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `islem_tipi` enum('INSERT','UPDATE','DELETE','LOGIN','LOGOUT','EXPORT') COLLATE utf8mb4_unicode_ci NOT NULL,
  `eski_deger` json DEFAULT NULL,
  `yeni_deger` json DEFAULT NULL,
  `ip_adresi` varbinary(16) DEFAULT NULL,
  `user_agent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `islem_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`log_no`),
  KEY `idx_al_tablo_kayit` (`tablo_adi`,`kayit_id`),
  KEY `idx_al_kullanici_tarih` (`kullanici_no`,`islem_tarihi`),
  KEY `idx_al_site_tarih` (`site_no`,`islem_tarihi`),
  CONSTRAINT `audit_log_ibfk_1` FOREIGN KEY (`kullanici_no`) REFERENCES `kullanici` (`kullanici_no`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `audit_log_ibfk_2` FOREIGN KEY (`site_no`) REFERENCES `site` (`site_no`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=467 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.audit_log: ~370 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `audit_log` (`log_no`, `kullanici_no`, `site_no`, `tablo_adi`, `kayit_id`, `islem_tipi`, `eski_deger`, `yeni_deger`, `ip_adresi`, `user_agent`, `islem_tarihi`) VALUES
	(16, NULL, NULL, 'kullanici', '25', 'INSERT', 'null', '{"ad": "AuthFlow", "soyad": "Test", "e_posta": "auth.flow@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$8eFTK9u3ujReAKEcNqomaA$0q5cetX79bpa95pqyR/sBp/GYsLusWJbT+IjeSBFZ4o", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', NULL, NULL, '2026-09-27 18:17:49'),
	(17, NULL, NULL, 'kvkk_onay', '19', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-27T18:17:48.696342", "kullanici_no": 25, "onaylandi_mi": true}', NULL, NULL, '2026-09-27 18:17:49'),
	(18, NULL, NULL, 'kullanici', '25', 'UPDATE', '{"son_giris_tarihi": null}', '{"son_giris_tarihi": "2026-09-27T18:17:48.922772"}', NULL, NULL, '2026-09-27 18:17:50'),
	(19, NULL, NULL, 'kullanici_site', '10', 'INSERT', 'null', '{"rol_no": 1, "site_no": 1, "aktif_mi": true, "kayit_no": null, "bitis_tarihi": null, "kullanici_no": 11, "baslangic_tarihi": "2026-09-27", "olusturma_tarihi": null, "guncellenme_tarihi": null}', NULL, NULL, '2026-09-27 18:30:47'),
	(20, NULL, NULL, 'kullanici_site', '11', 'INSERT', 'null', '{"rol_no": 1, "site_no": 2, "aktif_mi": true, "kayit_no": null, "bitis_tarihi": null, "kullanici_no": 11, "baslangic_tarihi": "2026-09-27", "olusturma_tarihi": null, "guncellenme_tarihi": null}', NULL, NULL, '2026-09-27 18:30:47'),
	(21, NULL, NULL, 'kullanici_site', '12', 'INSERT', 'null', '{"rol_no": 1, "site_no": 1, "aktif_mi": true, "kayit_no": null, "bitis_tarihi": null, "kullanici_no": 11, "baslangic_tarihi": "2026-09-27", "olusturma_tarihi": null, "guncellenme_tarihi": null}', NULL, NULL, '2026-09-27 18:47:38'),
	(22, NULL, NULL, 'kullanici_site', '13', 'INSERT', 'null', '{"rol_no": 1, "site_no": 2, "aktif_mi": true, "kayit_no": null, "bitis_tarihi": null, "kullanici_no": 11, "baslangic_tarihi": "2026-09-27", "olusturma_tarihi": null, "guncellenme_tarihi": null}', NULL, NULL, '2026-09-27 18:47:38'),
	(23, NULL, NULL, 'kullanici', '11', 'UPDATE', '{"hesap_kilitli_mi": true, "son_giris_tarihi": "2026-09-27T16:12:51", "kilit_acilma_tarihi": "2026-09-27T16:45:41", "basarisiz_giris_sayisi": 5}', '{"hesap_kilitli_mi": false, "son_giris_tarihi": "2026-09-27T18:49:52.304070", "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 18:49:52'),
	(24, NULL, NULL, 'kullanici', '11', 'UPDATE', '{"son_giris_tarihi": "2026-09-27T18:49:52"}', '{"son_giris_tarihi": "2026-09-27T18:51:47.842780"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 18:51:48'),
	(25, NULL, NULL, 'kullanici', '11', 'UPDATE', '{"son_giris_tarihi": "2026-09-27T18:51:48"}', '{"son_giris_tarihi": "2026-09-27T18:52:32.286261"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 18:52:32'),
	(26, NULL, NULL, 'kullanici', '11', 'UPDATE', '{"son_giris_tarihi": "2026-09-27T18:52:32"}', '{"son_giris_tarihi": "2026-09-27T18:56:37.560113"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 18:56:38'),
	(27, NULL, NULL, 'kullanici', '11', 'UPDATE', '{"son_giris_tarihi": "2026-09-27T18:56:38"}', '{"son_giris_tarihi": "2026-09-27T18:56:52.268903"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 18:56:52'),
	(28, NULL, NULL, 'kullanici', '11', 'UPDATE', '{"son_giris_tarihi": "2026-09-27T18:56:52"}', '{"son_giris_tarihi": "2026-09-27T19:40:33.401965"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 19:40:34'),
	(29, NULL, NULL, 'kullanici', '11', 'UPDATE', '{"son_giris_tarihi": "2026-09-27T19:40:33"}', '{"son_giris_tarihi": "2026-09-27T20:22:07.342605"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 20:22:07'),
	(30, NULL, NULL, 'kullanici', '11', 'UPDATE', '{"son_giris_tarihi": "2026-09-27T20:22:07"}', '{"son_giris_tarihi": "2026-09-27T20:23:50.441415"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 20:23:50'),
	(31, 11, 1, 'odeme', '4', 'INSERT', 'null', '{"site_no": 1, "aciklama": "Test tahsilat - aidat 2", "odeme_no": null, "dekont_no": "HB-TEST-001", "onay_tarihi": "2026-09-27T20:23:52.739940", "referans_no": null, "odeme_tarihi": "2026-09-27T20:23:52.739934", "olusturan_no": 11, "onaylayan_no": 11, "toplam_tutar": "1800.00", "onay_durum_no": 1, "odeme_kanali_no": 1, "olusturma_tarihi": null, "guncellenme_tarihi": null}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 20:23:53'),
	(32, 11, 1, 'aidat', '2', 'UPDATE', '{"durum": "BEKLIYOR", "odenen_tutar": "0.00"}', '{"durum": "ODENDI", "odenen_tutar": "1800.00"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 20:23:53'),
	(33, 11, 1, 'odeme', '4', 'UPDATE', '{"aciklama": "Test tahsilat - aidat 2", "onay_durum_no": 1}', '{"aciklama": "Test tahsilat - aidat 2 | IPTAL: Yanlis girilen tutar", "onay_durum_no": 3}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 20:24:26'),
	(34, 11, 1, 'aidat', '8', 'INSERT', 'null', '{"durum": "BEKLIYOR", "tutar": "1500.00", "site_no": 1, "aidat_no": null, "daire_no": 1, "donem_ay": 1, "donem_yil": 2027, "odenen_tutar": "0.00", "aidat_tipi_no": 1, "olusturma_tarihi": null, "son_odeme_tarihi": "2027-01-31", "guncellenme_tarihi": null, "otomatik_islendi_mi": true}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 20:25:10'),
	(35, 11, 1, 'aidat', '9', 'INSERT', 'null', '{"durum": "BEKLIYOR", "tutar": "1800.00", "site_no": 1, "aidat_no": null, "daire_no": 2, "donem_ay": 1, "donem_yil": 2027, "odenen_tutar": "0.00", "aidat_tipi_no": 1, "olusturma_tarihi": null, "son_odeme_tarihi": "2027-01-31", "guncellenme_tarihi": null, "otomatik_islendi_mi": true}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 20:25:10'),
	(36, 11, 1, 'aidat', '10', 'INSERT', 'null', '{"durum": "BEKLIYOR", "tutar": "1500.00", "site_no": 1, "aidat_no": null, "daire_no": 3, "donem_ay": 1, "donem_yil": 2027, "odenen_tutar": "0.00", "aidat_tipi_no": 1, "olusturma_tarihi": null, "son_odeme_tarihi": "2027-01-31", "guncellenme_tarihi": null, "otomatik_islendi_mi": true}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 20:25:10'),
	(37, 11, 1, 'aidat', '11', 'INSERT', 'null', '{"durum": "BEKLIYOR", "tutar": "1500.00", "site_no": 1, "aidat_no": null, "daire_no": 4, "donem_ay": 1, "donem_yil": 2027, "odenen_tutar": "0.00", "aidat_tipi_no": 1, "olusturma_tarihi": null, "son_odeme_tarihi": "2027-01-31", "guncellenme_tarihi": null, "otomatik_islendi_mi": true}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 20:25:10'),
	(38, NULL, NULL, 'kullanici', '11', 'UPDATE', '{"son_giris_tarihi": "2026-09-27T20:23:50"}', '{"son_giris_tarihi": "2026-09-27T20:27:47.998860"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 20:27:48'),
	(39, NULL, NULL, 'kullanici', '11', 'UPDATE', '{"son_giris_tarihi": "2026-09-27T20:27:48"}', '{"son_giris_tarihi": "2026-09-27T20:30:31.066690"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 20:30:31'),
	(40, NULL, NULL, 'aidat', '2', 'UPDATE', '{"durum": "ODENDI", "odenen_tutar": "1800.00"}', '{"durum": "BEKLIYOR", "odenen_tutar": "0.00"}', NULL, NULL, '2026-09-27 20:32:11'),
	(41, NULL, NULL, 'kullanici', '11', 'UPDATE', '{"son_giris_tarihi": "2026-09-27T20:30:31"}', '{"son_giris_tarihi": "2026-09-27T20:34:07.669364"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 20:34:08'),
	(42, 11, 1, 'odeme', '5', 'INSERT', 'null', '{"site_no": 1, "aciklama": null, "odeme_no": null, "dekont_no": "HB-FIX-001", "onay_tarihi": "2026-09-27T20:34:08.670731", "referans_no": null, "odeme_tarihi": "2026-09-27T20:34:08.670720", "olusturan_no": 11, "onaylayan_no": 11, "toplam_tutar": "1800.00", "onay_durum_no": 1, "odeme_kanali_no": 1, "olusturma_tarihi": null, "guncellenme_tarihi": null}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 20:34:09'),
	(43, 11, 1, 'odeme_detay', '4', 'INSERT', 'null', '{"tutar": "1800.00", "aciklama": null, "aidat_no": 2, "detay_no": null, "gider_no": null, "odeme_no": null}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 20:34:09'),
	(44, 11, 1, 'aidat', '2', 'UPDATE', '{"durum": "BEKLIYOR", "odenen_tutar": "0.00"}', '{"durum": "ODENDI", "odenen_tutar": "1800.00"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 20:34:09'),
	(45, 11, 1, 'aidat', '2', 'UPDATE', '{"durum": "ODENDI", "odenen_tutar": "1800.00"}', '{"durum": "BEKLIYOR", "odenen_tutar": "0.00"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 20:34:10'),
	(46, 11, 1, 'odeme', '5', 'UPDATE', '{"aciklama": null, "onay_durum_no": 1}', '{"aciklama": " | IPTAL: Test iptal", "onay_durum_no": 3}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 20:34:10'),
	(47, NULL, NULL, 'kullanici', '11', 'UPDATE', '{"son_giris_tarihi": "2026-09-27T20:34:08"}', '{"son_giris_tarihi": "2026-09-27T20:58:08.193397"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 20:58:08'),
	(48, NULL, NULL, 'kullanici', '11', 'UPDATE', '{"son_giris_tarihi": "2026-09-27T20:58:08"}', '{"son_giris_tarihi": "2026-09-27T20:59:16.523539"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 20:59:17'),
	(49, 11, 1, 'gider', '5', 'INSERT', 'null', '{"tutar": "1500.00", "cari_no": 1, "site_no": 1, "aciklama": "Test gideri - HTTP", "belge_no": "FTR-TEST-001", "gider_no": null, "kalem_no": 4, "kdv_tutar": "270.00", "kaydeden_no": 11, "gider_tarihi": "2026-10-01", "olusturma_tarihi": null, "guncellenme_tarihi": null}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 20:59:17'),
	(50, 11, 1, 'cari_hareket', '5', 'INSERT', 'null', '{"tutar": "1770.00", "cari_no": 1, "aciklama": "Gider: Elektrik Faturasi", "belge_no": "FTR-TEST-001", "gider_no": 5, "odeme_no": null, "hareket_no": null, "olusturan_no": 11, "islem_tipi_no": 1, "hareket_tarihi": "2026-09-27", "olusturma_tarihi": null}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 20:59:17'),
	(51, 11, 1, 'gider', '5', 'UPDATE', '{"tutar": "1500.00", "aciklama": "Test gideri - HTTP"}', '{"tutar": "2000.00", "aciklama": "Guncellendi - HTTP test"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 21:00:23'),
	(52, 11, 1, 'gider', '5', 'DELETE', '{"tutar": "2000.00", "cari_no": 1, "site_no": 1, "aciklama": "Guncellendi - HTTP test", "belge_no": "FTR-TEST-001", "gider_no": 5, "kalem_no": 4, "kdv_tutar": "270.00", "kaydeden_no": 11, "gider_tarihi": "2026-10-01", "olusturma_tarihi": "2026-09-27T23:59:17", "guncellenme_tarihi": "2026-09-28T00:00:23"}', 'null', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 21:00:44'),
	(53, NULL, NULL, 'kullanici', '11', 'UPDATE', '{"son_giris_tarihi": "2026-09-27T20:59:17"}', '{"son_giris_tarihi": "2026-09-27T21:02:02.655036"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 21:02:03'),
	(54, NULL, NULL, 'kullanici', '11', 'UPDATE', '{"son_giris_tarihi": "2026-09-27T21:02:03"}', '{"son_giris_tarihi": "2026-09-27T21:03:28.061032"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 21:03:28'),
	(55, NULL, NULL, 'kullanici', '11', 'UPDATE', '{"son_giris_tarihi": "2026-09-27T21:03:28"}', '{"son_giris_tarihi": "2026-09-27T21:03:56.552812"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 21:03:57'),
	(56, 11, 1, 'gelir', '4', 'INSERT', 'null', '{"tutar": "800.00", "kaynak": "Otopark Kira Geliri", "site_no": 1, "aciklama": "Ekim otopark", "gelir_no": null, "kaydeden_no": 11, "gelir_tarihi": "2026-10-05", "olusturma_tarihi": null}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 21:04:45'),
	(57, 11, 1, 'gelir', '4', 'UPDATE', '{"tutar": "800.00", "aciklama": "Ekim otopark"}', '{"tutar": "1000.00", "aciklama": "Guncellendi"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 21:04:47'),
	(58, 11, 1, 'gelir', '4', 'DELETE', '{"tutar": "1000.00", "kaynak": "Otopark Kira Geliri", "site_no": 1, "aciklama": "Guncellendi", "gelir_no": 4, "kaydeden_no": 11, "gelir_tarihi": "2026-10-05", "olusturma_tarihi": "2026-09-28T00:04:44"}', 'null', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 21:04:47'),
	(59, NULL, NULL, 'kullanici', '11', 'UPDATE', '{"son_giris_tarihi": "2026-09-27T21:03:57"}', '{"son_giris_tarihi": "2026-09-27T21:06:14.877108"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 21:06:15'),
	(60, NULL, NULL, 'kullanici', '11', 'UPDATE', '{"son_giris_tarihi": "2026-09-27T21:06:15"}', '{"son_giris_tarihi": "2026-09-27T21:06:29.279134"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 21:06:29'),
	(61, 11, 1, 'gelir', '5', 'INSERT', 'null', '{"tutar": "800.00", "kaynak": "Otopark Kira Geliri", "site_no": 1, "aciklama": "Ekim otopark", "gelir_no": null, "kaydeden_no": 11, "gelir_tarihi": "2026-10-05", "olusturma_tarihi": null}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 21:06:58'),
	(62, 11, 1, 'gelir', '5', 'UPDATE', '{"tutar": "800.00", "aciklama": "Ekim otopark"}', '{"tutar": "1000.00", "aciklama": "Guncellendi"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 21:06:59'),
	(63, 11, 1, 'gelir', '5', 'DELETE', '{"tutar": "1000.00", "kaynak": "Otopark Kira Geliri", "site_no": 1, "aciklama": "Guncellendi", "gelir_no": 5, "kaydeden_no": 11, "gelir_tarihi": "2026-10-05", "olusturma_tarihi": "2026-09-28T00:06:58"}', 'null', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 21:07:02'),
	(64, NULL, NULL, 'kullanici', '11', 'UPDATE', '{"son_giris_tarihi": "2026-09-27T21:06:29"}', '{"son_giris_tarihi": "2026-09-27T21:14:21.876172"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 21:14:22'),
	(65, NULL, NULL, 'kullanici', '11', 'UPDATE', '{"son_giris_tarihi": "2026-09-27T21:14:22"}', '{"son_giris_tarihi": "2026-09-28T20:23:47.342728"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 20:23:47'),
	(66, NULL, NULL, 'kullanici', '11', 'UPDATE', '{"son_giris_tarihi": "2026-09-28T20:23:47"}', '{"son_giris_tarihi": "2026-09-28T20:25:04.466369"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 20:25:04'),
	(67, NULL, NULL, 'kullanici', '11', 'UPDATE', '{"son_giris_tarihi": "2026-09-28T20:25:04"}', '{"son_giris_tarihi": "2026-09-28T20:26:18.735237"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 20:26:19'),
	(68, NULL, NULL, 'kullanici', '11', 'UPDATE', '{"son_giris_tarihi": "2026-09-28T20:26:19"}', '{"son_giris_tarihi": "2026-09-28T20:40:06.481328"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 20:40:07'),
	(69, NULL, NULL, 'kullanici', '11', 'UPDATE', '{"son_giris_tarihi": "2026-09-28T20:40:06"}', '{"son_giris_tarihi": "2026-09-28T20:41:13.937136"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 20:41:14'),
	(70, NULL, NULL, 'kullanici', '11', 'UPDATE', '{"son_giris_tarihi": "2026-09-28T20:41:14"}', '{"son_giris_tarihi": "2026-09-28T20:50:14.061525"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 20:50:14'),
	(71, NULL, NULL, 'kullanici', '11', 'UPDATE', '{"son_giris_tarihi": "2026-09-28T20:50:14"}', '{"son_giris_tarihi": "2026-09-28T20:56:55.275560"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 20:56:55'),
	(72, NULL, NULL, 'kullanici', '11', 'UPDATE', '{"son_giris_tarihi": "2026-09-28T20:56:55"}', '{"son_giris_tarihi": "2026-09-28T20:57:55.768845"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 20:57:56'),
	(73, NULL, NULL, 'daire_sakin', '4', 'INSERT', 'null', '{"daire_no": 4, "kayit_no": null, "cikis_tarihi": null, "giris_tarihi": "2026-09-29", "kullanici_no": 5, "mulk_sahibi_mi": false, "olusturma_tarihi": "2026-09-28T21:07:45.333741", "guncellenme_tarihi": "2026-09-28T21:07:45.333748"}', NULL, NULL, '2026-09-28 21:07:45'),
	(74, NULL, NULL, 'daire', '4', 'UPDATE', '{"doluluk_no": 2}', '{"doluluk_no": 1}', NULL, NULL, '2026-09-28 21:07:45'),
	(75, NULL, NULL, 'daire_sakin', '5', 'INSERT', 'null', '{"daire_no": 4, "kayit_no": null, "cikis_tarihi": null, "giris_tarihi": "2026-09-29", "kullanici_no": 5, "mulk_sahibi_mi": false, "olusturma_tarihi": "2026-09-28T21:08:31.292264", "guncellenme_tarihi": "2026-09-28T21:08:31.292281"}', NULL, NULL, '2026-09-28 21:08:31'),
	(76, NULL, NULL, 'daire_sakin', '6', 'INSERT', 'null', '{"daire_no": 4, "kayit_no": null, "cikis_tarihi": null, "giris_tarihi": "2026-09-29", "kullanici_no": 5, "mulk_sahibi_mi": false, "olusturma_tarihi": "2026-09-28T21:09:48.346181", "guncellenme_tarihi": "2026-09-28T21:09:48.346193"}', NULL, NULL, '2026-09-28 21:09:48'),
	(77, NULL, NULL, 'daire_sakin', '2', 'UPDATE', '{"cikis_tarihi": null, "guncellenme_tarihi": "2026-09-27T16:08:57"}', '{"cikis_tarihi": "2026-09-29", "guncellenme_tarihi": "2026-09-28T21:09:48.441609"}', NULL, NULL, '2026-09-28 21:09:48'),
	(78, NULL, NULL, 'daire_sakin', '7', 'INSERT', 'null', '{"daire_no": 2, "kayit_no": null, "cikis_tarihi": null, "giris_tarihi": "2026-09-29", "kullanici_no": 4, "mulk_sahibi_mi": true, "olusturma_tarihi": "2026-09-28T21:09:48.479125", "guncellenme_tarihi": "2026-09-28T21:09:48.479127"}', NULL, NULL, '2026-09-28 21:09:48'),
	(79, NULL, NULL, 'daire_sakin', '1', 'UPDATE', '{"cikis_tarihi": null, "guncellenme_tarihi": "2026-09-27T16:08:57"}', '{"cikis_tarihi": "2026-09-29", "guncellenme_tarihi": "2026-09-28T21:09:48.479112"}', NULL, NULL, '2026-09-28 21:09:48'),
	(80, NULL, NULL, 'daire', '1', 'UPDATE', '{"doluluk_no": 1}', '{"doluluk_no": 2}', NULL, NULL, '2026-09-28 21:09:49'),
	(81, NULL, NULL, 'daire_sakin', '8', 'INSERT', 'null', '{"daire_no": 4, "kayit_no": null, "cikis_tarihi": null, "giris_tarihi": "2026-09-29", "kullanici_no": 5, "mulk_sahibi_mi": false, "olusturma_tarihi": "2026-09-28T21:10:29.804247", "guncellenme_tarihi": "2026-09-28T21:10:29.804254"}', NULL, NULL, '2026-09-28 21:10:30'),
	(82, NULL, NULL, 'kullanici', '11', 'UPDATE', '{"son_giris_tarihi": "2026-09-28T20:57:56"}', '{"son_giris_tarihi": "2026-09-28T21:12:49.393190"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 21:12:49'),
	(83, NULL, NULL, 'kullanici', '11', 'UPDATE', '{"son_giris_tarihi": "2026-09-28T21:12:49"}', '{"son_giris_tarihi": "2026-09-28T21:12:56.345060"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 21:12:56'),
	(84, NULL, NULL, 'daire_sakin', '9', 'INSERT', 'null', '{"daire_no": 1, "kayit_no": null, "cikis_tarihi": null, "giris_tarihi": "2025-02-01", "kullanici_no": 4, "mulk_sahibi_mi": true, "olusturma_tarihi": "2026-09-29", "guncellenme_tarihi": "2026-09-29"}', NULL, NULL, '2026-09-28 21:14:02'),
	(85, NULL, NULL, 'daire_sakin', '10', 'INSERT', 'null', '{"daire_no": 3, "kayit_no": null, "cikis_tarihi": null, "giris_tarihi": "2025-03-01", "kullanici_no": 5, "mulk_sahibi_mi": false, "olusturma_tarihi": "2026-09-29", "guncellenme_tarihi": "2026-09-29"}', NULL, NULL, '2026-09-28 21:14:02'),
	(86, NULL, NULL, 'daire_sakin', '11', 'INSERT', 'null', '{"daire_no": 5, "kayit_no": null, "cikis_tarihi": null, "giris_tarihi": "2025-02-01", "kullanici_no": 6, "mulk_sahibi_mi": true, "olusturma_tarihi": "2026-09-29", "guncellenme_tarihi": "2026-09-29"}', NULL, NULL, '2026-09-28 21:14:02'),
	(87, NULL, NULL, 'daire', '2', 'UPDATE', '{"doluluk_no": 1}', '{"doluluk_no": 2}', NULL, NULL, '2026-09-28 21:14:02'),
	(88, NULL, NULL, 'daire', '1', 'UPDATE', '{"doluluk_no": 2}', '{"doluluk_no": 1}', NULL, NULL, '2026-09-28 21:14:02'),
	(89, NULL, NULL, 'daire', '4', 'UPDATE', '{"doluluk_no": 1}', '{"doluluk_no": 2}', NULL, NULL, '2026-09-28 21:14:02'),
	(90, NULL, NULL, 'kullanici', '11', 'UPDATE', '{"son_giris_tarihi": "2026-09-28T21:12:56"}', '{"son_giris_tarihi": "2026-09-28T21:14:19.810545"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 21:14:20'),
	(91, NULL, NULL, 'kullanici', '11', 'UPDATE', '{"son_giris_tarihi": "2026-09-28T21:14:20"}', '{"son_giris_tarihi": "2026-09-28T21:15:49.033610"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 21:15:49'),
	(92, 11, 1, 'daire_sakin', '12', 'INSERT', 'null', '{"daire_no": 2, "kayit_no": null, "cikis_tarihi": null, "giris_tarihi": "2026-09-29", "kullanici_no": 5, "mulk_sahibi_mi": false, "olusturma_tarihi": "2026-09-28T21:15:49.505612", "guncellenme_tarihi": "2026-09-28T21:15:49.505617"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 21:15:50'),
	(93, 11, 1, 'daire', '2', 'UPDATE', '{"doluluk_no": 2}', '{"doluluk_no": 1}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 21:15:50'),
	(94, 11, 1, 'daire_sakin', '12', 'UPDATE', '{"cikis_tarihi": null, "guncellenme_tarihi": "2026-09-28T21:15:50"}', '{"cikis_tarihi": "2026-10-15", "guncellenme_tarihi": "2026-09-28T21:16:10.902577"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 21:16:11'),
	(95, NULL, NULL, 'daire_sakin', '13', 'INSERT', 'null', '{"daire_no": 1, "kayit_no": null, "cikis_tarihi": null, "giris_tarihi": "2025-02-01", "kullanici_no": 4, "mulk_sahibi_mi": true, "olusturma_tarihi": "2026-09-29", "guncellenme_tarihi": "2026-09-29"}', NULL, NULL, '2026-09-28 21:18:08'),
	(96, NULL, NULL, 'daire_sakin', '14', 'INSERT', 'null', '{"daire_no": 3, "kayit_no": null, "cikis_tarihi": null, "giris_tarihi": "2025-03-01", "kullanici_no": 5, "mulk_sahibi_mi": false, "olusturma_tarihi": "2026-09-29", "guncellenme_tarihi": "2026-09-29"}', NULL, NULL, '2026-09-28 21:18:08'),
	(97, NULL, NULL, 'daire', '2', 'UPDATE', '{"doluluk_no": 1}', '{"doluluk_no": 2}', NULL, NULL, '2026-09-28 21:18:08'),
	(98, NULL, NULL, 'kullanici', '11', 'UPDATE', '{"son_giris_tarihi": "2026-09-28T21:15:49"}', '{"son_giris_tarihi": "2026-09-28T21:18:20.441030"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 21:18:20'),
	(99, 11, 1, 'daire_sakin', '15', 'INSERT', 'null', '{"daire_no": 4, "kayit_no": null, "cikis_tarihi": null, "giris_tarihi": "2026-09-29", "kullanici_no": 6, "mulk_sahibi_mi": true, "olusturma_tarihi": "2026-09-28T21:18:20.896284", "guncellenme_tarihi": "2026-09-28T21:18:20.896295"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 21:18:21'),
	(100, 11, 1, 'kullanici_site', '14', 'INSERT', 'null', '{"rol_no": 3, "site_no": 1, "aktif_mi": true, "kayit_no": null, "bitis_tarihi": null, "kullanici_no": 6, "baslangic_tarihi": "2026-09-29", "olusturma_tarihi": "2026-09-28T21:18:20.908708", "guncellenme_tarihi": "2026-09-28T21:18:20.908717"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 21:18:21'),
	(101, 11, 1, 'daire', '4', 'UPDATE', '{"doluluk_no": 2}', '{"doluluk_no": 1}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 21:18:21'),
	(102, 11, 1, 'daire_sakin', '15', 'UPDATE', '{"cikis_tarihi": null, "guncellenme_tarihi": "2026-09-28T21:18:21"}', '{"cikis_tarihi": "2026-10-15", "guncellenme_tarihi": "2026-09-28T21:18:45.020773"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 21:18:45'),
	(103, NULL, NULL, 'daire_sakin', '16', 'INSERT', 'null', '{"daire_no": 1, "kayit_no": null, "cikis_tarihi": null, "giris_tarihi": "2025-02-01", "kullanici_no": 4, "mulk_sahibi_mi": true, "olusturma_tarihi": "2026-09-29", "guncellenme_tarihi": "2026-09-29"}', NULL, NULL, '2026-09-28 21:24:01'),
	(104, NULL, NULL, 'daire_sakin', '17', 'INSERT', 'null', '{"daire_no": 3, "kayit_no": null, "cikis_tarihi": null, "giris_tarihi": "2025-03-01", "kullanici_no": 5, "mulk_sahibi_mi": false, "olusturma_tarihi": "2026-09-29", "guncellenme_tarihi": "2026-09-29"}', NULL, NULL, '2026-09-28 21:24:01'),
	(105, NULL, NULL, 'daire', '4', 'UPDATE', '{"doluluk_no": 1}', '{"doluluk_no": 2}', NULL, NULL, '2026-09-28 21:24:01'),
	(106, NULL, NULL, 'kullanici', '11', 'UPDATE', '{"son_giris_tarihi": "2026-09-28T21:18:20"}', '{"son_giris_tarihi": "2026-09-28T21:24:23.368252"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 21:24:23'),
	(107, 11, 1, 'daire_sakin', '18', 'INSERT', 'null', '{"daire_no": 4, "kayit_no": null, "cikis_tarihi": null, "giris_tarihi": "2026-09-29", "kullanici_no": 6, "mulk_sahibi_mi": true, "olusturma_tarihi": "2026-09-28T21:24:24.213616", "guncellenme_tarihi": "2026-09-28T21:24:24.213621"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 21:24:24'),
	(108, 11, 1, 'daire', '4', 'UPDATE', '{"doluluk_no": 2}', '{"doluluk_no": 1}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 21:24:24'),
	(109, 11, 1, 'daire_sakin', '18', 'UPDATE', '{"cikis_tarihi": null, "guncellenme_tarihi": "2026-09-28T21:24:24"}', '{"cikis_tarihi": "2026-10-15", "guncellenme_tarihi": "2026-09-28T21:24:27.513585"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 21:24:28'),
	(110, 11, 1, 'daire', '4', 'UPDATE', '{"doluluk_no": 1}', '{"doluluk_no": 2}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 21:24:28'),
	(111, 11, 1, 'daire_sakin', '19', 'INSERT', 'null', '{"daire_no": 2, "kayit_no": null, "cikis_tarihi": null, "giris_tarihi": "2026-11-01", "kullanici_no": 4, "mulk_sahibi_mi": true, "olusturma_tarihi": "2026-09-28T21:24:30.176981", "guncellenme_tarihi": "2026-09-28T21:24:30.176985"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 21:24:30'),
	(112, 11, 1, 'daire_sakin', '16', 'UPDATE', '{"cikis_tarihi": null, "guncellenme_tarihi": "2026-09-29T00:00:00"}', '{"cikis_tarihi": "2026-11-01", "guncellenme_tarihi": "2026-09-28T21:24:30.176953"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 21:24:30'),
	(113, 11, 1, 'daire', '1', 'UPDATE', '{"doluluk_no": 1}', '{"doluluk_no": 2}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 21:24:30'),
	(114, 11, 1, 'daire', '2', 'UPDATE', '{"doluluk_no": 2}', '{"doluluk_no": 1}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 21:24:30'),
	(115, NULL, NULL, 'kullanici', '11', 'UPDATE', '{"son_giris_tarihi": "2026-09-28T21:24:23"}', '{"son_giris_tarihi": "2026-09-28T21:43:30.272920"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 21:43:30'),
	(116, NULL, NULL, 'kullanici', '11', 'UPDATE', '{"son_giris_tarihi": "2026-09-28T21:43:30"}', '{"son_giris_tarihi": "2026-09-28T21:44:36.654635"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 21:44:37'),
	(117, NULL, NULL, 'kullanici', '11', 'UPDATE', '{"son_giris_tarihi": "2026-09-28T21:44:37"}', '{"son_giris_tarihi": "2026-09-28T21:48:12.561388"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 21:48:13'),
	(118, NULL, NULL, 'kullanici', '11', 'UPDATE', '{"son_giris_tarihi": "2026-09-28T21:48:13"}', '{"son_giris_tarihi": "2026-09-28T21:58:10.468261"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 21:58:11'),
	(119, NULL, NULL, 'kullanici', '11', 'UPDATE', '{"son_giris_tarihi": "2026-09-28T21:58:10"}', '{"son_giris_tarihi": "2026-09-28T21:59:11.051715"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 21:59:11'),
	(120, NULL, NULL, 'personel', '3', 'INSERT', 'null', '{"ad": "Mehmet", "soyad": "Demir", "gorevi": "TEKNIK PERSONEL", "e_posta": "mehmet@ornek.com", "telefon": "05011110003", "aktif_mi": true, "firma_no": 1, "personel_no": null, "kullanici_no": 3, "tc_kimlik_sifreli": null, "ise_baslama_tarihi": "2025-01-01", "isten_cikis_tarihi": null}', NULL, NULL, '2026-09-28 22:06:02'),
	(121, NULL, NULL, 'personel_site', '4', 'INSERT', 'null', '{"site_no": 1, "kayit_no": null, "personel_no": 3, "bitis_tarihi": null, "baslangic_tarihi": "2025-01-01"}', NULL, NULL, '2026-09-28 22:06:02'),
	(122, NULL, NULL, 'personel_site', '5', 'INSERT', 'null', '{"site_no": 2, "kayit_no": null, "personel_no": 3, "bitis_tarihi": null, "baslangic_tarihi": "2025-01-01"}', NULL, NULL, '2026-09-28 22:06:02'),
	(123, NULL, NULL, 'personel', '4', 'INSERT', 'null', '{"ad": "Emine", "soyad": "Temiz", "gorevi": "TEMIZLIK PERSONELI", "e_posta": null, "telefon": null, "aktif_mi": true, "firma_no": 1, "personel_no": null, "kullanici_no": null, "tc_kimlik_sifreli": null, "ise_baslama_tarihi": "2025-03-01", "isten_cikis_tarihi": null}', NULL, NULL, '2026-09-28 22:06:02'),
	(124, NULL, NULL, 'personel_site', '6', 'INSERT', 'null', '{"site_no": 1, "kayit_no": null, "personel_no": 4, "bitis_tarihi": null, "baslangic_tarihi": "2025-03-01"}', NULL, NULL, '2026-09-28 22:06:02'),
	(125, NULL, NULL, 'personel_izin', '3', 'INSERT', 'null', '{"izin_no": null, "aciklama": "Yillik izin", "izin_tipi": "YILLIK", "gun_sayisi": 5, "personel_no": 3, "bitis_tarihi": "2026-10-05", "onaylayan_no": null, "onay_durum_no": 2, "baslangic_tarihi": "2026-10-01", "olusturma_tarihi": "2026-09-28T22:06:01.663397"}', NULL, NULL, '2026-09-28 22:06:02'),
	(126, NULL, NULL, 'personel_izin', '3', 'UPDATE', '{"aciklama": "Yillik izin", "onaylayan_no": null, "onay_durum_no": 2}', '{"aciklama": "Yillik izin | Onaylandi", "onaylayan_no": 11, "onay_durum_no": 1}', NULL, NULL, '2026-09-28 22:06:02'),
	(127, NULL, NULL, 'personel', '5', 'INSERT', 'null', '{"ad": "Mehmet", "soyad": "Demir", "gorevi": "TEKNIK PERSONEL", "e_posta": "mehmet@ornek.com", "telefon": "05011110003", "aktif_mi": true, "firma_no": 1, "personel_no": null, "kullanici_no": 3, "tc_kimlik_sifreli": null, "ise_baslama_tarihi": "2025-01-01", "isten_cikis_tarihi": null}', NULL, NULL, '2026-09-28 22:08:36'),
	(128, NULL, NULL, 'personel_site', '7', 'INSERT', 'null', '{"site_no": 1, "kayit_no": null, "personel_no": 5, "bitis_tarihi": null, "baslangic_tarihi": "2025-01-01"}', NULL, NULL, '2026-09-28 22:08:36'),
	(129, NULL, NULL, 'personel_site', '8', 'INSERT', 'null', '{"site_no": 2, "kayit_no": null, "personel_no": 5, "bitis_tarihi": null, "baslangic_tarihi": "2025-01-01"}', NULL, NULL, '2026-09-28 22:08:36'),
	(130, NULL, NULL, 'personel', '6', 'INSERT', 'null', '{"ad": "Emine", "soyad": "Temiz", "gorevi": "TEMIZLIK PERSONELI", "e_posta": null, "telefon": null, "aktif_mi": true, "firma_no": 1, "personel_no": null, "kullanici_no": null, "tc_kimlik_sifreli": null, "ise_baslama_tarihi": "2025-03-01", "isten_cikis_tarihi": null}', NULL, NULL, '2026-09-28 22:08:36'),
	(131, NULL, NULL, 'personel_site', '9', 'INSERT', 'null', '{"site_no": 1, "kayit_no": null, "personel_no": 6, "bitis_tarihi": null, "baslangic_tarihi": "2025-03-01"}', NULL, NULL, '2026-09-28 22:08:36'),
	(132, NULL, NULL, 'personel_izin', '4', 'INSERT', 'null', '{"izin_no": null, "aciklama": "Yillik izin", "izin_tipi": "YILLIK", "gun_sayisi": 5, "personel_no": 5, "bitis_tarihi": "2026-10-05", "onaylayan_no": null, "onay_durum_no": 2, "baslangic_tarihi": "2026-10-01", "olusturma_tarihi": "2026-09-28T22:08:36.435872"}', NULL, NULL, '2026-09-28 22:08:36'),
	(133, NULL, NULL, 'personel_izin', '4', 'UPDATE', '{"aciklama": "Yillik izin", "onaylayan_no": null, "onay_durum_no": 2}', '{"aciklama": "Yillik izin | Onaylandi", "onaylayan_no": 11, "onay_durum_no": 1}', NULL, NULL, '2026-09-28 22:08:36'),
	(134, NULL, NULL, 'personel_maas_odeme', '3', 'INSERT', 'null', '{"donem_ay": 9, "net_maas": null, "brut_maas": "30000.00", "donem_yil": 2026, "kesintiler": "4500.00", "personel_no": 5, "odeme_tarihi": "2026-09-30", "maas_odeme_no": null}', NULL, NULL, '2026-09-28 22:08:37'),
	(135, NULL, NULL, 'personel', '7', 'INSERT', 'null', '{"ad": "Mehmet", "soyad": "Demir", "gorevi": "TEKNIK PERSONEL", "e_posta": "mehmet@ornek.com", "telefon": "05011110003", "aktif_mi": true, "firma_no": 1, "personel_no": null, "kullanici_no": 3, "tc_kimlik_sifreli": null, "ise_baslama_tarihi": "2025-01-01", "isten_cikis_tarihi": null}', NULL, NULL, '2026-09-28 22:09:41'),
	(136, NULL, NULL, 'personel_site', '10', 'INSERT', 'null', '{"site_no": 1, "kayit_no": null, "personel_no": 7, "bitis_tarihi": null, "baslangic_tarihi": "2025-01-01"}', NULL, NULL, '2026-09-28 22:09:41'),
	(137, NULL, NULL, 'personel_site', '11', 'INSERT', 'null', '{"site_no": 2, "kayit_no": null, "personel_no": 7, "bitis_tarihi": null, "baslangic_tarihi": "2025-01-01"}', NULL, NULL, '2026-09-28 22:09:41'),
	(138, NULL, NULL, 'personel', '8', 'INSERT', 'null', '{"ad": "Emine", "soyad": "Temiz", "gorevi": "TEMIZLIK PERSONELI", "e_posta": null, "telefon": null, "aktif_mi": true, "firma_no": 1, "personel_no": null, "kullanici_no": null, "tc_kimlik_sifreli": null, "ise_baslama_tarihi": "2025-03-01", "isten_cikis_tarihi": null}', NULL, NULL, '2026-09-28 22:09:41'),
	(139, NULL, NULL, 'personel_site', '12', 'INSERT', 'null', '{"site_no": 1, "kayit_no": null, "personel_no": 8, "bitis_tarihi": null, "baslangic_tarihi": "2025-03-01"}', NULL, NULL, '2026-09-28 22:09:41'),
	(140, NULL, NULL, 'personel_izin', '5', 'INSERT', 'null', '{"izin_no": null, "aciklama": "Yillik izin", "izin_tipi": "YILLIK", "gun_sayisi": 5, "personel_no": 7, "bitis_tarihi": "2026-10-05", "onaylayan_no": null, "onay_durum_no": 2, "baslangic_tarihi": "2026-10-01", "olusturma_tarihi": "2026-09-28T22:09:40.736935"}', NULL, NULL, '2026-09-28 22:09:41'),
	(141, NULL, NULL, 'personel_izin', '5', 'UPDATE', '{"aciklama": "Yillik izin", "onaylayan_no": null, "onay_durum_no": 2}', '{"aciklama": "Yillik izin | Onaylandi", "onaylayan_no": 11, "onay_durum_no": 1}', NULL, NULL, '2026-09-28 22:09:41'),
	(142, NULL, NULL, 'personel_maas_odeme', '4', 'INSERT', 'null', '{"donem_ay": 9, "net_maas": null, "brut_maas": "30000.00", "donem_yil": 2026, "kesintiler": "4500.00", "personel_no": 7, "odeme_tarihi": "2026-09-30", "maas_odeme_no": null}', NULL, NULL, '2026-09-28 22:09:41'),
	(143, NULL, NULL, 'personel_site', '13', 'INSERT', 'null', '{"site_no": 2, "kayit_no": null, "personel_no": 8, "bitis_tarihi": null, "baslangic_tarihi": "2026-09-29"}', NULL, NULL, '2026-09-28 22:09:41'),
	(144, NULL, NULL, 'personel_site', '13', 'UPDATE', '{"bitis_tarihi": null}', '{"bitis_tarihi": "2026-09-30"}', NULL, NULL, '2026-09-28 22:09:41'),
	(145, NULL, NULL, 'personel_site', '12', 'UPDATE', '{"bitis_tarihi": null}', '{"bitis_tarihi": "2026-09-30"}', NULL, NULL, '2026-09-28 22:09:41'),
	(146, NULL, NULL, 'personel', '8', 'UPDATE', '{"aktif_mi": true, "isten_cikis_tarihi": null}', '{"aktif_mi": false, "isten_cikis_tarihi": "2026-09-30"}', NULL, NULL, '2026-09-28 22:09:41'),
	(147, NULL, NULL, 'personel', '8', 'DELETE', '{"ad": "Emine", "soyad": "Temiz", "gorevi": "TEMIZLIK PERSONELI", "e_posta": null, "telefon": null, "aktif_mi": false, "firma_no": 1, "personel_no": 8, "kullanici_no": null, "tc_kimlik_sifreli": null, "ise_baslama_tarihi": "2025-03-01", "isten_cikis_tarihi": "2026-09-30"}', 'null', NULL, NULL, '2026-09-28 22:09:41'),
	(148, NULL, NULL, 'personel_site', '12', 'DELETE', '{"site_no": 1, "kayit_no": 12, "personel_no": 8, "bitis_tarihi": "2026-09-30", "baslangic_tarihi": "2025-03-01"}', 'null', NULL, NULL, '2026-09-28 22:09:41'),
	(149, NULL, NULL, 'personel_site', '13', 'DELETE', '{"site_no": 2, "kayit_no": 13, "personel_no": 8, "bitis_tarihi": "2026-09-30", "baslangic_tarihi": "2026-09-29"}', 'null', NULL, NULL, '2026-09-28 22:09:41'),
	(150, NULL, NULL, 'kullanici', '11', 'UPDATE', '{"firma_no": null}', '{"firma_no": 1}', NULL, NULL, '2026-09-28 22:14:28'),
	(151, NULL, NULL, 'kullanici', '11', 'UPDATE', '{"son_giris_tarihi": "2026-09-28T21:59:11"}', '{"son_giris_tarihi": "2026-09-28T22:14:50.728027"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 22:14:51'),
	(152, 11, NULL, 'personel', '9', 'INSERT', 'null', '{"ad": "Ahmet", "soyad": "Usta", "gorevi": "GUVENLIK GOREVLISI", "e_posta": "ahmet.usta@ornek.com", "telefon": "05011112233", "aktif_mi": true, "firma_no": 1, "personel_no": null, "kullanici_no": null, "tc_kimlik_sifreli": null, "ise_baslama_tarihi": "2025-06-01", "isten_cikis_tarihi": null}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 22:14:52'),
	(153, 11, NULL, 'personel_site', '14', 'INSERT', 'null', '{"site_no": 1, "kayit_no": null, "personel_no": 9, "bitis_tarihi": null, "baslangic_tarihi": "2025-06-01"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 22:14:52'),
	(154, 11, NULL, 'personel_izin', '6', 'INSERT', 'null', '{"izin_no": null, "aciklama": "Yil sonu izni", "izin_tipi": "YILLIK", "gun_sayisi": 5, "personel_no": 9, "bitis_tarihi": "2026-12-05", "onaylayan_no": null, "onay_durum_no": 2, "baslangic_tarihi": "2026-12-01", "olusturma_tarihi": "2026-09-28T22:14:53.397840"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 22:14:53'),
	(155, 11, NULL, 'personel_izin', '6', 'UPDATE', '{"aciklama": "Yil sonu izni", "onaylayan_no": null, "onay_durum_no": 2}', '{"aciklama": "Yil sonu izni | Onaylandi", "onaylayan_no": 11, "onay_durum_no": 1}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 22:14:54'),
	(156, 11, NULL, 'personel_maas_odeme', '5', 'INSERT', 'null', '{"donem_ay": 11, "net_maas": null, "brut_maas": "25000.00", "donem_yil": 2026, "kesintiler": "3750.00", "personel_no": 9, "odeme_tarihi": "2026-11-30", "maas_odeme_no": null}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 22:14:55'),
	(157, 11, NULL, 'personel_site', '14', 'UPDATE', '{"bitis_tarihi": null}', '{"bitis_tarihi": "2026-12-31"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 22:14:57'),
	(158, 11, NULL, 'personel', '9', 'UPDATE', '{"aktif_mi": true, "isten_cikis_tarihi": null}', '{"aktif_mi": false, "isten_cikis_tarihi": "2026-12-31"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 22:14:57'),
	(159, 11, NULL, 'personel', '9', 'DELETE', '{"ad": "Ahmet", "soyad": "Usta", "gorevi": "GUVENLIK GOREVLISI", "e_posta": "ahmet.usta@ornek.com", "telefon": "05011112233", "aktif_mi": false, "firma_no": 1, "personel_no": 9, "kullanici_no": null, "tc_kimlik_sifreli": null, "ise_baslama_tarihi": "2025-06-01", "isten_cikis_tarihi": "2026-12-31"}', 'null', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 22:14:59'),
	(160, 11, NULL, 'personel_site', '14', 'DELETE', '{"site_no": 1, "kayit_no": 14, "personel_no": 9, "bitis_tarihi": "2026-12-31", "baslangic_tarihi": "2025-06-01"}', 'null', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 22:14:59'),
	(161, 11, NULL, 'personel_izin', '6', 'DELETE', '{"izin_no": 6, "aciklama": "Yil sonu izni | Onaylandi", "izin_tipi": "YILLIK", "gun_sayisi": 5, "personel_no": 9, "bitis_tarihi": "2026-12-05", "onaylayan_no": 11, "onay_durum_no": 1, "baslangic_tarihi": "2026-12-01", "olusturma_tarihi": "2026-09-28T22:14:53"}', 'null', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 22:14:59'),
	(162, 11, NULL, 'personel_maas_odeme', '5', 'DELETE', '{"donem_ay": 11, "net_maas": "21250.00", "brut_maas": "25000.00", "donem_yil": 2026, "kesintiler": "3750.00", "personel_no": 9, "odeme_tarihi": "2026-11-30", "maas_odeme_no": 5}', 'null', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 22:14:59'),
	(163, NULL, NULL, 'kullanici', '11', 'UPDATE', '{"son_giris_tarihi": "2026-09-28T22:14:51"}', '{"son_giris_tarihi": "2026-09-29T18:58:49.452207"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-29 18:58:50'),
	(164, NULL, NULL, 'kullanici', '11', 'UPDATE', '{"basarisiz_giris_sayisi": 0}', '{"basarisiz_giris_sayisi": 1}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 19:40:18'),
	(165, NULL, NULL, 'kullanici', '26', 'INSERT', 'null', '{"ad": "Pytest", "soyad": "User", "e_posta": "pytest@test.local", "aktif_mi": true, "firma_no": 1, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$/FonTMAVAMhEk7ldpaGleg$pgBR/OVYf7+pwgdIGxsH4v9SL2d13qFkbL8gkxBElog", "kullanici_no": null, "mfa_aktif_mi": null, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": null, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": null, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', NULL, NULL, '2026-09-29 19:42:15'),
	(166, NULL, NULL, 'kullanici', '27', 'INSERT', 'null', '{"ad": "Pytest", "soyad": "User", "e_posta": "pytest@test.local", "aktif_mi": true, "firma_no": 1, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$2wts2QnIeBf7UuQhPYJGAQ$riWqekkKgRqmgcAkGvWEgm6yPl0r+XCT5H1zxtmR/KM", "kullanici_no": null, "mfa_aktif_mi": null, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": null, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": null, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', NULL, NULL, '2026-09-29 20:04:35'),
	(167, NULL, NULL, 'kullanici', '28', 'INSERT', 'null', '{"ad": "Test", "soyad": "Register", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$r+XKbbj3TXFbShM+RIc8BQ$ZVzNhkMSI97Jr8CxtJjpNDcGGd1e6vyP9kaIBIoJ4Tw", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:15:51'),
	(168, NULL, NULL, 'kvkk_onay', '20', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:15:51.136348", "kullanici_no": 28, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:15:51'),
	(169, NULL, NULL, 'kullanici', '29', 'INSERT', 'null', '{"ad": "Test", "soyad": "Duplicate", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$QoVdKVLH48pqZiB0dOOyBg$fhQkgKZt4OH/tH8KO6aQq2EKoxeVJGaqRQvoOwZw+zk", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:15:52'),
	(170, NULL, NULL, 'kvkk_onay', '21', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:15:51.797184", "kullanici_no": 29, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:15:52'),
	(171, NULL, NULL, 'kullanici', '30', 'INSERT', 'null', '{"ad": "Login", "soyad": "Test", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$yAhHTnIeQQHlKEoN5gW7cA$6nQHCTmE+q2BQvra7AINCfD7T6/e9fJi3Jfoz90LWG8", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:15:52'),
	(172, NULL, NULL, 'kvkk_onay', '22', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:15:52.325372", "kullanici_no": 30, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:15:52'),
	(173, NULL, NULL, 'kullanici', '30', 'UPDATE', '{"son_giris_tarihi": null}', '{"son_giris_tarihi": "2026-09-29T20:15:52.794835"}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:15:53'),
	(174, NULL, NULL, 'kullanici', '31', 'INSERT', 'null', '{"ad": "Login", "soyad": "Wrong", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$D5Ebfr4+ZXxMUd6nQOdCDw$Tyw1vud5tPJpB2PKcFz+mrdsV1wQAlNW4dkM0Fm5zGs", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:15:53'),
	(175, NULL, NULL, 'kvkk_onay', '23', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:15:53.472693", "kullanici_no": 31, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:15:53'),
	(176, NULL, NULL, 'kullanici', '31', 'UPDATE', '{"basarisiz_giris_sayisi": 0}', '{"basarisiz_giris_sayisi": 1}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:15:54'),
	(177, NULL, NULL, 'kullanici', '32', 'INSERT', 'null', '{"ad": "Pytest", "soyad": "User", "e_posta": "pytest@example.com", "aktif_mi": true, "firma_no": 1, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$wq1uIoEzMXoprcH/KrNN0A$7jry0bzjXQ3pzpB/xnNq9D95/ihtJKqs1TLO0gJ8Ffw", "kullanici_no": null, "mfa_aktif_mi": null, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": null, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": null, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', NULL, NULL, '2026-09-29 20:15:55'),
	(178, NULL, NULL, 'kullanici', '33', 'INSERT', 'null', '{"ad": "Refresh", "soyad": "Test", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$tJt+LQbUJ3N5lJafrDyDoQ$6FknP11S3eCT96goETllhALurOw9xYvH/wKclNP2sPQ", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:15:55'),
	(179, NULL, NULL, 'kvkk_onay', '24', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:15:55.195623", "kullanici_no": 33, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:15:55'),
	(180, NULL, NULL, 'kullanici', '33', 'UPDATE', '{"son_giris_tarihi": null}', '{"son_giris_tarihi": "2026-09-29T20:15:55.494286"}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:15:56'),
	(181, NULL, NULL, 'kullanici', '34', 'INSERT', 'null', '{"ad": "Logout", "soyad": "Test", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$1IWiaztY/B+NcqeXvDMjBA$NUlUu3YIr2k7zbLrk8ibxr1rMMIXH6JgtwYclarGU2Q", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:15:56'),
	(182, NULL, NULL, 'kvkk_onay', '25', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:15:55.950520", "kullanici_no": 34, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:15:56'),
	(183, NULL, NULL, 'kullanici', '34', 'UPDATE', '{"son_giris_tarihi": null}', '{"son_giris_tarihi": "2026-09-29T20:15:56.192051"}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:15:56'),
	(184, NULL, NULL, 'kullanici', '35', 'INSERT', 'null', '{"ad": "Rate", "soyad": "Limit", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$MM4WMdzWOxZFfIcjkok/bA$qka9hXTQIKFQ1b0VzxQrcUEWYGgdOyAcTwsGX31PDQU", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:15:57'),
	(185, NULL, NULL, 'kvkk_onay', '26', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:15:56.723251", "kullanici_no": 35, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:15:57'),
	(186, NULL, NULL, 'kullanici', '35', 'UPDATE', '{"basarisiz_giris_sayisi": 0}', '{"basarisiz_giris_sayisi": 1}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:15:57'),
	(187, NULL, NULL, 'kullanici', '35', 'UPDATE', '{"basarisiz_giris_sayisi": 1}', '{"basarisiz_giris_sayisi": 2}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:15:57'),
	(188, NULL, NULL, 'kullanici', '35', 'UPDATE', '{"basarisiz_giris_sayisi": 2}', '{"basarisiz_giris_sayisi": 3}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:15:58'),
	(189, NULL, NULL, 'kullanici', '35', 'UPDATE', '{"basarisiz_giris_sayisi": 3}', '{"basarisiz_giris_sayisi": 4}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:15:58'),
	(190, NULL, NULL, 'kullanici', '35', 'UPDATE', '{"hesap_kilitli_mi": false, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 4}', '{"hesap_kilitli_mi": true, "kilit_acilma_tarihi": "2026-09-29T20:30:58.206694", "basarisiz_giris_sayisi": 5}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:15:58'),
	(191, NULL, NULL, 'kullanici', '36', 'INSERT', 'null', '{"ad": "Test", "soyad": "Register", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$KpL6pu9KMV67/e6nEp/xgw$0Lj9zRU4aB37Oi0F36+ciM2Z0R/o+cvhWHzCTa+f2XE", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:16:31'),
	(192, NULL, NULL, 'kvkk_onay', '27', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:16:31.199069", "kullanici_no": 36, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:16:31'),
	(193, NULL, NULL, 'kullanici', '37', 'INSERT', 'null', '{"ad": "Test", "soyad": "Duplicate", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$fmCYI4s4J6k7W0czNqcavw$TRg5SoaGHn0UsYtvPq6tQsTT4thEbR4SBM3YaiAOtt0", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:16:32'),
	(194, NULL, NULL, 'kvkk_onay', '28', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:16:32.180839", "kullanici_no": 37, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:16:32'),
	(195, NULL, NULL, 'kullanici', '38', 'INSERT', 'null', '{"ad": "Login", "soyad": "Test", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$MojnIcrcntsrDxUWGOzjuA$ITEtCgm2qX3Ej/QGZ0tJes1KY4jkNv/FGTnE0z2SRbE", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:16:33'),
	(196, NULL, NULL, 'kvkk_onay', '29', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:16:33.411153", "kullanici_no": 38, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:16:33'),
	(197, NULL, NULL, 'kullanici', '38', 'UPDATE', '{"son_giris_tarihi": null}', '{"son_giris_tarihi": "2026-09-29T20:16:33.857446"}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:16:34'),
	(198, NULL, NULL, 'kullanici', '39', 'INSERT', 'null', '{"ad": "Login", "soyad": "Wrong", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$6mW1bYHOLFk8v1WgPekodA$Bcn4Bo1IE8Xg6Ctrkb/zQ9WMgFgle2kanO9sw39sjRY", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:16:35'),
	(199, NULL, NULL, 'kvkk_onay', '30', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:16:34.731164", "kullanici_no": 39, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:16:35'),
	(200, NULL, NULL, 'kullanici', '39', 'UPDATE', '{"basarisiz_giris_sayisi": 0}', '{"basarisiz_giris_sayisi": 1}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:16:36'),
	(201, NULL, NULL, 'kullanici', '40', 'INSERT', 'null', '{"ad": "Refresh", "soyad": "Test", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$rCsQZnO5y7LaDz0EDn3RwA$fUym7K+RHBMQQVXUIfOVz0Kd7Dy9k2Uw5DqfzNtaetA", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:16:37'),
	(202, NULL, NULL, 'kvkk_onay', '31', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:16:36.906581", "kullanici_no": 40, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:16:37'),
	(203, NULL, NULL, 'kullanici', '40', 'UPDATE', '{"son_giris_tarihi": null}', '{"son_giris_tarihi": "2026-09-29T20:16:37.992777"}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:16:38'),
	(204, NULL, NULL, 'kullanici', '41', 'INSERT', 'null', '{"ad": "Logout", "soyad": "Test", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$MR/XcSM6mBqshVmCyJVAIg$b8jsLwlZC3rrJhtS0oTktPiEGfwHd63F5bo/xDiNNbs", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:16:39'),
	(205, NULL, NULL, 'kvkk_onay', '32', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:16:38.613844", "kullanici_no": 41, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:16:39'),
	(206, NULL, NULL, 'kullanici', '41', 'UPDATE', '{"son_giris_tarihi": null}', '{"son_giris_tarihi": "2026-09-29T20:16:38.885393"}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:16:39'),
	(207, NULL, NULL, 'kullanici', '42', 'INSERT', 'null', '{"ad": "Rate", "soyad": "Limit", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$3DZ4swD0Kp1uMPWIiGzXeA$9c2apJiO680+LZpznxUZEtrvFbnnRwR8QcBvxtazbh8", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:16:39'),
	(208, NULL, NULL, 'kvkk_onay', '33', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:16:39.252176", "kullanici_no": 42, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:16:39'),
	(209, NULL, NULL, 'kullanici', '42', 'UPDATE', '{"basarisiz_giris_sayisi": 0}', '{"basarisiz_giris_sayisi": 1}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:16:40'),
	(210, NULL, NULL, 'kullanici', '42', 'UPDATE', '{"basarisiz_giris_sayisi": 1}', '{"basarisiz_giris_sayisi": 2}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:16:40'),
	(211, NULL, NULL, 'kullanici', '42', 'UPDATE', '{"basarisiz_giris_sayisi": 2}', '{"basarisiz_giris_sayisi": 3}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:16:40'),
	(212, NULL, NULL, 'kullanici', '42', 'UPDATE', '{"basarisiz_giris_sayisi": 3}', '{"basarisiz_giris_sayisi": 4}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:16:40'),
	(213, NULL, NULL, 'kullanici', '42', 'UPDATE', '{"hesap_kilitli_mi": false, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 4}', '{"hesap_kilitli_mi": true, "kilit_acilma_tarihi": "2026-09-29T20:31:40.468920", "basarisiz_giris_sayisi": 5}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:16:40'),
	(214, NULL, NULL, 'kullanici', '43', 'INSERT', 'null', '{"ad": "Test", "soyad": "Register", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$Bu17crTb95xjHfLy2EeMIw$OIG6p/t3Y2F2ArwREiViLg4SpKkde2DGFvnj6++0R8M", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:18:13'),
	(215, NULL, NULL, 'kvkk_onay', '34', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:18:13.375528", "kullanici_no": 43, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:18:13'),
	(216, NULL, NULL, 'kullanici', '44', 'INSERT', 'null', '{"ad": "Test", "soyad": "Duplicate", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$e8pmeijwGgJfI8gqukq45A$3NvqLEtv19lpjIVUum90e7v2DOu9MoZYkigcSNhW2HE", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:18:14'),
	(217, NULL, NULL, 'kvkk_onay', '35', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:18:13.644971", "kullanici_no": 44, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:18:14'),
	(218, NULL, NULL, 'kullanici', '45', 'INSERT', 'null', '{"ad": "Login", "soyad": "Test", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$TJXUSnvBL8hAA1gWEqxXqQ$UZYiLXQ1aIpWohm6KouVgFUqYDVdgLFpR0oHXuqvMR4", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:18:14'),
	(219, NULL, NULL, 'kvkk_onay', '36', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:18:14.033001", "kullanici_no": 45, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:18:14'),
	(220, NULL, NULL, 'kullanici', '45', 'UPDATE', '{"son_giris_tarihi": null}', '{"son_giris_tarihi": "2026-09-29T20:18:14.323002"}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:18:14'),
	(221, NULL, NULL, 'kullanici', '46', 'INSERT', 'null', '{"ad": "Login", "soyad": "Wrong", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$iWLPGqAktZA37rrs+UFdtA$oE1jERFaZ1zU4s11mDn4l/utJjaWnpAg9coqEK4tIAo", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:18:15'),
	(222, NULL, NULL, 'kvkk_onay', '37', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:18:14.792942", "kullanici_no": 46, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:18:15'),
	(223, NULL, NULL, 'kullanici', '46', 'UPDATE', '{"basarisiz_giris_sayisi": 0}', '{"basarisiz_giris_sayisi": 1}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:18:15'),
	(224, NULL, NULL, 'kullanici', '47', 'INSERT', 'null', '{"ad": "Refresh", "soyad": "Test", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$ynKNeSdqvou6FWOmaypOFw$gDthDODWmlOYXnxyFwXUb9VEkEYAp8kncz66FR1dKqY", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:18:16'),
	(225, NULL, NULL, 'kvkk_onay', '38', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:18:16.189523", "kullanici_no": 47, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:18:16'),
	(226, NULL, NULL, 'kullanici', '47', 'UPDATE', '{"son_giris_tarihi": null}', '{"son_giris_tarihi": "2026-09-29T20:18:16.381123"}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:18:16'),
	(227, NULL, NULL, 'kullanici', '48', 'INSERT', 'null', '{"ad": "Logout", "soyad": "Test", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$U3/r7YPWSd4HJKrwBnHoTg$mA0Ue4c0ecOSkLIzgIMYw8bOiZjB5q+arfd4jOGiZMQ", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:18:17'),
	(228, NULL, NULL, 'kvkk_onay', '39', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:18:16.927118", "kullanici_no": 48, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:18:17'),
	(229, NULL, NULL, 'kullanici', '48', 'UPDATE', '{"son_giris_tarihi": null}', '{"son_giris_tarihi": "2026-09-29T20:18:17.149896"}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:18:17'),
	(230, NULL, NULL, 'kullanici', '49', 'INSERT', 'null', '{"ad": "Rate", "soyad": "Limit", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$piM0q4iRPGAFYdfkE58G4w$NZpjnMW/2ji+eFpGUdkI+aYHy+4xm7AcBjLFj/jupLs", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:18:18'),
	(231, NULL, NULL, 'kvkk_onay', '40', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:18:17.508752", "kullanici_no": 49, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:18:18'),
	(232, NULL, NULL, 'kullanici', '49', 'UPDATE', '{"basarisiz_giris_sayisi": 0}', '{"basarisiz_giris_sayisi": 1}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:18:18'),
	(233, NULL, NULL, 'kullanici', '49', 'UPDATE', '{"basarisiz_giris_sayisi": 1}', '{"basarisiz_giris_sayisi": 2}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:18:18'),
	(234, NULL, NULL, 'kullanici', '49', 'UPDATE', '{"basarisiz_giris_sayisi": 2}', '{"basarisiz_giris_sayisi": 3}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:18:18'),
	(235, NULL, NULL, 'kullanici', '49', 'UPDATE', '{"basarisiz_giris_sayisi": 3}', '{"basarisiz_giris_sayisi": 4}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:18:18'),
	(236, NULL, NULL, 'kullanici', '49', 'UPDATE', '{"hesap_kilitli_mi": false, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 4}', '{"hesap_kilitli_mi": true, "kilit_acilma_tarihi": "2026-09-29T20:33:18.406710", "basarisiz_giris_sayisi": 5}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:18:18'),
	(237, NULL, NULL, 'kullanici', '50', 'INSERT', 'null', '{"ad": "Test", "soyad": "Register", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$7tz81MNREkarof4oqZmgsg$+7F+SsIUQ2kUPX37GwumXsxTLCLOkJS1AKvPxYEMiAo", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:21:38'),
	(238, NULL, NULL, 'kvkk_onay', '41', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:21:38.023887", "kullanici_no": 50, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:21:38'),
	(239, NULL, NULL, 'kullanici', '51', 'INSERT', 'null', '{"ad": "Test", "soyad": "Duplicate", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$otXSJmguIg0OdLlCdvdNTQ$MoRVhvJdB2YANFtz0MOePTEpJSA7vTeGgODaedBaNIk", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:21:38'),
	(240, NULL, NULL, 'kvkk_onay', '42', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:21:38.391931", "kullanici_no": 51, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:21:38'),
	(241, NULL, NULL, 'kullanici', '52', 'INSERT', 'null', '{"ad": "Login", "soyad": "Test", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$StKqb9WIRlfwmffbhUISBg$nSi/fdt7lQfKtoUf0l+ZUFi6ji+2XucsgwXZGDqYzMs", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:21:39'),
	(242, NULL, NULL, 'kvkk_onay', '43', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:21:39.062758", "kullanici_no": 52, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:21:39'),
	(243, NULL, NULL, 'kullanici', '52', 'UPDATE', '{"son_giris_tarihi": null}', '{"son_giris_tarihi": "2026-09-29T20:21:39.299865"}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:21:39'),
	(244, NULL, NULL, 'kullanici', '53', 'INSERT', 'null', '{"ad": "Login", "soyad": "Wrong", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$iqrfEWclO9tfjyIEFi5gkw$FWYG/v51W9feO/Q5QJJ0NLQa1CiIot7qE9c6EAfy9SA", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:21:40'),
	(245, NULL, NULL, 'kvkk_onay', '44', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:21:39.621101", "kullanici_no": 53, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:21:40'),
	(246, NULL, NULL, 'kullanici', '53', 'UPDATE', '{"basarisiz_giris_sayisi": 0}', '{"basarisiz_giris_sayisi": 1}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:21:40'),
	(247, NULL, NULL, 'kullanici', '54', 'INSERT', 'null', '{"ad": "Refresh", "soyad": "Test", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$11dvVEipBoZZRlwMbI8mDA$MoRgx21e7ARgDfYahtlh+E9rmfEniPLKSnJJ0v0dcG8", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:21:40'),
	(248, NULL, NULL, 'kvkk_onay', '45', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:21:40.174052", "kullanici_no": 54, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:21:40'),
	(249, NULL, NULL, 'kullanici', '54', 'UPDATE', '{"son_giris_tarihi": null}', '{"son_giris_tarihi": "2026-09-29T20:21:40.339777"}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:21:40'),
	(250, NULL, NULL, 'kullanici', '55', 'INSERT', 'null', '{"ad": "Logout", "soyad": "Test", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$utcrkCJBq7pkkTaN3GQF1w$e53Q6wpovPQ09p6atfv5NYN9s4v4bhVcDoqdamVtfKQ", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:21:41'),
	(251, NULL, NULL, 'kvkk_onay', '46', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:21:40.669988", "kullanici_no": 55, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:21:41'),
	(252, NULL, NULL, 'kullanici', '55', 'UPDATE', '{"son_giris_tarihi": null}', '{"son_giris_tarihi": "2026-09-29T20:21:40.843709"}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:21:41'),
	(253, NULL, NULL, 'kullanici', '56', 'INSERT', 'null', '{"ad": "Rate", "soyad": "Limit", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$9kATWGwVy3WOYGb8kXVMyg$LQF8yd1ZnxAr3aHu7a5sGNLnyMJPjXXjiyA1SLrEEjA", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:21:41'),
	(254, NULL, NULL, 'kvkk_onay', '47', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:21:41.137259", "kullanici_no": 56, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:21:41'),
	(255, NULL, NULL, 'kullanici', '56', 'UPDATE', '{"basarisiz_giris_sayisi": 0}', '{"basarisiz_giris_sayisi": 1}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:21:41'),
	(256, NULL, NULL, 'kullanici', '56', 'UPDATE', '{"basarisiz_giris_sayisi": 1}', '{"basarisiz_giris_sayisi": 2}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:21:42'),
	(257, NULL, NULL, 'kullanici', '56', 'UPDATE', '{"basarisiz_giris_sayisi": 2}', '{"basarisiz_giris_sayisi": 3}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:21:42'),
	(258, NULL, NULL, 'kullanici', '56', 'UPDATE', '{"basarisiz_giris_sayisi": 3}', '{"basarisiz_giris_sayisi": 4}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:21:42'),
	(259, NULL, NULL, 'kullanici', '56', 'UPDATE', '{"hesap_kilitli_mi": false, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 4}', '{"hesap_kilitli_mi": true, "kilit_acilma_tarihi": "2026-09-29T20:36:42.184123", "basarisiz_giris_sayisi": 5}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:21:42'),
	(260, NULL, NULL, 'kullanici', '57', 'INSERT', 'null', '{"ad": "Test", "soyad": "Register", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$AFGWdjxVnttwnhXk27gGGw$ITZbEppfZgkJfykiFV94KM3wQ5HBTdLHEF5zdd65ZGM", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:08'),
	(261, NULL, NULL, 'kvkk_onay', '48', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:28:08.475261", "kullanici_no": 57, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:09'),
	(262, NULL, NULL, 'kullanici', '58', 'INSERT', 'null', '{"ad": "Test", "soyad": "Duplicate", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$bHp3LacIHWUXk0aSsqVHOw$PQao+jIpURwECehsFvx2cnylqi8uGNoz6ZWzkW/9OnE", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:11'),
	(263, NULL, NULL, 'kvkk_onay', '49', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:28:10.994985", "kullanici_no": 58, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:11'),
	(264, NULL, NULL, 'kullanici', '59', 'INSERT', 'null', '{"ad": "Login", "soyad": "Test", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$vW33jOLqInnDVuEWQCTHiQ$AS6JoArIoyTl0iKg3zwdP0AlVfaKVF+5HdG9UXdr2e0", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:12'),
	(265, NULL, NULL, 'kvkk_onay', '50', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:28:11.915381", "kullanici_no": 59, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:12'),
	(266, NULL, NULL, 'kullanici', '59', 'UPDATE', '{"son_giris_tarihi": null}', '{"son_giris_tarihi": "2026-09-29T20:28:12.516168"}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:13'),
	(267, NULL, NULL, 'kullanici', '60', 'INSERT', 'null', '{"ad": "Login", "soyad": "Wrong", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$n0herevAxjjUbDOhdTc5kQ$ovGLSDBbpsX83pGOevCPNp07PPnVpIfsN9xlmNo5r6g", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:14'),
	(268, NULL, NULL, 'kvkk_onay', '51', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:28:13.752352", "kullanici_no": 60, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:14'),
	(269, NULL, NULL, 'kullanici', '60', 'UPDATE', '{"basarisiz_giris_sayisi": 0}', '{"basarisiz_giris_sayisi": 1}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:14'),
	(270, NULL, NULL, 'kullanici', '61', 'INSERT', 'null', '{"ad": "Refresh", "soyad": "Test", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$lRNiQTEoIYOyZ/Wn4A/Yig$gW/n6kc25Kpcn7/ldmdHlYrg0bnWcLiEkgfVFwnhpWM", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:17'),
	(271, NULL, NULL, 'kvkk_onay', '52', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:28:16.773662", "kullanici_no": 61, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:17'),
	(272, NULL, NULL, 'kullanici', '61', 'UPDATE', '{"son_giris_tarihi": null}', '{"son_giris_tarihi": "2026-09-29T20:28:17.828147"}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:18'),
	(273, NULL, NULL, 'kullanici', '62', 'INSERT', 'null', '{"ad": "Logout", "soyad": "Test", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$BOMS+Zs+/79bDShrE3qMiQ$KNMjCISQioTU0kev73DFOg22kd+0JZjH/xGV0vBrEkM", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:19'),
	(274, NULL, NULL, 'kvkk_onay', '53', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:28:18.772559", "kullanici_no": 62, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:19'),
	(275, NULL, NULL, 'kullanici', '62', 'UPDATE', '{"son_giris_tarihi": null}', '{"son_giris_tarihi": "2026-09-29T20:28:19.249321"}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:19'),
	(276, NULL, NULL, 'kullanici', '63', 'INSERT', 'null', '{"ad": "Rate", "soyad": "Limit", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$r4EcSZHZpxmcoAGo87RoiQ$q21D87BpC2cvdv3DsevTep93lMscOfgzX2t9I5JPX8E", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:20'),
	(277, NULL, NULL, 'kvkk_onay', '54', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:28:20.061428", "kullanici_no": 63, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:20'),
	(278, NULL, NULL, 'kullanici', '63', 'UPDATE', '{"basarisiz_giris_sayisi": 0}', '{"basarisiz_giris_sayisi": 1}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:21'),
	(279, NULL, NULL, 'kullanici', '63', 'UPDATE', '{"basarisiz_giris_sayisi": 1}', '{"basarisiz_giris_sayisi": 2}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:21'),
	(280, NULL, NULL, 'kullanici', '63', 'UPDATE', '{"basarisiz_giris_sayisi": 2}', '{"basarisiz_giris_sayisi": 3}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:22'),
	(281, NULL, NULL, 'kullanici', '63', 'UPDATE', '{"basarisiz_giris_sayisi": 3}', '{"basarisiz_giris_sayisi": 4}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:22'),
	(282, NULL, NULL, 'kullanici', '63', 'UPDATE', '{"hesap_kilitli_mi": false, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 4}', '{"hesap_kilitli_mi": true, "kilit_acilma_tarihi": "2026-09-29T20:43:22.518261", "basarisiz_giris_sayisi": 5}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:23'),
	(283, NULL, NULL, 'kullanici', '64', 'INSERT', 'null', '{"ad": "Test", "soyad": "Register", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$Idy7v714kNOzHEUsDNgu7A$ve0kb38/FXW9aUD6KydEmNX1LUbQK+VtcrwC55UfE6E", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:44'),
	(284, NULL, NULL, 'kvkk_onay', '55', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:28:44.270971", "kullanici_no": 64, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:44'),
	(285, NULL, NULL, 'kullanici', '65', 'INSERT', 'null', '{"ad": "Test", "soyad": "Duplicate", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$9lLUjOILGNZTYNzb71t7bw$GKVFTX+rpfC/sDNPQm72EniDs0Te8OZR1Vh3V7Vwre8", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:45'),
	(286, NULL, NULL, 'kvkk_onay', '56', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:28:44.635602", "kullanici_no": 65, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:45'),
	(287, NULL, NULL, 'kullanici', '66', 'INSERT', 'null', '{"ad": "Login", "soyad": "Test", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$aLjSKlfyMX6wnXyuHpCnFg$nTIc2L4uBp1A89fnhqN1oN7AYZocWCDVvCk6Z5PNn3c", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:45'),
	(288, NULL, NULL, 'kvkk_onay', '57', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:28:45.138366", "kullanici_no": 66, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:45'),
	(289, NULL, NULL, 'kullanici', '66', 'UPDATE', '{"son_giris_tarihi": null}', '{"son_giris_tarihi": "2026-09-29T20:28:45.387594"}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:45'),
	(290, NULL, NULL, 'kullanici', '67', 'INSERT', 'null', '{"ad": "Login", "soyad": "Wrong", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$mMU05Q0uRhUyKqHn2Mu/KA$ZWy+qdGA/QlFPaFB6gq6ZDZlDkbGPTSmdJfVjZSfvS0", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:46'),
	(291, NULL, NULL, 'kvkk_onay', '58', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:28:45.758728", "kullanici_no": 67, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:46'),
	(292, NULL, NULL, 'kullanici', '67', 'UPDATE', '{"basarisiz_giris_sayisi": 0}', '{"basarisiz_giris_sayisi": 1}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:46'),
	(293, NULL, NULL, 'kullanici', '68', 'INSERT', 'null', '{"ad": "Refresh", "soyad": "Test", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$wJ7VgrGs6ogmp0Bb2Wa1Ug$kBn5qxBGGyWymYOGMs+BS9VG4XlFwV9R0pMqh7FxU5M", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:47'),
	(294, NULL, NULL, 'kvkk_onay', '59', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:28:47.470981", "kullanici_no": 68, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:47'),
	(295, NULL, NULL, 'kullanici', '68', 'UPDATE', '{"son_giris_tarihi": null}', '{"son_giris_tarihi": "2026-09-29T20:28:47.905734"}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:48'),
	(296, NULL, NULL, 'kullanici', '69', 'INSERT', 'null', '{"ad": "Logout", "soyad": "Test", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$+WyEvLQrikUDk61EwXV4nQ$NEdhyfqj/tTX6otd+evEbDjvOq86ikuEisVlK4a2xMk", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:49'),
	(297, NULL, NULL, 'kvkk_onay', '60', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:28:48.652547", "kullanici_no": 69, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:49'),
	(298, NULL, NULL, 'kullanici', '69', 'UPDATE', '{"son_giris_tarihi": null}', '{"son_giris_tarihi": "2026-09-29T20:28:49.214626"}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:49'),
	(299, NULL, NULL, 'kullanici', '70', 'INSERT', 'null', '{"ad": "Rate", "soyad": "Limit", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$61JzyS4/WZN3lUoCXq8n7w$0EhDOqjzvSlBdkYXGMtpVrOBSFZo/w2R+zWm9yXJVTg", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:50'),
	(300, NULL, NULL, 'kvkk_onay', '61', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:28:49.858719", "kullanici_no": 70, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:50'),
	(301, NULL, NULL, 'kullanici', '70', 'UPDATE', '{"basarisiz_giris_sayisi": 0}', '{"basarisiz_giris_sayisi": 1}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:50'),
	(302, NULL, NULL, 'kullanici', '70', 'UPDATE', '{"basarisiz_giris_sayisi": 1}', '{"basarisiz_giris_sayisi": 2}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:50'),
	(303, NULL, NULL, 'kullanici', '70', 'UPDATE', '{"basarisiz_giris_sayisi": 2}', '{"basarisiz_giris_sayisi": 3}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:51'),
	(304, NULL, NULL, 'kullanici', '70', 'UPDATE', '{"basarisiz_giris_sayisi": 3}', '{"basarisiz_giris_sayisi": 4}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:51'),
	(305, NULL, NULL, 'kullanici', '70', 'UPDATE', '{"hesap_kilitli_mi": false, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 4}', '{"hesap_kilitli_mi": true, "kilit_acilma_tarihi": "2026-09-29T20:43:51.669723", "basarisiz_giris_sayisi": 5}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:28:52'),
	(306, NULL, NULL, 'kullanici', '71', 'INSERT', 'null', '{"ad": "Test", "soyad": "Register", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$Qer/y6adHukwZU/AOybUEw$WHtalgJkWJKk5fsp3fBxd+y9oFBlHaQnyAOsi9tHwbc", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:34:38'),
	(307, NULL, NULL, 'kvkk_onay', '62', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:34:38.214274", "kullanici_no": 71, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:34:38'),
	(308, NULL, NULL, 'kullanici', '72', 'INSERT', 'null', '{"ad": "Test", "soyad": "Duplicate", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$gQvlY1R8KyAJgwTvXrtOTw$aQ6MTc7O7pGWb80fAEQkrG+AOv+iGWjdqckw9FdDXag", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:34:39'),
	(309, NULL, NULL, 'kvkk_onay', '63', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:34:38.825402", "kullanici_no": 72, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:34:39'),
	(310, NULL, NULL, 'kullanici', '73', 'INSERT', 'null', '{"ad": "Login", "soyad": "Test", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$mQ+A23KxEao9Mgra//ZLPQ$PVi89wuPTznbIN2lYvVuSIFytdhq88z7tXBo2ODCrmc", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:34:39'),
	(311, NULL, NULL, 'kvkk_onay', '64', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:34:39.292334", "kullanici_no": 73, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:34:39'),
	(312, NULL, NULL, 'kullanici', '73', 'UPDATE', '{"son_giris_tarihi": null}', '{"son_giris_tarihi": "2026-09-29T20:34:39.514352"}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:34:40'),
	(313, NULL, NULL, 'kullanici', '74', 'INSERT', 'null', '{"ad": "Login", "soyad": "Wrong", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$XoDunEzoprh42ACedbO0XQ$w6gcWMiLPpiEw6YiGOdNrjxdq/MKgItNyCvbFZjmyFw", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:34:40'),
	(314, NULL, NULL, 'kvkk_onay', '65', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:34:39.840880", "kullanici_no": 74, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:34:40'),
	(315, NULL, NULL, 'kullanici', '74', 'UPDATE', '{"basarisiz_giris_sayisi": 0}', '{"basarisiz_giris_sayisi": 1}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:34:40'),
	(316, NULL, NULL, 'kullanici', '75', 'INSERT', 'null', '{"ad": "Refresh", "soyad": "Test", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$kWKno14dNOh7tKktTfE+Zg$HbmVQPmGwIh2I7rMium6K3bzWkiUIrWLYfU4W/Un88M", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:34:40'),
	(317, NULL, NULL, 'kvkk_onay', '66', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:34:40.485189", "kullanici_no": 75, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:34:40'),
	(318, NULL, NULL, 'kullanici', '75', 'UPDATE', '{"son_giris_tarihi": null}', '{"son_giris_tarihi": "2026-09-29T20:34:40.645083"}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:34:41'),
	(319, NULL, NULL, 'kullanici', '76', 'INSERT', 'null', '{"ad": "Logout", "soyad": "Test", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$mB5nM9+uCQPt541n2Gj6Fw$vCEeZNQCQEBftXBAmVZC1l5B9oo6ctNNkdXPwstQyds", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:34:41'),
	(320, NULL, NULL, 'kvkk_onay', '67', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:34:40.967062", "kullanici_no": 76, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:34:41'),
	(321, NULL, NULL, 'kullanici', '76', 'UPDATE', '{"son_giris_tarihi": null}', '{"son_giris_tarihi": "2026-09-29T20:34:41.126493"}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:34:41'),
	(322, NULL, NULL, 'kullanici', '77', 'INSERT', 'null', '{"ad": "Rate", "soyad": "Limit", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$G1wVsAqr3fDk1DF2jK5Qog$TmLDy8KzJCT7DapJBM7GakwL8wLVSAS/wkpgQQYWRZY", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:34:41'),
	(323, NULL, NULL, 'kvkk_onay', '68', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:34:41.410411", "kullanici_no": 77, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:34:41'),
	(324, NULL, NULL, 'kullanici', '77', 'UPDATE', '{"basarisiz_giris_sayisi": 0}', '{"basarisiz_giris_sayisi": 1}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:34:42'),
	(325, NULL, NULL, 'kullanici', '77', 'UPDATE', '{"basarisiz_giris_sayisi": 1}', '{"basarisiz_giris_sayisi": 2}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:34:42'),
	(326, NULL, NULL, 'kullanici', '77', 'UPDATE', '{"basarisiz_giris_sayisi": 2}', '{"basarisiz_giris_sayisi": 3}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:34:42'),
	(327, NULL, NULL, 'kullanici', '77', 'UPDATE', '{"basarisiz_giris_sayisi": 3}', '{"basarisiz_giris_sayisi": 4}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:34:42'),
	(328, NULL, NULL, 'kullanici', '77', 'UPDATE', '{"hesap_kilitli_mi": false, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 4}', '{"hesap_kilitli_mi": true, "kilit_acilma_tarihi": "2026-09-29T20:49:42.285831", "basarisiz_giris_sayisi": 5}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:34:42'),
	(329, NULL, NULL, 'kullanici', '78', 'INSERT', 'null', '{"ad": "Test", "soyad": "Register", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$IZ0PRkpey/U37Vg1YWFp0w$cY52S+PKPUGtnThaMIR7dtd7tC8gO3SorZ0Truxosv0", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:44:30'),
	(330, NULL, NULL, 'kvkk_onay', '69', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:44:30.033726", "kullanici_no": 78, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:44:30'),
	(331, NULL, NULL, 'kullanici', '79', 'INSERT', 'null', '{"ad": "Test", "soyad": "Duplicate", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$mR5pMtpz3r9caz1VOEejkA$kY5o7fyo9wc5vfEcJrwJfrY2gQMpxrZeJmAhh9Df8MY", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:44:31'),
	(332, NULL, NULL, 'kvkk_onay', '70', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:44:30.928393", "kullanici_no": 79, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:44:31'),
	(333, NULL, NULL, 'kullanici', '80', 'INSERT', 'null', '{"ad": "Login", "soyad": "Test", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$NN468Yb9w1k3tG4BcFq7qg$14iueDtJlOR/NaRqjlxtX09QCsh/KOfUtNcovvByH/0", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:44:32'),
	(334, NULL, NULL, 'kvkk_onay', '71', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:44:31.699935", "kullanici_no": 80, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:44:32'),
	(335, NULL, NULL, 'kullanici', '80', 'UPDATE', '{"son_giris_tarihi": null}', '{"son_giris_tarihi": "2026-09-29T20:44:32.114758"}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:44:33'),
	(336, NULL, NULL, 'kullanici', '81', 'INSERT', 'null', '{"ad": "Login", "soyad": "Wrong", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$Nfo9z5CFVDA5kmOXxBdCvg$epkPLvASZ+3gZ/Owh4pjrTA5okmxKfSFhS93b89je5I", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:44:34'),
	(337, NULL, NULL, 'kvkk_onay', '72', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:44:34.009394", "kullanici_no": 81, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:44:34'),
	(338, NULL, NULL, 'kullanici', '81', 'UPDATE', '{"basarisiz_giris_sayisi": 0}', '{"basarisiz_giris_sayisi": 1}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:44:34'),
	(339, NULL, NULL, 'kullanici', '82', 'INSERT', 'null', '{"ad": "Refresh", "soyad": "Test", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$A+hNAux5vL+YIkA8izqcEg$O7VhEBwjTC5ZP0U9TksCsNdl2LQLOfBJs43viMIaKms", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:44:35'),
	(340, NULL, NULL, 'kvkk_onay', '73', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:44:34.955088", "kullanici_no": 82, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:44:35'),
	(341, NULL, NULL, 'kullanici', '82', 'UPDATE', '{"son_giris_tarihi": null}', '{"son_giris_tarihi": "2026-09-29T20:44:35.215366"}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:44:35'),
	(342, NULL, NULL, 'kullanici', '83', 'INSERT', 'null', '{"ad": "Logout", "soyad": "Test", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$yxVOENhLax6nv5FI2Ui0RQ$Vi9+4u7AeLKkt8dmy6nUeyJQNfcpxVFU8GsiSyLYruA", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:44:36'),
	(343, NULL, NULL, 'kvkk_onay', '74', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:44:35.725526", "kullanici_no": 83, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:44:36'),
	(344, NULL, NULL, 'kullanici', '83', 'UPDATE', '{"son_giris_tarihi": null}', '{"son_giris_tarihi": "2026-09-29T20:44:35.991880"}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:44:36'),
	(345, NULL, NULL, 'kullanici', '84', 'INSERT', 'null', '{"ad": "Test", "soyad": "Register", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$vKI3s8FFes1eJEQ3ahMFEQ$XKU1gG5ROhDKLTGF/c/DTi9lazikPlNlJ7Mx3lOcZ1k", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:45:01'),
	(346, NULL, NULL, 'kvkk_onay', '75', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:45:01.160751", "kullanici_no": 84, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:45:01'),
	(347, NULL, NULL, 'kullanici', '85', 'INSERT', 'null', '{"ad": "Test", "soyad": "Duplicate", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$QixfTAQCjMaR64AIlHktYQ$Vt1xEgkhRiTyTejyoEvyfw1SWOHLzMAmjGf0YLalbdY", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:45:02'),
	(348, NULL, NULL, 'kvkk_onay', '76', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:45:01.887022", "kullanici_no": 85, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:45:02'),
	(349, NULL, NULL, 'kullanici', '86', 'INSERT', 'null', '{"ad": "Login", "soyad": "Test", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$c8zeLPBkEgxVuq4jVRPH/Q$SdVGwbeEDc42albJUuqFfcaa0rdfVKqfY4EfDyfVeJg", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:45:03'),
	(350, NULL, NULL, 'kvkk_onay', '77', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:45:02.727714", "kullanici_no": 86, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:45:03'),
	(351, NULL, NULL, 'kullanici', '86', 'UPDATE', '{"son_giris_tarihi": null}', '{"son_giris_tarihi": "2026-09-29T20:45:03.009455"}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:45:03'),
	(352, NULL, NULL, 'kullanici', '87', 'INSERT', 'null', '{"ad": "Login", "soyad": "Wrong", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$9mY32MwGTuRA+fjprcPK0g$Q+QJY1ZdAY9mgf71KMiA5pbYYtq+R+bsXqsLRleQFa4", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:45:03'),
	(353, NULL, NULL, 'kvkk_onay', '78', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:45:03.502222", "kullanici_no": 87, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:45:04'),
	(354, NULL, NULL, 'kullanici', '87', 'UPDATE', '{"basarisiz_giris_sayisi": 0}', '{"basarisiz_giris_sayisi": 1}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:45:04'),
	(355, NULL, NULL, 'kullanici', '88', 'INSERT', 'null', '{"ad": "Refresh", "soyad": "Test", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$GerNHQZvx6f7SS8b6rS/Bg$NvUyO+FJ0vdzSQNa/D7B9MKZSFfToZPsPwDD0xzJPd0", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:45:04'),
	(356, NULL, NULL, 'kvkk_onay', '79', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:45:04.435746", "kullanici_no": 88, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:45:04'),
	(357, NULL, NULL, 'kullanici', '88', 'UPDATE', '{"son_giris_tarihi": null}', '{"son_giris_tarihi": "2026-09-29T20:45:04.664460"}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:45:05'),
	(358, NULL, NULL, 'kullanici', '89', 'INSERT', 'null', '{"ad": "Logout", "soyad": "Test", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$To1w1hrpv/II2kxuU/dVlw$mwj2MKYRnVDhK1egvc1kxZhHz37T/AXAc7RxPaYbavs", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:45:05'),
	(359, NULL, NULL, 'kvkk_onay', '80', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T20:45:05.137197", "kullanici_no": 89, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:45:05'),
	(360, NULL, NULL, 'kullanici', '89', 'UPDATE', '{"son_giris_tarihi": null}', '{"son_giris_tarihi": "2026-09-29T20:45:05.424268"}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 20:45:05'),
	(393, NULL, NULL, 'kullanici', '102', 'INSERT', 'null', '{"ad": "Test", "soyad": "Register", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$338ASyqBeCZbC+hTI6CRVg$l1HvU3yXijPdpP31j65zpVOu2POg2zWyTkiXsFES30c", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:01:46'),
	(394, NULL, NULL, 'kvkk_onay', '93', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T21:01:46.290180", "kullanici_no": 102, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:01:46'),
	(395, NULL, NULL, 'kullanici', '103', 'INSERT', 'null', '{"ad": "Test", "soyad": "Duplicate", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$NtWypzIP6PgYPhNkzTWvbg$ewl5ywyY7XEFoKXsn3HsTq3SwbEuvNE7UHE8ycpt45w", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:01:47'),
	(396, NULL, NULL, 'kvkk_onay', '94', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T21:01:46.888151", "kullanici_no": 103, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:01:47'),
	(397, NULL, NULL, 'kullanici', '104', 'INSERT', 'null', '{"ad": "Login", "soyad": "Test", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$qvedDFPI7Yw/kcTEkThasw$P5JysPo1fIRhG38+CVgeMImTxwzvQyrNUeeaM+1hbg4", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:01:48'),
	(398, NULL, NULL, 'kvkk_onay', '95', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T21:01:47.649526", "kullanici_no": 104, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:01:49'),
	(399, NULL, NULL, 'kullanici', '104', 'UPDATE', '{"son_giris_tarihi": null}', '{"son_giris_tarihi": "2026-09-29T21:01:49.268895"}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:01:49'),
	(400, NULL, NULL, 'kullanici', '105', 'INSERT', 'null', '{"ad": "Login", "soyad": "Wrong", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$sk+HVRBy6Ol+lwxRqB7ccw$E2UE6d4ye+F3l4NO5eG9j6bFh9/hrW5PjSaiR7jyXNM", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:01:50'),
	(401, NULL, NULL, 'kvkk_onay', '96', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T21:01:49.797795", "kullanici_no": 105, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:01:50'),
	(402, NULL, NULL, 'kullanici', '105', 'UPDATE', '{"basarisiz_giris_sayisi": 0}', '{"basarisiz_giris_sayisi": 1}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:01:50'),
	(403, NULL, NULL, 'kullanici', '106', 'INSERT', 'null', '{"ad": "Refresh", "soyad": "Test", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$0GQlegIvcPdBw11SQil9Xw$CzhLAd3BV5IzdCm7MnKCLY/nkeptzVV9DvMz2BjQ5lg", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:01:51'),
	(404, NULL, NULL, 'kvkk_onay', '97', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T21:01:51.365319", "kullanici_no": 106, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:01:51'),
	(405, NULL, NULL, 'kullanici', '106', 'UPDATE', '{"son_giris_tarihi": null}', '{"son_giris_tarihi": "2026-09-29T21:01:51.776175"}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:01:52'),
	(406, NULL, NULL, 'kullanici', '107', 'INSERT', 'null', '{"ad": "Logout", "soyad": "Test", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$J9ISy74EBWOTdoE8Wn+56w$OJLLamIHRhoiwPCyoDLZbzmflGZnsXaTwcyALaDmgWY", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:01:53'),
	(407, NULL, NULL, 'kvkk_onay', '98', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T21:01:52.546225", "kullanici_no": 107, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:01:53'),
	(408, NULL, NULL, 'kullanici', '107', 'UPDATE', '{"son_giris_tarihi": null}', '{"son_giris_tarihi": "2026-09-29T21:01:52.950109"}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:01:54'),
	(409, NULL, NULL, 'kullanici', '108', 'INSERT', 'null', '{"ad": "Rate", "soyad": "Limit", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$A3uBRXgPMKWtmDMQ1BmxZQ$sf1C85uqX957XhX6cPavemnVgyWhnUqbUKws300ORMA", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:01:55'),
	(410, NULL, NULL, 'kvkk_onay', '99', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T21:01:55.127647", "kullanici_no": 108, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:01:55'),
	(411, NULL, NULL, 'kullanici', '108', 'UPDATE', '{"basarisiz_giris_sayisi": 0}', '{"basarisiz_giris_sayisi": 1}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:01:56'),
	(412, NULL, NULL, 'kullanici', '108', 'UPDATE', '{"basarisiz_giris_sayisi": 1}', '{"basarisiz_giris_sayisi": 2}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:01:56'),
	(413, NULL, NULL, 'kullanici', '108', 'UPDATE', '{"basarisiz_giris_sayisi": 2}', '{"basarisiz_giris_sayisi": 3}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:01:56'),
	(414, NULL, NULL, 'kullanici', '108', 'UPDATE', '{"basarisiz_giris_sayisi": 3}', '{"basarisiz_giris_sayisi": 4}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:01:56'),
	(415, NULL, NULL, 'kullanici', '108', 'UPDATE', '{"hesap_kilitli_mi": false, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 4}', '{"hesap_kilitli_mi": true, "kilit_acilma_tarihi": "2026-09-29T21:16:56.568519", "basarisiz_giris_sayisi": 5}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:01:57'),
	(416, NULL, NULL, 'kullanici', '109', 'INSERT', 'null', '{"ad": "Ali", "soyad": "Yilmaz", "e_posta": "ali.yilmaz@mail.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$jgkk9T5qTFRHi1sk4NOFAw$gCf0dBAT/IrHeXisQY6VPZK0PInYd4chkcnXNYvoT0Q", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": "<binary 39 byte>", "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-29 21:02:23'),
	(417, NULL, NULL, 'kvkk_onay', '100', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T21:02:22.578803", "kullanici_no": 109, "onaylandi_mi": true}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-29 21:02:23'),
	(418, NULL, NULL, 'kullanici', '110', 'INSERT', 'null', '{"ad": "Ali", "soyad": "Yilmaz", "e_posta": "ali.yilmaz11@mail.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$9T7fe1mpjizz8Q0POyrx9A$akb0cDTamuZ00h28aYWNZt/ZsCBdH+ud54jz91e8J1E", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": "<binary 39 byte>", "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-29 21:02:47'),
	(419, NULL, NULL, 'kvkk_onay', '101', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T21:02:47.435179", "kullanici_no": 110, "onaylandi_mi": true}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-29 21:02:47'),
	(420, NULL, NULL, 'kullanici', '110', 'UPDATE', '{"son_giris_tarihi": null}', '{"son_giris_tarihi": "2026-09-29T21:03:32.632398"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-29 21:03:33'),
	(421, NULL, NULL, 'kullanici', '110', 'UPDATE', '{"son_giris_tarihi": "2026-09-29T21:03:33"}', '{"son_giris_tarihi": "2026-09-29T21:04:23.016476"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-29 21:04:23'),
	(422, NULL, NULL, 'kullanici', '111', 'INSERT', 'null', '{"ad": "Test", "soyad": "Register", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$Droai6l7Y5BShNhwJZGCSQ$M1TywPiHsFQsCsZwY2v6albysB2/YIhPc3VkDKvSzOw", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:08:03'),
	(423, NULL, NULL, 'kvkk_onay', '102', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T21:08:02.934891", "kullanici_no": 111, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:08:03'),
	(424, NULL, NULL, 'kullanici', '112', 'INSERT', 'null', '{"ad": "Test", "soyad": "Duplicate", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$hiVIGW/sW47oCZMye5ErfA$R751L8fZbJD5I6JRqd9cr/wyQfzse20kHEHAZmYGX/w", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:08:04'),
	(425, NULL, NULL, 'kvkk_onay', '103', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T21:08:04.499997", "kullanici_no": 112, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:08:05'),
	(426, NULL, NULL, 'kullanici', '113', 'INSERT', 'null', '{"ad": "Login", "soyad": "Test", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$2lJxKXif4dxZkFyoEIz2tg$Qqus6GWkWeg8dLB+VK95It9/wI90pJo85e58m61s2gA", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:08:05'),
	(427, NULL, NULL, 'kvkk_onay', '104', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T21:08:05.315566", "kullanici_no": 113, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:08:05'),
	(428, NULL, NULL, 'kullanici', '113', 'UPDATE', '{"son_giris_tarihi": null}', '{"son_giris_tarihi": "2026-09-29T21:08:05.519112"}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:08:06'),
	(429, NULL, NULL, 'kullanici', '114', 'INSERT', 'null', '{"ad": "Login", "soyad": "Wrong", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$mQpaC6DISlUUsyW7FdZHgw$l1P4VXKrQfdE7k6qj2dvyJoUgZC/j7GtpfQVOjLGLq0", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:08:06'),
	(430, NULL, NULL, 'kvkk_onay', '105', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T21:08:05.875646", "kullanici_no": 114, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:08:06'),
	(431, NULL, NULL, 'kullanici', '114', 'UPDATE', '{"basarisiz_giris_sayisi": 0}', '{"basarisiz_giris_sayisi": 1}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:08:06'),
	(432, NULL, NULL, 'kullanici', '115', 'INSERT', 'null', '{"ad": "Refresh", "soyad": "Test", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$vUGBsPmDWYSqLdBIeve7JA$xNWrsCDd0MWOJGUiemuVxzA54oQjYIY+tFK2N8WJL1o", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:08:07'),
	(433, NULL, NULL, 'kvkk_onay', '106', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T21:08:06.522157", "kullanici_no": 115, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:08:07'),
	(434, NULL, NULL, 'kullanici', '115', 'UPDATE', '{"son_giris_tarihi": null}', '{"son_giris_tarihi": "2026-09-29T21:08:06.714419"}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:08:07'),
	(435, NULL, NULL, 'kullanici', '116', 'INSERT', 'null', '{"ad": "Logout", "soyad": "Test", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$LsPbfjO5trudMcUf9vdJ0A$i0KliZ1EPcd/g3Xjk672caNPYsHyqgRcGzXayVpXW9k", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:08:07'),
	(436, NULL, NULL, 'kvkk_onay', '107', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T21:08:07.035155", "kullanici_no": 116, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:08:07'),
	(437, NULL, NULL, 'kullanici', '116', 'UPDATE', '{"son_giris_tarihi": null}', '{"son_giris_tarihi": "2026-09-29T21:08:07.237125"}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:08:07'),
	(438, NULL, NULL, 'kullanici', '117', 'INSERT', 'null', '{"ad": "Rate", "soyad": "Limit", "e_posta": "pytest.auth@example.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$Cr1CuY3VxWxFU8e5ye+7/Q$uGNZDZL7g1ecA7idAHpSKuAei0oo6sBM/YzfgRVz/+s", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": null, "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:08:08'),
	(439, NULL, NULL, 'kvkk_onay', '108', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-29T21:08:07.539503", "kullanici_no": 117, "onaylandi_mi": true}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:08:08'),
	(440, NULL, NULL, 'kullanici', '117', 'UPDATE', '{"basarisiz_giris_sayisi": 0}', '{"basarisiz_giris_sayisi": 1}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:08:08'),
	(441, NULL, NULL, 'kullanici', '117', 'UPDATE', '{"basarisiz_giris_sayisi": 1}', '{"basarisiz_giris_sayisi": 2}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:08:08'),
	(442, NULL, NULL, 'kullanici', '117', 'UPDATE', '{"basarisiz_giris_sayisi": 2}', '{"basarisiz_giris_sayisi": 3}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:08:08'),
	(443, NULL, NULL, 'kullanici', '117', 'UPDATE', '{"basarisiz_giris_sayisi": 3}', '{"basarisiz_giris_sayisi": 4}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:08:08'),
	(444, NULL, NULL, 'kullanici', '117', 'UPDATE', '{"hesap_kilitli_mi": false, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 4}', '{"hesap_kilitli_mi": true, "kilit_acilma_tarihi": "2026-09-29T21:23:08.552307", "basarisiz_giris_sayisi": 5}', _binary 0x7f000001, 'python-httpx/0.28.1', '2026-09-29 21:08:09'),
	(445, NULL, NULL, 'kullanici', '110', 'UPDATE', '{"son_giris_tarihi": "2026-09-29T21:04:23"}', '{"son_giris_tarihi": "2026-09-29T21:08:58.808194"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-29 21:08:59'),
	(446, NULL, NULL, 'kullanici', '110', 'UPDATE', '{"son_giris_tarihi": "2026-09-29T21:08:59", "kilit_acilma_tarihi": "2026-09-29T21:23:09"}', '{"son_giris_tarihi": "2026-09-29T21:13:12.556205", "kilit_acilma_tarihi": null}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-29 21:13:13'),
	(447, NULL, NULL, 'kullanici', '110', 'UPDATE', '{"son_giris_tarihi": "2026-09-29T21:13:13"}', '{"son_giris_tarihi": "2026-09-29T21:15:31.755600"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-29 21:15:32'),
	(448, NULL, NULL, 'kullanici', '110', 'UPDATE', '{"son_giris_tarihi": "2026-09-29T21:15:32"}', '{"son_giris_tarihi": "2026-09-29T21:50:57.440473"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-29 21:50:58'),
	(449, NULL, NULL, 'kullanici', '110', 'UPDATE', '{"son_giris_tarihi": "2026-09-29T21:50:57"}', '{"son_giris_tarihi": "2026-09-30T18:37:11.142411"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-30 18:37:11'),
	(450, NULL, NULL, 'kullanici', '110', 'UPDATE', '{"son_giris_tarihi": "2026-09-30T18:37:11"}', '{"son_giris_tarihi": "2026-09-30T18:39:16.274274"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-30 18:39:16'),
	(451, NULL, NULL, 'kullanici', '118', 'INSERT', 'null', '{"ad": "Neta", "soyad": "NEtam", "e_posta": "netaerk@mail.com", "aktif_mi": true, "firma_no": null, "sifre_hash": "$argon2id$v=19$m=65536,t=3,p=4$Z+AvY8XbJFn1AR/+Hkh8zg$PZNIqzkNMqqs4EFcACdIbcm1GyQZI+55s8T3hBslPq0", "kullanici_no": null, "mfa_aktif_mi": false, "tc_kimlik_hash": null, "telefon_sifreli": "<binary 39 byte>", "hesap_kilitli_mi": false, "olusturma_tarihi": null, "son_giris_tarihi": null, "tc_kimlik_sifreli": null, "guncellenme_tarihi": null, "mfa_secret_sifreli": null, "kilit_acilma_tarihi": null, "basarisiz_giris_sayisi": 0, "sifre_degistirme_tarihi": null, "sifre_hatirlatma_zorunlu": null}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-30 18:48:45'),
	(452, NULL, NULL, 'kvkk_onay', '109', 'INSERT', 'null', '{"onay_no": null, "metin_no": 1, "ip_adresi": "<binary 4 byte>", "onay_tipi": "AYDINLATMA", "onay_tarihi": "2026-09-30T18:48:44.790032", "kullanici_no": 118, "onaylandi_mi": true}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-30 18:48:45'),
	(453, NULL, NULL, 'kullanici', '118', 'UPDATE', '{"son_giris_tarihi": null}', '{"son_giris_tarihi": "2026-09-30T18:49:48.851047"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-30 18:49:49'),
	(454, NULL, NULL, 'kullanici', '110', 'UPDATE', '{"son_giris_tarihi": "2026-09-30T18:39:16"}', '{"son_giris_tarihi": "2026-09-30T19:37:58.698116"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-30 19:37:59'),
	(455, NULL, NULL, 'kullanici', '110', 'UPDATE', '{"son_giris_tarihi": "2026-09-30T19:37:59"}', '{"son_giris_tarihi": "2026-09-30T20:10:38.593407"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-30 20:10:39'),
	(456, NULL, NULL, 'kullanici', '110', 'UPDATE', '{"son_giris_tarihi": "2026-09-30T20:10:39"}', '{"son_giris_tarihi": "2026-09-30T20:12:42.658064"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-30 20:12:43'),
	(457, NULL, NULL, 'kullanici', '110', 'UPDATE', '{"son_giris_tarihi": "2026-09-30T20:12:43"}', '{"son_giris_tarihi": "2026-09-30T20:15:16.030000"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-30 20:15:16'),
	(458, NULL, NULL, 'kullanici', '110', 'UPDATE', '{"son_giris_tarihi": "2026-09-30T20:15:16"}', '{"son_giris_tarihi": "2026-09-30T20:34:29.721790"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-30 20:34:30'),
	(459, NULL, NULL, 'kullanici', '110', 'UPDATE', '{"son_giris_tarihi": "2026-09-30T20:34:30"}', '{"son_giris_tarihi": "2026-09-30T20:39:16.357167"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-30 20:39:16'),
	(460, NULL, NULL, 'kullanici', '110', 'UPDATE', '{"son_giris_tarihi": "2026-09-30T20:39:16"}', '{"son_giris_tarihi": "2026-09-30T21:01:47.941451"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-30 21:01:48'),
	(461, NULL, NULL, 'kullanici', '110', 'UPDATE', '{"son_giris_tarihi": "2026-09-30T21:01:48"}', '{"son_giris_tarihi": "2026-09-30T21:03:28.144332"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-30 21:03:28'),
	(462, NULL, NULL, 'kullanici', '110', 'UPDATE', '{"son_giris_tarihi": "2026-09-30T21:03:28"}', '{"son_giris_tarihi": "2026-09-30T21:09:26.805987"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-30 21:09:27'),
	(463, NULL, NULL, 'kullanici', '110', 'UPDATE', '{"son_giris_tarihi": "2026-09-30T21:09:27"}', '{"son_giris_tarihi": "2026-09-30T21:14:01.108889"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-30 21:14:01'),
	(464, NULL, NULL, 'kullanici', '110', 'UPDATE', '{"son_giris_tarihi": "2026-09-30T21:14:01"}', '{"son_giris_tarihi": "2026-10-05T17:38:30.256138"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 17:38:30'),
	(465, NULL, NULL, 'kullanici', '110', 'UPDATE', '{"son_giris_tarihi": "2026-10-05T17:38:30"}', '{"son_giris_tarihi": "2026-10-08T19:35:06.951020"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-08 19:35:07'),
	(466, NULL, NULL, 'kullanici', '110', 'UPDATE', '{"son_giris_tarihi": "2026-10-08T19:35:07"}', '{"son_giris_tarihi": "2026-10-08T19:54:23.268400"}', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-08 19:54:23');

-- tablo yapısı dökülüyor appapartman.banka_hareketi
CREATE TABLE IF NOT EXISTS `banka_hareketi` (
  `hareket_no` bigint NOT NULL AUTO_INCREMENT,
  `hesap_no` int NOT NULL,
  `hareket_tarihi` date NOT NULL,
  `aciklama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tutar` decimal(14,2) NOT NULL,
  `bakiye` decimal(14,2) NOT NULL,
  `karsi_hesap` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `karsi_iban` varchar(34) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `eslesti_mi` tinyint(1) NOT NULL DEFAULT '0',
  `olusturma_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`hareket_no`),
  KEY `idx_bh_hesap_tarih` (`hesap_no`,`hareket_tarihi`),
  KEY `idx_bh_eslesti` (`eslesti_mi`,`hareket_tarihi`),
  CONSTRAINT `banka_hareketi_ibfk_1` FOREIGN KEY (`hesap_no`) REFERENCES `banka_hesabi` (`hesap_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.banka_hareketi: ~4 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `banka_hareketi` (`hareket_no`, `hesap_no`, `hareket_tarihi`, `aciklama`, `tutar`, `bakiye`, `karsi_hesap`, `karsi_iban`, `eslesti_mi`, `olusturma_tarihi`) VALUES
	(1, 1, '2026-09-05', 'A Blok 1 Daire - Eylul Aidat', 1500.00, 1500.00, 'Ayse Sahin', NULL, 1, '2026-09-27 16:08:57'),
	(2, 1, '2026-09-08', 'B Blok 1 Daire - Eylul Aidat', 1500.00, 3000.00, 'Fatma Celik', NULL, 1, '2026-09-27 16:08:57'),
	(3, 1, '2026-09-10', 'Asansor Teknik Ltd. odeme', -2500.00, 500.00, 'Asansor Teknik', NULL, 1, '2026-09-27 16:08:57'),
	(4, 2, '2026-09-10', '1. Kat 1 Daire - Eylul Aidat', 2000.00, 2000.00, 'Mustafa Toprak', NULL, 0, '2026-09-27 16:08:57');

-- tablo yapısı dökülüyor appapartman.banka_hesabi
CREATE TABLE IF NOT EXISTS `banka_hesabi` (
  `hesap_no` int NOT NULL AUTO_INCREMENT,
  `site_no` int NOT NULL,
  `banka_adi` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sube_adi` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `iban_sifreli` varbinary(128) NOT NULL,
  `iban_hash` char(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hesap_sahibi` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `para_birimi` char(3) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'TRY',
  `aktif_mi` tinyint(1) NOT NULL DEFAULT '1',
  `olusturma_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`hesap_no`),
  UNIQUE KEY `iban_sifreli` (`iban_sifreli`),
  UNIQUE KEY `iban_hash` (`iban_hash`),
  KEY `site_no` (`site_no`),
  CONSTRAINT `banka_hesabi_ibfk_1` FOREIGN KEY (`site_no`) REFERENCES `site` (`site_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.banka_hesabi: ~2 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `banka_hesabi` (`hesap_no`, `site_no`, `banka_adi`, `sube_adi`, `iban_sifreli`, `iban_hash`, `hesap_sahibi`, `para_birimi`, `aktif_mi`, `olusturma_tarihi`) VALUES
	(1, 1, 'Ziraat Bankasi', 'Kadikoy Subesi', _binary 0xaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa, '672133eb15b7f9a4f79af64c08213e4856ed543e827838937d531bfab04fdc2e', 'Gul Sitesi Yonetimi', 'TRY', 1, '2026-09-27 16:08:57'),
	(2, 2, 'Is Bankasi', 'Cankaya Subesi', _binary 0xbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb, '72e44ef0e0e12c950266e255ed42b8864853f00e14cc6abc6eebf1d34593dc09', 'Yildiz Apartmani Yonetimi', 'TRY', 1, '2026-09-27 16:08:57');

-- tablo yapısı dökülüyor appapartman.banka_odeme_eslesme
CREATE TABLE IF NOT EXISTS `banka_odeme_eslesme` (
  `eslesme_no` int NOT NULL AUTO_INCREMENT,
  `hareket_no` bigint NOT NULL,
  `odeme_no` int NOT NULL,
  `eslesme_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`eslesme_no`),
  UNIQUE KEY `hareket_no` (`hareket_no`,`odeme_no`),
  KEY `odeme_no` (`odeme_no`),
  CONSTRAINT `banka_odeme_eslesme_ibfk_1` FOREIGN KEY (`hareket_no`) REFERENCES `banka_hareketi` (`hareket_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `banka_odeme_eslesme_ibfk_2` FOREIGN KEY (`odeme_no`) REFERENCES `odeme` (`odeme_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.banka_odeme_eslesme: ~2 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `banka_odeme_eslesme` (`eslesme_no`, `hareket_no`, `odeme_no`, `eslesme_tarihi`) VALUES
	(1, 1, 1, '2026-09-27 16:08:57'),
	(2, 2, 2, '2026-09-27 16:08:57');

-- tablo yapısı dökülüyor appapartman.belge
CREATE TABLE IF NOT EXISTS `belge` (
  `belge_no` bigint NOT NULL AUTO_INCREMENT,
  `site_no` int NOT NULL,
  `belge_adi` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kategori` enum('SOZLESME','FATURA','RAPOR','TUTANAK','DIGER') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DIGER',
  `guncel_versiyon` int NOT NULL DEFAULT '1',
  `yukleyen_no` int NOT NULL,
  `olusturma_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`belge_no`),
  KEY `site_no` (`site_no`),
  KEY `yukleyen_no` (`yukleyen_no`),
  CONSTRAINT `belge_ibfk_1` FOREIGN KEY (`site_no`) REFERENCES `site` (`site_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `belge_ibfk_2` FOREIGN KEY (`yukleyen_no`) REFERENCES `kullanici` (`kullanici_no`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.belge: ~2 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `belge` (`belge_no`, `site_no`, `belge_adi`, `kategori`, `guncel_versiyon`, `yukleyen_no`, `olusturma_tarihi`) VALUES
	(1, 1, 'Asansor Bakim Sozlesmesi 2026', 'SOZLESME', 1, 2, '2026-09-27 16:08:57'),
	(2, 2, 'Guvenlik Sozlesmesi 2026', 'SOZLESME', 1, 2, '2026-09-27 16:08:57');

-- tablo yapısı dökülüyor appapartman.belge_versiyon
CREATE TABLE IF NOT EXISTS `belge_versiyon` (
  `versiyon_no` int NOT NULL AUTO_INCREMENT,
  `belge_no` bigint NOT NULL,
  `versiyon` int NOT NULL,
  `dosya_yolu` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dosya_boyut` bigint DEFAULT NULL,
  `mime_type` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sha256_hash` char(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `yukleyen_no` int NOT NULL,
  `yukleme_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`versiyon_no`),
  UNIQUE KEY `belge_no` (`belge_no`,`versiyon`),
  KEY `yukleyen_no` (`yukleyen_no`),
  CONSTRAINT `belge_versiyon_ibfk_1` FOREIGN KEY (`belge_no`) REFERENCES `belge` (`belge_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `belge_versiyon_ibfk_2` FOREIGN KEY (`yukleyen_no`) REFERENCES `kullanici` (`kullanici_no`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.belge_versiyon: ~2 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `belge_versiyon` (`versiyon_no`, `belge_no`, `versiyon`, `dosya_yolu`, `dosya_boyut`, `mime_type`, `sha256_hash`, `yukleyen_no`, `yukleme_tarihi`) VALUES
	(1, 1, 1, '/belgeler/gul/asansor-sozlesme-2026.pdf', NULL, 'application/pdf', NULL, 2, '2026-09-27 16:08:57'),
	(2, 2, 1, '/belgeler/yildiz/guvenlik-sozlesme-2026.pdf', NULL, 'application/pdf', NULL, 2, '2026-09-27 16:08:57');

-- tablo yapısı dökülüyor appapartman.bildirim
CREATE TABLE IF NOT EXISTS `bildirim` (
  `bildirim_no` bigint NOT NULL AUTO_INCREMENT,
  `site_no` int NOT NULL,
  `gonderen_no` int NOT NULL,
  `hedef_no` int NOT NULL,
  `tip_no` int NOT NULL,
  `sablon_no` int DEFAULT NULL,
  `konu` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icerik` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `gonderim_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`bildirim_no`),
  KEY `gonderen_no` (`gonderen_no`),
  KEY `hedef_no` (`hedef_no`),
  KEY `tip_no` (`tip_no`),
  KEY `sablon_no` (`sablon_no`),
  KEY `idx_bildirim_site_tarih` (`site_no`,`gonderim_tarihi`),
  CONSTRAINT `bildirim_ibfk_1` FOREIGN KEY (`site_no`) REFERENCES `site` (`site_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bildirim_ibfk_2` FOREIGN KEY (`gonderen_no`) REFERENCES `kullanici` (`kullanici_no`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bildirim_ibfk_3` FOREIGN KEY (`hedef_no`) REFERENCES `bildirim_hedef` (`hedef_no`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bildirim_ibfk_4` FOREIGN KEY (`tip_no`) REFERENCES `bildirim_tipi` (`tip_no`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bildirim_ibfk_5` FOREIGN KEY (`sablon_no`) REFERENCES `bildirim_sablon` (`sablon_no`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.bildirim: ~2 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `bildirim` (`bildirim_no`, `site_no`, `gonderen_no`, `hedef_no`, `tip_no`, `sablon_no`, `konu`, `icerik`, `gonderim_tarihi`) VALUES
	(1, 1, 1, 1, 3, 2, 'Su Kesintisi', '25 Eylul 09:00-15:00 su kesintisi olacaktir.', '2026-09-27 16:08:57'),
	(2, 2, 1, 1, 2, 1, 'Aidat Hatirlatma', 'Eylul aidatlarinizin son odeme tarihi 30 Eylul dur.', '2026-09-27 16:08:57');

-- tablo yapısı dökülüyor appapartman.bildirim_alici
CREATE TABLE IF NOT EXISTS `bildirim_alici` (
  `alici_no` bigint NOT NULL AUTO_INCREMENT,
  `bildirim_no` bigint NOT NULL,
  `kullanici_no` int NOT NULL,
  `kanal_no` int NOT NULL,
  `durum_no` int NOT NULL DEFAULT '1',
  `gonderim_zamani` datetime DEFAULT NULL,
  `teslim_zamani` datetime DEFAULT NULL,
  `hata_mesaji` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deneme_sayisi` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`alici_no`),
  KEY `kanal_no` (`kanal_no`),
  KEY `durum_no` (`durum_no`),
  KEY `idx_ba_bildirim_durum` (`bildirim_no`,`durum_no`),
  KEY `idx_ba_kullanici` (`kullanici_no`,`gonderim_zamani`),
  CONSTRAINT `bildirim_alici_ibfk_1` FOREIGN KEY (`bildirim_no`) REFERENCES `bildirim` (`bildirim_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bildirim_alici_ibfk_2` FOREIGN KEY (`kullanici_no`) REFERENCES `kullanici` (`kullanici_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bildirim_alici_ibfk_3` FOREIGN KEY (`kanal_no`) REFERENCES `bildirim_tipi` (`tip_no`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bildirim_alici_ibfk_4` FOREIGN KEY (`durum_no`) REFERENCES `bildirim_durum` (`durum_no`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.bildirim_alici: ~3 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `bildirim_alici` (`alici_no`, `bildirim_no`, `kullanici_no`, `kanal_no`, `durum_no`, `gonderim_zamani`, `teslim_zamani`, `hata_mesaji`, `deneme_sayisi`) VALUES
	(1, 1, 4, 1, 3, '2026-09-23 09:00:00', '2026-09-23 09:00:05', NULL, 0),
	(2, 1, 5, 1, 3, '2026-09-23 09:00:00', '2026-09-23 09:00:07', NULL, 0),
	(3, 2, 6, 2, 3, '2026-09-25 10:00:00', '2026-09-25 10:00:02', NULL, 0);

-- tablo yapısı dökülüyor appapartman.bildirim_durum
CREATE TABLE IF NOT EXISTS `bildirim_durum` (
  `durum_no` int NOT NULL AUTO_INCREMENT,
  `ad` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`durum_no`),
  UNIQUE KEY `ad` (`ad`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.bildirim_durum: ~4 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `bildirim_durum` (`durum_no`, `ad`) VALUES
	(4, 'BASARISIZ'),
	(1, 'BEKLIYOR'),
	(2, 'GONDERILDI'),
	(3, 'TESLIM_EDILDI');

-- tablo yapısı dökülüyor appapartman.bildirim_hedef
CREATE TABLE IF NOT EXISTS `bildirim_hedef` (
  `hedef_no` int NOT NULL AUTO_INCREMENT,
  `ad` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`hedef_no`),
  UNIQUE KEY `ad` (`ad`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.bildirim_hedef: ~5 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `bildirim_hedef` (`hedef_no`, `ad`) VALUES
	(2, 'BELIRLI_DAIRE'),
	(5, 'BELIRLI_KULLANICI'),
	(4, 'PERSONEL'),
	(1, 'TUM_SAKINLER'),
	(3, 'YONETIM');

-- tablo yapısı dökülüyor appapartman.bildirim_kanal_ayar
CREATE TABLE IF NOT EXISTS `bildirim_kanal_ayar` (
  `ayar_no` int NOT NULL AUTO_INCREMENT,
  `site_no` int DEFAULT NULL,
  `kanal_no` int NOT NULL,
  `saglayici` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `yapilandirma` json DEFAULT NULL,
  `aktif_mi` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`ayar_no`),
  KEY `site_no` (`site_no`),
  KEY `kanal_no` (`kanal_no`),
  CONSTRAINT `bildirim_kanal_ayar_ibfk_1` FOREIGN KEY (`site_no`) REFERENCES `site` (`site_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bildirim_kanal_ayar_ibfk_2` FOREIGN KEY (`kanal_no`) REFERENCES `bildirim_tipi` (`tip_no`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.bildirim_kanal_ayar: ~2 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `bildirim_kanal_ayar` (`ayar_no`, `site_no`, `kanal_no`, `saglayici`, `yapilandirma`, `aktif_mi`) VALUES
	(1, 1, 1, 'NetGSM', '{"kullanici": "gulsitesi", "sifre_sifreli": "***"}', 1),
	(2, 1, 2, 'SMTP', '{"host": "smtp.gmail.com", "port": 587, "kullanici": "info@gulsitesi.com"}', 1);

-- tablo yapısı dökülüyor appapartman.bildirim_sablon
CREATE TABLE IF NOT EXISTS `bildirim_sablon` (
  `sablon_no` int NOT NULL AUTO_INCREMENT,
  `kod` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `baslik` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icerik` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `kanal_no` int DEFAULT NULL,
  `aktif_mi` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`sablon_no`),
  UNIQUE KEY `kod` (`kod`),
  KEY `kanal_no` (`kanal_no`),
  CONSTRAINT `bildirim_sablon_ibfk_1` FOREIGN KEY (`kanal_no`) REFERENCES `bildirim_tipi` (`tip_no`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.bildirim_sablon: ~2 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `bildirim_sablon` (`sablon_no`, `kod`, `baslik`, `icerik`, `kanal_no`, `aktif_mi`) VALUES
	(1, 'AIDAT_HATIRLATMA', 'Aidat Hatirlatma', 'Sayin {{ad}} {{soyad}}, {{donem}} donemi aidatinizin son odeme tarihi {{son_tarih}} dir.', 2, 1),
	(2, 'SU_KESINTI', 'Su Kesintisi', 'Sayin sakin, {{tarih}} tarihinde {{baslangic}}-{{bitis}} arasi su kesintisi olacaktir.', 1, 1);

-- tablo yapısı dökülüyor appapartman.bildirim_tipi
CREATE TABLE IF NOT EXISTS `bildirim_tipi` (
  `tip_no` int NOT NULL AUTO_INCREMENT,
  `ad` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`tip_no`),
  UNIQUE KEY `ad` (`ad`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.bildirim_tipi: ~3 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `bildirim_tipi` (`tip_no`, `ad`) VALUES
	(2, 'E_POSTA'),
	(3, 'PUSH'),
	(1, 'SMS');

-- tablo yapısı dökülüyor appapartman.blok
CREATE TABLE IF NOT EXISTS `blok` (
  `blok_no` int NOT NULL AUTO_INCREMENT,
  `site_no` int NOT NULL,
  `blok_adi` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kat_sayisi` tinyint NOT NULL DEFAULT '5',
  `olusturma_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`blok_no`),
  UNIQUE KEY `site_no` (`site_no`,`blok_adi`),
  CONSTRAINT `blok_ibfk_1` FOREIGN KEY (`site_no`) REFERENCES `site` (`site_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.blok: ~3 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `blok` (`blok_no`, `site_no`, `blok_adi`, `kat_sayisi`, `olusturma_tarihi`) VALUES
	(1, 1, 'A Blok', 4, '2026-09-27 16:08:57'),
	(2, 1, 'B Blok', 4, '2026-09-27 16:08:57'),
	(3, 2, 'Tek Blok', 6, '2026-09-27 16:08:57');

-- tablo yapısı dökülüyor appapartman.cari_hareket
CREATE TABLE IF NOT EXISTS `cari_hareket` (
  `hareket_no` bigint NOT NULL AUTO_INCREMENT,
  `cari_no` int NOT NULL,
  `hareket_tarihi` date NOT NULL,
  `islem_tipi_no` int NOT NULL,
  `tutar` decimal(14,2) NOT NULL,
  `aciklama` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `belge_no` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gider_no` int DEFAULT NULL,
  `odeme_no` int DEFAULT NULL,
  `olusturan_no` int DEFAULT NULL,
  `olusturma_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`hareket_no`),
  KEY `islem_tipi_no` (`islem_tipi_no`),
  KEY `olusturan_no` (`olusturan_no`),
  KEY `idx_ch_cari_tarih` (`cari_no`,`hareket_tarihi`),
  CONSTRAINT `cari_hareket_ibfk_1` FOREIGN KEY (`cari_no`) REFERENCES `cari_hesap` (`cari_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cari_hareket_ibfk_2` FOREIGN KEY (`islem_tipi_no`) REFERENCES `cari_islem_tipi` (`tip_no`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `cari_hareket_ibfk_3` FOREIGN KEY (`olusturan_no`) REFERENCES `kullanici` (`kullanici_no`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.cari_hareket: ~4 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `cari_hareket` (`hareket_no`, `cari_no`, `hareket_tarihi`, `islem_tipi_no`, `tutar`, `aciklama`, `belge_no`, `gider_no`, `odeme_no`, `olusturan_no`, `olusturma_tarihi`) VALUES
	(1, 1, '2026-09-01', 1, 2500.00, 'Eylul asansor bakimi', 'FTR-1001', NULL, NULL, 2, '2026-09-27 16:08:57'),
	(2, 1, '2026-09-10', 2, 2500.00, 'Odeme yapildi', 'BK-1001', NULL, NULL, 2, '2026-09-27 16:08:57'),
	(3, 2, '2026-09-01', 1, 6000.00, 'Eylul temizlik hizmeti', 'FTR-1002', NULL, NULL, 2, '2026-09-27 16:08:57'),
	(4, 3, '2026-09-01', 1, 8000.00, 'Eylul guvenlik hizmeti', 'FTR-2001', NULL, NULL, 2, '2026-09-27 16:08:57');

-- tablo yapısı dökülüyor appapartman.cari_hesap
CREATE TABLE IF NOT EXISTS `cari_hesap` (
  `cari_no` int NOT NULL AUTO_INCREMENT,
  `site_no` int NOT NULL,
  `unvan` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `vergi_no` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefon` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `e_posta` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `adres` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `iban` varchar(34) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `aktif_mi` tinyint(1) NOT NULL DEFAULT '1',
  `olusturma_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`cari_no`),
  KEY `idx_cari_site_aktif` (`site_no`,`aktif_mi`),
  CONSTRAINT `cari_hesap_ibfk_1` FOREIGN KEY (`site_no`) REFERENCES `site` (`site_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.cari_hesap: ~3 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `cari_hesap` (`cari_no`, `site_no`, `unvan`, `vergi_no`, `telefon`, `e_posta`, `adres`, `iban`, `aktif_mi`, `olusturma_tarihi`) VALUES
	(1, 1, 'Asansor Teknik Ltd.', '1111111111', '02165550001', NULL, NULL, NULL, 1, '2026-09-27 16:08:57'),
	(2, 1, 'Temizlik Hizmetleri A.S.', '2222222222', '02165550002', NULL, NULL, NULL, 1, '2026-09-27 16:08:57'),
	(3, 2, 'Guvenlik Sistemleri A.S.', '3333333333', '03125550003', NULL, NULL, NULL, 1, '2026-09-27 16:08:57');

-- tablo yapısı dökülüyor appapartman.cari_islem_tipi
CREATE TABLE IF NOT EXISTS `cari_islem_tipi` (
  `tip_no` int NOT NULL AUTO_INCREMENT,
  `ad` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`tip_no`),
  UNIQUE KEY `ad` (`ad`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.cari_islem_tipi: ~2 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `cari_islem_tipi` (`tip_no`, `ad`) VALUES
	(2, 'ALACAK'),
	(1, 'BORC');

-- tablo yapısı dökülüyor appapartman.daire
CREATE TABLE IF NOT EXISTS `daire` (
  `daire_no` int NOT NULL AUTO_INCREMENT,
  `site_no` int NOT NULL,
  `blok_no` int NOT NULL,
  `daire_numarasi` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kat` tinyint NOT NULL,
  `daire_tipi_no` int NOT NULL,
  `brut_metrekare` decimal(6,2) DEFAULT NULL,
  `ozel_aidat` decimal(10,2) DEFAULT NULL,
  `doluluk_no` int NOT NULL DEFAULT '1',
  `kullanim_no` int NOT NULL DEFAULT '1',
  `olusturma_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `guncellenme_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`daire_no`),
  UNIQUE KEY `blok_no` (`blok_no`,`daire_numarasi`),
  KEY `daire_tipi_no` (`daire_tipi_no`),
  KEY `doluluk_no` (`doluluk_no`),
  KEY `kullanim_no` (`kullanim_no`),
  KEY `idx_daire_site_doluluk` (`site_no`,`doluluk_no`),
  CONSTRAINT `daire_ibfk_1` FOREIGN KEY (`site_no`) REFERENCES `site` (`site_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `daire_ibfk_2` FOREIGN KEY (`blok_no`) REFERENCES `blok` (`blok_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `daire_ibfk_3` FOREIGN KEY (`daire_tipi_no`) REFERENCES `daire_tipi` (`tip_no`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `daire_ibfk_4` FOREIGN KEY (`doluluk_no`) REFERENCES `daire_doluluk` (`doluluk_no`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `daire_ibfk_5` FOREIGN KEY (`kullanim_no`) REFERENCES `daire_kullanim` (`kullanim_no`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.daire: ~6 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `daire` (`daire_no`, `site_no`, `blok_no`, `daire_numarasi`, `kat`, `daire_tipi_no`, `brut_metrekare`, `ozel_aidat`, `doluluk_no`, `kullanim_no`, `olusturma_tarihi`, `guncellenme_tarihi`) VALUES
	(1, 1, 1, '1', 0, 3, 85.00, NULL, 2, 1, '2026-09-27 16:08:57', '2026-09-29 00:24:30'),
	(2, 1, 1, '2', 0, 4, 110.00, 1800.00, 1, 2, '2026-09-27 16:08:57', '2026-09-29 00:24:30'),
	(3, 1, 2, '1', 0, 3, 85.00, NULL, 1, 2, '2026-09-27 16:08:57', '2026-09-27 16:08:57'),
	(4, 1, 2, '5', 1, 4, 115.00, NULL, 2, 3, '2026-09-27 16:08:57', '2026-09-29 00:24:27'),
	(5, 2, 3, '1', 0, 3, 90.00, NULL, 1, 1, '2026-09-27 16:08:57', '2026-09-27 16:08:57'),
	(6, 2, 3, '3', 1, 5, 140.00, NULL, 1, 1, '2026-09-27 16:08:57', '2026-09-27 16:08:57');

-- tablo yapısı dökülüyor appapartman.daire_doluluk
CREATE TABLE IF NOT EXISTS `daire_doluluk` (
  `doluluk_no` int NOT NULL AUTO_INCREMENT,
  `ad` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`doluluk_no`),
  UNIQUE KEY `ad` (`ad`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.daire_doluluk: ~2 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `daire_doluluk` (`doluluk_no`, `ad`) VALUES
	(2, 'BOS'),
	(1, 'DOLU');

-- tablo yapısı dökülüyor appapartman.daire_kullanim
CREATE TABLE IF NOT EXISTS `daire_kullanim` (
  `kullanim_no` int NOT NULL AUTO_INCREMENT,
  `ad` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`kullanim_no`),
  UNIQUE KEY `ad` (`ad`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.daire_kullanim: ~3 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `daire_kullanim` (`kullanim_no`, `ad`) VALUES
	(3, 'BOS'),
	(2, 'KIRACI'),
	(1, 'MALIK_OTURUYOR');

-- tablo yapısı dökülüyor appapartman.daire_sakin
CREATE TABLE IF NOT EXISTS `daire_sakin` (
  `kayit_no` int NOT NULL AUTO_INCREMENT,
  `daire_no` int NOT NULL,
  `kullanici_no` int NOT NULL,
  `mulk_sahibi_mi` tinyint(1) NOT NULL DEFAULT '0',
  `giris_tarihi` date NOT NULL,
  `cikis_tarihi` date DEFAULT NULL,
  `olusturma_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `guncellenme_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`kayit_no`),
  KEY `idx_ds_daire_aktif` (`daire_no`,`cikis_tarihi`),
  KEY `idx_ds_kullanici_aktif` (`kullanici_no`,`cikis_tarihi`),
  CONSTRAINT `daire_sakin_ibfk_1` FOREIGN KEY (`daire_no`) REFERENCES `daire` (`daire_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `daire_sakin_ibfk_2` FOREIGN KEY (`kullanici_no`) REFERENCES `kullanici` (`kullanici_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.daire_sakin: ~4 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `daire_sakin` (`kayit_no`, `daire_no`, `kullanici_no`, `mulk_sahibi_mi`, `giris_tarihi`, `cikis_tarihi`, `olusturma_tarihi`, `guncellenme_tarihi`) VALUES
	(16, 1, 4, 1, '2025-02-01', '2026-11-01', '2026-09-29 00:00:00', '2026-09-28 21:24:30'),
	(17, 3, 5, 0, '2025-03-01', NULL, '2026-09-29 00:00:00', '2026-09-29 00:00:00'),
	(18, 4, 6, 1, '2026-09-29', '2026-10-15', '2026-09-28 21:24:24', '2026-09-28 21:24:28'),
	(19, 2, 4, 1, '2026-11-01', NULL, '2026-09-28 21:24:30', '2026-09-28 21:24:30');

-- tablo yapısı dökülüyor appapartman.daire_sayaci
CREATE TABLE IF NOT EXISTS `daire_sayaci` (
  `daire_sayac_no` int NOT NULL AUTO_INCREMENT,
  `daire_no` int NOT NULL,
  `sayac_turu_no` int NOT NULL,
  `seri_no` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `montaj_tarihi` date DEFAULT NULL,
  `sokulme_tarihi` date DEFAULT NULL,
  `ilk_deger` decimal(12,2) NOT NULL DEFAULT '0.00',
  `aktif_mi` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`daire_sayac_no`),
  UNIQUE KEY `seri_no` (`seri_no`),
  KEY `daire_no` (`daire_no`),
  KEY `sayac_turu_no` (`sayac_turu_no`),
  KEY `idx_ds_aktif` (`aktif_mi`),
  CONSTRAINT `daire_sayaci_ibfk_1` FOREIGN KEY (`daire_no`) REFERENCES `daire` (`daire_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `daire_sayaci_ibfk_2` FOREIGN KEY (`sayac_turu_no`) REFERENCES `sayac_turu` (`sayac_turu_no`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.daire_sayaci: ~5 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `daire_sayaci` (`daire_sayac_no`, `daire_no`, `sayac_turu_no`, `seri_no`, `montaj_tarihi`, `sokulme_tarihi`, `ilk_deger`, `aktif_mi`) VALUES
	(1, 1, 1, 'SS-0001', '2025-01-01', NULL, 100.00, 1),
	(2, 2, 1, 'SS-0002', '2025-01-01', NULL, 180.00, 1),
	(3, 3, 1, 'SS-0003', '2025-01-01', NULL, 80.00, 1),
	(4, 5, 1, 'SS-0004', '2025-01-01', NULL, 140.00, 1),
	(5, 6, 1, 'SS-0005', '2025-01-01', NULL, 300.00, 1),
	(6, 2, 3, 'DG-TEST-001', '2026-09-28', NULL, 0.00, 1);

-- tablo yapısı dökülüyor appapartman.daire_tipi
CREATE TABLE IF NOT EXISTS `daire_tipi` (
  `tip_no` int NOT NULL AUTO_INCREMENT,
  `ad` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`tip_no`),
  UNIQUE KEY `ad` (`ad`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.daire_tipi: ~6 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `daire_tipi` (`tip_no`, `ad`) VALUES
	(1, '1+0'),
	(2, '1+1'),
	(3, '2+1'),
	(4, '3+1'),
	(5, '4+1'),
	(6, 'DUBLEKS');

-- tablo yapısı dökülüyor appapartman.demirbas
CREATE TABLE IF NOT EXISTS `demirbas` (
  `demirbas_no` int NOT NULL AUTO_INCREMENT,
  `site_no` int NOT NULL,
  `ad` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kategori` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `adet` smallint NOT NULL DEFAULT '1',
  `alis_fiyati` decimal(14,2) DEFAULT NULL,
  `alis_tarihi` date DEFAULT NULL,
  `bulundugu_yer` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `durum` enum('CALISIYOR','ARIZALI','HURDA') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'CALISIYOR',
  PRIMARY KEY (`demirbas_no`),
  KEY `idx_demirbas_site_durum` (`site_no`,`durum`),
  CONSTRAINT `demirbas_ibfk_1` FOREIGN KEY (`site_no`) REFERENCES `site` (`site_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.demirbas: ~1 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `demirbas` (`demirbas_no`, `site_no`, `ad`, `kategori`, `adet`, `alis_fiyati`, `alis_tarihi`, `bulundugu_yer`, `durum`) VALUES
	(2, 2, 'Jenerator', 'ENERJI', 1, 350000.00, '2021-01-15', 'Bodrum', 'CALISIYOR');

-- tablo yapısı dökülüyor appapartman.demirbas_hareket
CREATE TABLE IF NOT EXISTS `demirbas_hareket` (
  `hareket_no` bigint NOT NULL AUTO_INCREMENT,
  `demirbas_no` int NOT NULL,
  `hareket_tipi` enum('ZIMBET','BAKIM','ONARIM','YER_DEGISIKLIGI','HURDA') COLLATE utf8mb4_unicode_ci NOT NULL,
  `kullanici_no` int DEFAULT NULL,
  `tarih` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `aciklama` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `maliyet` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`hareket_no`),
  KEY `demirbas_no` (`demirbas_no`),
  KEY `kullanici_no` (`kullanici_no`),
  CONSTRAINT `demirbas_hareket_ibfk_1` FOREIGN KEY (`demirbas_no`) REFERENCES `demirbas` (`demirbas_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `demirbas_hareket_ibfk_2` FOREIGN KEY (`kullanici_no`) REFERENCES `kullanici` (`kullanici_no`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.demirbas_hareket: ~0 rows (yaklaşık) tablosu için veriler indiriliyor

-- tablo yapısı dökülüyor appapartman.duyuru
CREATE TABLE IF NOT EXISTS `duyuru` (
  `duyuru_no` bigint NOT NULL AUTO_INCREMENT,
  `site_no` int NOT NULL,
  `baslik` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icerik` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `onem_derecesi` enum('NORMAL','ONEMLI','ACIL') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NORMAL',
  `yayin_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `bitis_tarihi` date DEFAULT NULL,
  `yayinlayan_no` int NOT NULL,
  PRIMARY KEY (`duyuru_no`),
  KEY `yayinlayan_no` (`yayinlayan_no`),
  KEY `idx_duyuru_site_tarih` (`site_no`,`yayin_tarihi`),
  CONSTRAINT `duyuru_ibfk_1` FOREIGN KEY (`site_no`) REFERENCES `site` (`site_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `duyuru_ibfk_2` FOREIGN KEY (`yayinlayan_no`) REFERENCES `kullanici` (`kullanici_no`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.duyuru: ~2 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `duyuru` (`duyuru_no`, `site_no`, `baslik`, `icerik`, `onem_derecesi`, `yayin_tarihi`, `bitis_tarihi`, `yayinlayan_no`) VALUES
	(2, 2, 'Asansor Bakimi', 'Asansor periyodik bakimi 22 Eylul yapilacaktir.', 'ONEMLI', '2026-09-27 16:08:57', '2026-09-22', 1);

-- tablo yapısı dökülüyor appapartman.duyuru_okuma
CREATE TABLE IF NOT EXISTS `duyuru_okuma` (
  `okuma_no` bigint NOT NULL AUTO_INCREMENT,
  `duyuru_no` bigint NOT NULL,
  `kullanici_no` int NOT NULL,
  `okuma_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`okuma_no`),
  UNIQUE KEY `duyuru_no` (`duyuru_no`,`kullanici_no`),
  KEY `kullanici_no` (`kullanici_no`),
  CONSTRAINT `duyuru_okuma_ibfk_1` FOREIGN KEY (`duyuru_no`) REFERENCES `duyuru` (`duyuru_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `duyuru_okuma_ibfk_2` FOREIGN KEY (`kullanici_no`) REFERENCES `kullanici` (`kullanici_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.duyuru_okuma: ~0 rows (yaklaşık) tablosu için veriler indiriliyor

-- tablo yapısı dökülüyor appapartman.gelir
CREATE TABLE IF NOT EXISTS `gelir` (
  `gelir_no` bigint NOT NULL AUTO_INCREMENT,
  `site_no` int NOT NULL,
  `kaynak` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tutar` decimal(14,2) NOT NULL,
  `gelir_tarihi` date NOT NULL,
  `aciklama` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kaydeden_no` int NOT NULL,
  `olusturma_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`gelir_no`),
  KEY `kaydeden_no` (`kaydeden_no`),
  KEY `idx_gelir_site_tarih` (`site_no`,`gelir_tarihi`),
  CONSTRAINT `gelir_ibfk_1` FOREIGN KEY (`site_no`) REFERENCES `site` (`site_no`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `gelir_ibfk_2` FOREIGN KEY (`kaydeden_no`) REFERENCES `kullanici` (`kullanici_no`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.gelir: ~3 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `gelir` (`gelir_no`, `site_no`, `kaynak`, `tutar`, `gelir_tarihi`, `aciklama`, `kaydeden_no`, `olusturma_tarihi`) VALUES
	(1, 1, 'Aidat Tahsilati', 3000.00, '2026-09-08', 'Eylul aidati tahsilatlari', 2, '2026-09-27 16:08:57'),
	(2, 1, 'Kira Geliri', 1500.00, '2026-09-01', 'Kapici dairesi kirasi', 2, '2026-09-27 16:08:57'),
	(3, 2, 'Aidat Tahsilati', 2000.00, '2026-09-10', 'Eylul aidati tahsilati', 2, '2026-09-27 16:08:57');

-- tablo yapısı dökülüyor appapartman.gider
CREATE TABLE IF NOT EXISTS `gider` (
  `gider_no` bigint NOT NULL AUTO_INCREMENT,
  `site_no` int NOT NULL,
  `kalem_no` int NOT NULL,
  `cari_no` int DEFAULT NULL,
  `tutar` decimal(14,2) NOT NULL,
  `kdv_tutar` decimal(14,2) NOT NULL DEFAULT '0.00',
  `gider_tarihi` date NOT NULL,
  `belge_no` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `aciklama` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kaydeden_no` int NOT NULL,
  `olusturma_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `guncellenme_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`gider_no`),
  KEY `kalem_no` (`kalem_no`),
  KEY `cari_no` (`cari_no`),
  KEY `kaydeden_no` (`kaydeden_no`),
  KEY `idx_gider_site_tarih` (`site_no`,`gider_tarihi`),
  KEY `idx_gider_site_kalem_tarih` (`site_no`,`kalem_no`,`gider_tarihi`),
  CONSTRAINT `gider_ibfk_1` FOREIGN KEY (`site_no`) REFERENCES `site` (`site_no`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `gider_ibfk_2` FOREIGN KEY (`kalem_no`) REFERENCES `gider_kalemi` (`kalem_no`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `gider_ibfk_3` FOREIGN KEY (`cari_no`) REFERENCES `cari_hesap` (`cari_no`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `gider_ibfk_4` FOREIGN KEY (`kaydeden_no`) REFERENCES `kullanici` (`kullanici_no`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.gider: ~5 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `gider` (`gider_no`, `site_no`, `kalem_no`, `cari_no`, `tutar`, `kdv_tutar`, `gider_tarihi`, `belge_no`, `aciklama`, `kaydeden_no`, `olusturma_tarihi`, `guncellenme_tarihi`) VALUES
	(1, 1, 1, 1, 2500.00, 0.00, '2026-09-01', 'FTR-1001', 'Eylul asansor bakimi', 2, '2026-09-27 16:08:57', '2026-09-27 16:08:57'),
	(2, 1, 2, 2, 6000.00, 0.00, '2026-09-01', 'FTR-1002', 'Eylul temizlik', 2, '2026-09-27 16:08:57', '2026-09-27 16:08:57'),
	(3, 1, 4, NULL, 3200.00, 0.00, '2026-09-05', 'FTR-1003', 'Ortak alan elektrik', 2, '2026-09-27 16:08:57', '2026-09-27 16:08:57'),
	(4, 2, 3, 3, 8000.00, 0.00, '2026-09-01', 'FTR-2001', 'Eylul guvenlik', 2, '2026-09-27 16:08:57', '2026-09-27 16:08:57');

-- tablo yapısı dökülüyor appapartman.gider_kalemi
CREATE TABLE IF NOT EXISTS `gider_kalemi` (
  `kalem_no` int NOT NULL AUTO_INCREMENT,
  `kalem_adi` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kategori_no` int NOT NULL,
  PRIMARY KEY (`kalem_no`),
  UNIQUE KEY `kalem_adi` (`kalem_adi`,`kategori_no`),
  KEY `kategori_no` (`kategori_no`),
  CONSTRAINT `gider_kalemi_ibfk_1` FOREIGN KEY (`kategori_no`) REFERENCES `gider_kategori` (`kategori_no`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.gider_kalemi: ~6 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `gider_kalemi` (`kalem_no`, `kalem_adi`, `kategori_no`) VALUES
	(1, 'Asansor Periyodik Bakimi', 1),
	(6, 'Dogalgaz Faturasi', 8),
	(4, 'Elektrik Faturasi', 6),
	(3, 'Ozel Guvenlik Hizmeti', 3),
	(2, 'Site Temizlik Hizmeti', 2),
	(5, 'Su Faturasi', 7);

-- tablo yapısı dökülüyor appapartman.gider_kategori
CREATE TABLE IF NOT EXISTS `gider_kategori` (
  `kategori_no` int NOT NULL AUTO_INCREMENT,
  `ad` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`kategori_no`),
  UNIQUE KEY `ad` (`ad`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.gider_kategori: ~11 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `gider_kategori` (`kategori_no`, `ad`) VALUES
	(1, 'ASANSOR'),
	(4, 'BAKIM'),
	(11, 'DIGER'),
	(8, 'DOGALGAZ'),
	(6, 'ENERJI'),
	(3, 'GUVENLIK'),
	(5, 'ONARIM'),
	(10, 'PERSONEL'),
	(9, 'PEYZAJ'),
	(7, 'SU'),
	(2, 'TEMIZLIK');

-- tablo yapısı dökülüyor appapartman.icra_takip
CREATE TABLE IF NOT EXISTS `icra_takip` (
  `icra_no` int NOT NULL AUTO_INCREMENT,
  `aidat_no` int NOT NULL,
  `avukat_cari_no` int DEFAULT NULL,
  `dosya_no` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `baslama_tarihi` date NOT NULL,
  `durum` enum('BASLADI','TEBLIG_EDILDI','ITIRAZ','DAVA','TAHSIL_EDILDI','KAPANDI') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'BASLADI',
  `toplam_borc` decimal(12,2) NOT NULL,
  `faiz_tutari` decimal(12,2) NOT NULL DEFAULT '0.00',
  `tahsil_tutar` decimal(12,2) NOT NULL DEFAULT '0.00',
  `kapanma_tarihi` date DEFAULT NULL,
  `aciklama` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`icra_no`),
  KEY `aidat_no` (`aidat_no`),
  KEY `idx_icra_durum` (`durum`),
  CONSTRAINT `icra_takip_ibfk_1` FOREIGN KEY (`aidat_no`) REFERENCES `aidat` (`aidat_no`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.icra_takip: ~0 rows (yaklaşık) tablosu için veriler indiriliyor

-- tablo yapısı dökülüyor appapartman.is_durum
CREATE TABLE IF NOT EXISTS `is_durum` (
  `durum_no` int NOT NULL AUTO_INCREMENT,
  `ad` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kapanis_mi` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`durum_no`),
  UNIQUE KEY `ad` (`ad`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.is_durum: ~5 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `is_durum` (`durum_no`, `ad`, `kapanis_mi`) VALUES
	(1, 'ACIK', 0),
	(2, 'ATANDI', 0),
	(3, 'UZERINDE_CALISIYOR', 0),
	(4, 'TAMAMLANDI', 1),
	(5, 'IPTAL', 1);

-- tablo yapısı dökülüyor appapartman.is_emri
CREATE TABLE IF NOT EXISTS `is_emri` (
  `is_no` bigint NOT NULL AUTO_INCREMENT,
  `site_no` int NOT NULL,
  `daire_no` int DEFAULT NULL,
  `acan_no` int NOT NULL,
  `atanan_no` int NOT NULL,
  `baslik` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `aciklama` text COLLATE utf8mb4_unicode_ci,
  `oncelik_no` int NOT NULL,
  `durum_no` int NOT NULL,
  `olusturma_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `termin_tarihi` datetime DEFAULT NULL,
  `tamamlanma_tarihi` datetime DEFAULT NULL,
  `guncellenme_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`is_no`),
  KEY `daire_no` (`daire_no`),
  KEY `acan_no` (`acan_no`),
  KEY `oncelik_no` (`oncelik_no`),
  KEY `durum_no` (`durum_no`),
  KEY `idx_is_site_durum` (`site_no`,`durum_no`),
  KEY `idx_is_atanan_durum` (`atanan_no`,`durum_no`),
  KEY `idx_is_site_oncelik_durum` (`site_no`,`oncelik_no`,`durum_no`),
  CONSTRAINT `is_emri_ibfk_1` FOREIGN KEY (`site_no`) REFERENCES `site` (`site_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `is_emri_ibfk_2` FOREIGN KEY (`daire_no`) REFERENCES `daire` (`daire_no`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `is_emri_ibfk_3` FOREIGN KEY (`acan_no`) REFERENCES `kullanici` (`kullanici_no`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `is_emri_ibfk_4` FOREIGN KEY (`atanan_no`) REFERENCES `kullanici` (`kullanici_no`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `is_emri_ibfk_5` FOREIGN KEY (`oncelik_no`) REFERENCES `is_oncelik` (`oncelik_no`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `is_emri_ibfk_6` FOREIGN KEY (`durum_no`) REFERENCES `is_durum` (`durum_no`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.is_emri: ~1 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `is_emri` (`is_no`, `site_no`, `daire_no`, `acan_no`, `atanan_no`, `baslik`, `aciklama`, `oncelik_no`, `durum_no`, `olusturma_tarihi`, `termin_tarihi`, `tamamlanma_tarihi`, `guncellenme_tarihi`) VALUES
	(3, 2, 6, 1, 3, 'Klozet Rezervuar Arizasi', 'Rezervuar ic takim degisimi.', 2, 2, '2026-09-27 16:08:57', '2026-09-18 18:00:00', NULL, '2026-09-27 16:08:57'),
	(10, 1, 1, 110, 3, 'Balkon Suyu Sızıntısı', 'Daire 1 balkon drenaj kontrolü.', 1, 1, '2026-10-08 19:47:36', '2026-10-05 18:00:00', NULL, '2026-10-08 19:47:36');

-- tablo yapısı dökülüyor appapartman.is_emri_guncelleme
CREATE TABLE IF NOT EXISTS `is_emri_guncelleme` (
  `guncelleme_no` bigint NOT NULL AUTO_INCREMENT,
  `is_no` bigint NOT NULL,
  `yazan_no` int NOT NULL,
  `durum_no` int NOT NULL,
  `notlar` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guncelleme_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`guncelleme_no`),
  KEY `is_no` (`is_no`),
  KEY `yazan_no` (`yazan_no`),
  KEY `durum_no` (`durum_no`),
  CONSTRAINT `is_emri_guncelleme_ibfk_1` FOREIGN KEY (`is_no`) REFERENCES `is_emri` (`is_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `is_emri_guncelleme_ibfk_2` FOREIGN KEY (`yazan_no`) REFERENCES `kullanici` (`kullanici_no`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `is_emri_guncelleme_ibfk_3` FOREIGN KEY (`durum_no`) REFERENCES `is_durum` (`durum_no`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.is_emri_guncelleme: ~0 rows (yaklaşık) tablosu için veriler indiriliyor

-- tablo yapısı dökülüyor appapartman.is_emri_malzeme
CREATE TABLE IF NOT EXISTS `is_emri_malzeme` (
  `malzeme_no` int NOT NULL AUTO_INCREMENT,
  `is_no` bigint NOT NULL,
  `ad` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `adet` decimal(10,2) NOT NULL DEFAULT '1.00',
  `birim` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `birim_fiyat` decimal(12,2) DEFAULT NULL,
  `toplam` decimal(12,2) GENERATED ALWAYS AS ((`adet` * ifnull(`birim_fiyat`,0))) STORED,
  PRIMARY KEY (`malzeme_no`),
  KEY `is_no` (`is_no`),
  CONSTRAINT `is_emri_malzeme_ibfk_1` FOREIGN KEY (`is_no`) REFERENCES `is_emri` (`is_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.is_emri_malzeme: ~0 rows (yaklaşık) tablosu için veriler indiriliyor

-- tablo yapısı dökülüyor appapartman.is_oncelik
CREATE TABLE IF NOT EXISTS `is_oncelik` (
  `oncelik_no` int NOT NULL AUTO_INCREMENT,
  `ad` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `siralama` tinyint NOT NULL,
  PRIMARY KEY (`oncelik_no`),
  UNIQUE KEY `ad` (`ad`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.is_oncelik: ~4 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `is_oncelik` (`oncelik_no`, `ad`, `siralama`) VALUES
	(1, 'ACIL', 1),
	(2, 'YUKSEK', 2),
	(3, 'ORTA', 3),
	(4, 'DUSUK', 4);

-- tablo yapısı dökülüyor appapartman.kargo_kaydi
CREATE TABLE IF NOT EXISTS `kargo_kaydi` (
  `kargo_no` bigint NOT NULL AUTO_INCREMENT,
  `site_no` int NOT NULL,
  `daire_no` int NOT NULL,
  `kargo_firmasi` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `takip_no` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gelis_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `teslim_tarihi` datetime DEFAULT NULL,
  `teslim_alan_kullanici_no` int DEFAULT NULL,
  `durum` enum('BEKLIYOR','TESLIM_EDILDI','IADE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'BEKLIYOR',
  PRIMARY KEY (`kargo_no`),
  KEY `daire_no` (`daire_no`),
  KEY `teslim_alan_kullanici_no` (`teslim_alan_kullanici_no`),
  KEY `idx_kk_site_durum` (`site_no`,`durum`),
  CONSTRAINT `kargo_kaydi_ibfk_1` FOREIGN KEY (`site_no`) REFERENCES `site` (`site_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `kargo_kaydi_ibfk_2` FOREIGN KEY (`daire_no`) REFERENCES `daire` (`daire_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `kargo_kaydi_ibfk_3` FOREIGN KEY (`teslim_alan_kullanici_no`) REFERENCES `kullanici` (`kullanici_no`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.kargo_kaydi: ~2 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `kargo_kaydi` (`kargo_no`, `site_no`, `daire_no`, `kargo_firmasi`, `takip_no`, `gelis_tarihi`, `teslim_tarihi`, `teslim_alan_kullanici_no`, `durum`) VALUES
	(1, 1, 1, 'Yurtici Kargo', 'YK-2026-99001', '2026-09-27 16:08:57', NULL, NULL, 'BEKLIYOR'),
	(2, 1, 3, 'Aras Kargo', 'AR-2026-55002', '2026-09-27 16:08:57', NULL, NULL, 'TESLIM_EDILDI');

-- tablo yapısı dökülüyor appapartman.kullanici
CREATE TABLE IF NOT EXISTS `kullanici` (
  `kullanici_no` int NOT NULL AUTO_INCREMENT,
  `firma_no` int DEFAULT NULL,
  `ad` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `soyad` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tc_kimlik_sifreli` varbinary(128) DEFAULT NULL,
  `tc_kimlik_hash` char(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefon_sifreli` varbinary(128) DEFAULT NULL,
  `e_posta` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sifre_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sifre_degistirme_tarihi` datetime DEFAULT NULL,
  `sifre_hatirlatma_zorunlu` tinyint(1) NOT NULL DEFAULT '0',
  `mfa_aktif_mi` tinyint(1) NOT NULL DEFAULT '0',
  `mfa_secret_sifreli` varbinary(255) DEFAULT NULL,
  `son_giris_tarihi` datetime DEFAULT NULL,
  `basarisiz_giris_sayisi` tinyint NOT NULL DEFAULT '0',
  `hesap_kilitli_mi` tinyint(1) NOT NULL DEFAULT '0',
  `kilit_acilma_tarihi` datetime DEFAULT NULL,
  `aktif_mi` tinyint(1) NOT NULL DEFAULT '1',
  `olusturma_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `guncellenme_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`kullanici_no`),
  UNIQUE KEY `e_posta` (`e_posta`),
  UNIQUE KEY `tc_kimlik_sifreli` (`tc_kimlik_sifreli`),
  UNIQUE KEY `tc_kimlik_hash` (`tc_kimlik_hash`),
  KEY `idx_kullanici_aktif` (`aktif_mi`),
  KEY `idx_kullanici_firma` (`firma_no`),
  CONSTRAINT `kullanici_ibfk_1` FOREIGN KEY (`firma_no`) REFERENCES `yonetim_firmasi` (`firma_no`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=123 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.kullanici: ~18 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `kullanici` (`kullanici_no`, `firma_no`, `ad`, `soyad`, `tc_kimlik_sifreli`, `tc_kimlik_hash`, `telefon_sifreli`, `e_posta`, `sifre_hash`, `sifre_degistirme_tarihi`, `sifre_hatirlatma_zorunlu`, `mfa_aktif_mi`, `mfa_secret_sifreli`, `son_giris_tarihi`, `basarisiz_giris_sayisi`, `hesap_kilitli_mi`, `kilit_acilma_tarihi`, `aktif_mi`, `olusturma_tarihi`, `guncellenme_tarihi`) VALUES
	(1, 1, 'Ahmet', 'Yilmaz', NULL, NULL, NULL, 'ahmet@ornekyonetim.com', '$argon2id$v=19$m=65536,t=3,p=4$ornekhash1', NULL, 0, 1, NULL, NULL, 0, 0, NULL, 1, '2026-09-27 16:08:57', '2026-09-27 16:08:57'),
	(2, 1, 'Zeynep', 'Kaya', NULL, NULL, NULL, 'zeynep@ornekyonetim.com', '$argon2id$v=19$m=65536,t=3,p=4$ornekhash2', NULL, 0, 0, NULL, NULL, 0, 0, NULL, 1, '2026-09-27 16:08:57', '2026-09-27 16:08:57'),
	(3, 1, 'Mehmet', 'Demir', NULL, NULL, NULL, 'mehmet@ornekyonetim.com', '$argon2id$v=19$m=65536,t=3,p=4$ornekhash3', NULL, 0, 0, NULL, NULL, 0, 0, NULL, 1, '2026-09-27 16:08:57', '2026-09-27 16:08:57'),
	(4, NULL, 'Ayse', 'Sahin', NULL, NULL, NULL, 'ayse.sahin@mail.com', '$argon2id$v=19$m=65536,t=3,p=4$ornekhash4', NULL, 0, 0, NULL, NULL, 0, 0, NULL, 1, '2026-09-27 16:08:57', '2026-09-27 16:08:57'),
	(5, NULL, 'Fatma', 'Celik', NULL, NULL, NULL, 'fatma.celik@mail.com', '$argon2id$v=19$m=65536,t=3,p=4$ornekhash5', NULL, 0, 0, NULL, NULL, 0, 0, NULL, 1, '2026-09-27 16:08:57', '2026-09-27 16:08:57'),
	(6, NULL, 'Mustafa', 'Toprak', NULL, NULL, NULL, 'mustafa.toprak@mail.com', '$argon2id$v=19$m=65536,t=3,p=4$ornekhash6', NULL, 0, 0, NULL, NULL, 0, 0, NULL, 1, '2026-09-27 16:08:57', '2026-09-27 16:08:57'),
	(7, NULL, 'Test', 'Kullanici', NULL, NULL, _binary 0x19e1c768810255be63f407dfa74df95b41794efc10d3d6d3564f0c7bc6cd68ca40ce535748ee46, 'test.user@example.com', '$argon2id$v=19$m=65536,t=3,p=4$eRBXMR/pGL1V7BxGVa5NPg$6giBJTfeRBUC+cSf/HOaGXAN/9lTpddJx5QwCvReTSM', NULL, 0, 0, NULL, '2026-09-27 15:23:38', 0, 0, NULL, 1, '2026-09-27 18:23:37', '2026-09-27 18:23:37'),
	(8, NULL, 'Ahmet', 'Test', NULL, NULL, NULL, 'ahmet.test@example.com', '$argon2id$v=19$m=65536,t=3,p=4$IPtZyGNaxFqh4B+ZfAU7BA$zdcyCWGlhfho9ChrBoccx+VsIy+5Ygiej94HC6VaIp0', NULL, 0, 0, NULL, '2026-09-27 15:46:28', 0, 0, NULL, 1, '2026-09-27 18:42:17', '2026-09-27 18:46:27'),
	(9, NULL, 'Test2', 'User2', NULL, NULL, NULL, 'test2@example.com', '$argon2id$v=19$m=65536,t=3,p=4$heC2wnzamvtmieF4iD0yrQ$s01luuNwjdcVXkmA/uKxSVMNd0OJ7B5DRz5HqI6ESH8', NULL, 0, 0, NULL, NULL, 0, 0, NULL, 1, '2026-09-27 18:47:20', '2026-09-27 18:47:20'),
	(10, NULL, 'Yeni', 'Kullanici', NULL, NULL, NULL, 'yeni.kullanici@example.com', '$argon2id$v=19$m=65536,t=3,p=4$k6U6w61CzrUx2wZKb5pRMA$H50W1gcU4cDeUP7ar8pDqB3GY6uXmf/PUf/VGe8wb6c', NULL, 0, 0, NULL, NULL, 0, 0, NULL, 1, '2026-09-27 18:47:49', '2026-09-27 18:47:49'),
	(11, 1, 'Test', 'Kullanici', NULL, NULL, NULL, 'test.kullanici@example.com', '$argon2id$v=19$m=65536,t=3,p=4$icoihXb+N7i6BIbbYCBe9A$F+65R+HqhsMFlo+T6F2p7OGAtGvTH5O1GERIbVmydJE', NULL, 0, 0, NULL, '2026-09-29 18:58:49', 1, 0, NULL, 1, '2026-09-27 18:49:29', '2026-09-29 22:40:17'),
	(12, NULL, 'AuditTest', 'Kullanici', NULL, NULL, NULL, 'audit.test2@example.com', '$argon2id$v=19$m=65536,t=3,p=4$qJOL2XPg9ghXoFbmc0bDPA$OBElNQ3Bjb7IWRTR1rHr3Wyq8KMvX+E+Q1ZdzB+ZwKI', NULL, 0, 0, NULL, NULL, 0, 0, NULL, 1, '2026-09-27 19:52:12', '2026-09-27 19:52:12'),
	(13, NULL, 'TestAudit', 'Kullanici', NULL, NULL, NULL, 'test.audit.final@example.com', '$argon2id$v=19$m=65536,t=3,p=4$555/WLoLzxz/gWafZ88OHA$AZ6rwMpI/fTMk0GCqb7e6SS7SfSwnzTi0HOigslyN9g', NULL, 0, 0, NULL, NULL, 0, 0, NULL, 1, '2026-09-27 19:56:23', '2026-09-27 19:56:23'),
	(14, NULL, 'YeniAudit', 'Test', NULL, NULL, NULL, 'yeni.audit@example.com', '$argon2id$v=19$m=65536,t=3,p=4$Sj/h7HnVBFMkRlUYlAwQyg$d+4nPatlxgw0lWxI48ADuk3xGoXsqXqwRWFJzBS5nSQ', NULL, 0, 0, NULL, NULL, 0, 0, NULL, 1, '2026-09-27 20:29:08', '2026-09-27 20:29:08'),
	(15, NULL, 'TestFinal', 'Audit', NULL, NULL, NULL, 'final.audit2@example.com', '$argon2id$v=19$m=65536,t=3,p=4$fsMLYKUM0cXyKGndxywBvA$WE6c2zDD/NfCe1cu8evrL21gY2akRJNKo67tyowWQvA', NULL, 0, 0, NULL, NULL, 0, 0, NULL, 1, '2026-09-27 20:46:11', '2026-09-27 20:46:11'),
	(110, NULL, 'Ali', 'Yilmaz', NULL, NULL, _binary 0x4b1a449a53472e81bdc1d9ec280e0d7b2e48bb14ad15dd1f1e03768b493b79d44358f15775366f, 'ali.yilmaz@mail.com', '$argon2id$v=19$m=65536,t=3,p=4$9T7fe1mpjizz8Q0POyrx9A$akb0cDTamuZ00h28aYWNZt/ZsCBdH+ud54jz91e8J1E', NULL, 0, 0, NULL, '2026-10-08 19:54:23', 0, 0, NULL, 1, '2026-09-30 00:02:47', '2026-10-08 22:54:23'),
	(117, NULL, 'Rate', 'Limit', NULL, NULL, NULL, 'pytest.auth@example.com', '$argon2id$v=19$m=65536,t=3,p=4$Cr1CuY3VxWxFU8e5ye+7/Q$uGNZDZL7g1ecA7idAHpSKuAei0oo6sBM/YzfgRVz/+s', NULL, 0, 0, NULL, NULL, 5, 1, '2026-09-29 21:23:09', 1, '2026-09-30 00:08:07', '2026-09-30 00:08:08'),
	(118, NULL, 'Neta', 'NEtam', NULL, NULL, _binary 0x68bd53de3cdb4e9c06c9ce738ec24e46406bcdb71ee58242a5830da9cd10952445f4829f77f363, 'netaerk@mail.com', '$argon2id$v=19$m=65536,t=3,p=4$Z+AvY8XbJFn1AR/+Hkh8zg$PZNIqzkNMqqs4EFcACdIbcm1GyQZI+55s8T3hBslPq0', NULL, 0, 0, NULL, '2026-09-30 18:49:49', 0, 0, NULL, 1, '2026-09-30 21:48:44', '2026-09-30 21:49:48');

-- tablo yapısı dökülüyor appapartman.kullanici_mfa_yedek_kod
CREATE TABLE IF NOT EXISTS `kullanici_mfa_yedek_kod` (
  `kod_no` int NOT NULL AUTO_INCREMENT,
  `kullanici_no` int NOT NULL,
  `kod_hash` char(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kullanildi_mi` tinyint(1) NOT NULL DEFAULT '0',
  `kullanilma_tarihi` datetime DEFAULT NULL,
  PRIMARY KEY (`kod_no`),
  KEY `idx_mfa_kullanici_kullanildi` (`kullanici_no`,`kullanildi_mi`),
  CONSTRAINT `kullanici_mfa_yedek_kod_ibfk_1` FOREIGN KEY (`kullanici_no`) REFERENCES `kullanici` (`kullanici_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.kullanici_mfa_yedek_kod: ~0 rows (yaklaşık) tablosu için veriler indiriliyor

-- tablo yapısı dökülüyor appapartman.kullanici_site
CREATE TABLE IF NOT EXISTS `kullanici_site` (
  `kayit_no` int NOT NULL AUTO_INCREMENT,
  `kullanici_no` int NOT NULL,
  `site_no` int NOT NULL,
  `rol_no` int NOT NULL,
  `baslangic_tarihi` date NOT NULL,
  `bitis_tarihi` date DEFAULT NULL,
  `aktif_mi` tinyint(1) NOT NULL DEFAULT '1',
  `olusturma_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `guncellenme_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`kayit_no`),
  UNIQUE KEY `kullanici_no` (`kullanici_no`,`site_no`),
  KEY `rol_no` (`rol_no`),
  KEY `idx_ks_site_aktif` (`site_no`,`aktif_mi`),
  KEY `idx_ks_kullanici_aktif` (`kullanici_no`,`aktif_mi`),
  CONSTRAINT `kullanici_site_ibfk_1` FOREIGN KEY (`kullanici_no`) REFERENCES `kullanici` (`kullanici_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `kullanici_site_ibfk_2` FOREIGN KEY (`site_no`) REFERENCES `site` (`site_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `kullanici_site_ibfk_3` FOREIGN KEY (`rol_no`) REFERENCES `rol` (`rol_no`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.kullanici_site: ~11 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `kullanici_site` (`kayit_no`, `kullanici_no`, `site_no`, `rol_no`, `baslangic_tarihi`, `bitis_tarihi`, `aktif_mi`, `olusturma_tarihi`, `guncellenme_tarihi`) VALUES
	(1, 1, 1, 1, '2025-01-01', NULL, 1, '2026-09-27 16:08:57', '2026-09-27 16:08:57'),
	(2, 1, 2, 1, '2025-01-01', NULL, 1, '2026-09-27 16:08:57', '2026-09-27 16:08:57'),
	(3, 2, 1, 2, '2025-01-01', NULL, 1, '2026-09-27 16:08:57', '2026-09-27 16:08:57'),
	(4, 2, 2, 2, '2025-06-01', NULL, 1, '2026-09-27 16:08:57', '2026-09-27 16:08:57'),
	(5, 3, 1, 4, '2025-01-01', NULL, 1, '2026-09-27 16:08:57', '2026-09-27 16:08:57'),
	(6, 3, 2, 4, '2025-06-01', NULL, 1, '2026-09-27 16:08:57', '2026-09-27 16:08:57'),
	(7, 4, 1, 3, '2025-02-01', NULL, 1, '2026-09-27 16:08:57', '2026-09-27 16:08:57'),
	(8, 5, 1, 3, '2025-03-01', NULL, 1, '2026-09-27 16:08:57', '2026-09-27 16:08:57'),
	(9, 6, 2, 3, '2025-02-01', NULL, 1, '2026-09-27 16:08:57', '2026-09-27 16:08:57'),
	(12, 11, 1, 1, '2026-09-27', NULL, 1, '2026-09-27 21:47:37', '2026-09-27 21:47:37'),
	(13, 11, 2, 1, '2026-09-27', NULL, 1, '2026-09-27 21:47:37', '2026-09-27 21:47:37'),
	(14, 110, 1, 3, '2026-09-29', NULL, 1, '2026-09-28 21:18:21', '2026-10-08 22:42:55');

-- tablo yapısı dökülüyor appapartman.kvkk_metin
CREATE TABLE IF NOT EXISTS `kvkk_metin` (
  `metin_no` int NOT NULL AUTO_INCREMENT,
  `baslik` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icerik` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `versiyon` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `yayin_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `aktif_mi` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`metin_no`),
  UNIQUE KEY `baslik` (`baslik`,`versiyon`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.kvkk_metin: ~0 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `kvkk_metin` (`metin_no`, `baslik`, `icerik`, `versiyon`, `yayin_tarihi`, `aktif_mi`) VALUES
	(1, 'KVKK Aydinlatma Metni', 'Bu metin KVKK kapsaminda kisisel verilerin islenmesine iliskin aydinlatma metnidir...', '1.0', '2026-09-27 16:08:57', 1);

-- tablo yapısı dökülüyor appapartman.kvkk_onay
CREATE TABLE IF NOT EXISTS `kvkk_onay` (
  `onay_no` int NOT NULL AUTO_INCREMENT,
  `kullanici_no` int NOT NULL,
  `metin_no` int NOT NULL,
  `onay_tipi` enum('AYDINLATMA','ACIK_RIZA','PAZARLAMA','CEREZ') COLLATE utf8mb4_unicode_ci NOT NULL,
  `onaylandi_mi` tinyint(1) NOT NULL DEFAULT '1',
  `onay_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ip_adresi` varbinary(16) DEFAULT NULL,
  PRIMARY KEY (`onay_no`),
  UNIQUE KEY `kullanici_no` (`kullanici_no`,`metin_no`,`onay_tipi`),
  KEY `metin_no` (`metin_no`),
  CONSTRAINT `kvkk_onay_ibfk_1` FOREIGN KEY (`kullanici_no`) REFERENCES `kullanici` (`kullanici_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `kvkk_onay_ibfk_2` FOREIGN KEY (`metin_no`) REFERENCES `kvkk_metin` (`metin_no`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.kvkk_onay: ~17 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `kvkk_onay` (`onay_no`, `kullanici_no`, `metin_no`, `onay_tipi`, `onaylandi_mi`, `onay_tarihi`, `ip_adresi`) VALUES
	(1, 1, 1, 'AYDINLATMA', 1, '2026-09-27 16:08:57', NULL),
	(2, 2, 1, 'AYDINLATMA', 1, '2026-09-27 16:08:57', NULL),
	(3, 4, 1, 'AYDINLATMA', 1, '2026-09-27 16:08:57', NULL),
	(4, 5, 1, 'AYDINLATMA', 1, '2026-09-27 16:08:57', NULL),
	(5, 6, 1, 'AYDINLATMA', 1, '2026-09-27 16:08:57', NULL),
	(6, 7, 1, 'AYDINLATMA', 1, '2026-09-27 15:23:37', _binary 0x7f000001),
	(7, 8, 1, 'AYDINLATMA', 1, '2026-09-27 15:42:17', _binary 0x7f000001),
	(8, 9, 1, 'AYDINLATMA', 1, '2026-09-27 15:47:20', _binary 0x7f000001),
	(9, 10, 1, 'AYDINLATMA', 1, '2026-09-27 15:47:49', _binary 0x7f000001),
	(10, 11, 1, 'AYDINLATMA', 1, '2026-09-27 15:49:30', _binary 0x7f000001),
	(11, 12, 1, 'AYDINLATMA', 1, '2026-09-27 16:52:13', _binary 0x7f000001),
	(12, 13, 1, 'AYDINLATMA', 1, '2026-09-27 16:56:24', _binary 0x7f000001),
	(13, 14, 1, 'AYDINLATMA', 1, '2026-09-27 17:29:09', _binary 0x7f000001),
	(14, 15, 1, 'AYDINLATMA', 1, '2026-09-27 17:46:12', _binary 0x7f000001),
	(101, 110, 1, 'AYDINLATMA', 1, '2026-09-29 21:02:47', _binary 0x7f000001),
	(108, 117, 1, 'AYDINLATMA', 1, '2026-09-29 21:08:08', _binary 0x7f000001),
	(109, 118, 1, 'AYDINLATMA', 1, '2026-09-30 18:48:45', _binary 0x7f000001);

-- tablo yapısı dökülüyor appapartman.login_denemesi
CREATE TABLE IF NOT EXISTS `login_denemesi` (
  `deneme_no` bigint NOT NULL AUTO_INCREMENT,
  `e_posta` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kullanici_no` int DEFAULT NULL,
  `ip_adresi` varbinary(16) NOT NULL,
  `user_agent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `basarili_mi` tinyint(1) NOT NULL,
  `hata_mesaji` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deneme_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`deneme_no`),
  KEY `kullanici_no` (`kullanici_no`),
  KEY `idx_ld_email_tarih` (`e_posta`,`deneme_tarihi`),
  KEY `idx_ld_ip_tarih` (`ip_adresi`,`deneme_tarihi`),
  CONSTRAINT `login_denemesi_ibfk_1` FOREIGN KEY (`kullanici_no`) REFERENCES `kullanici` (`kullanici_no`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=320 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.login_denemesi: ~266 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `login_denemesi` (`deneme_no`, `e_posta`, `kullanici_no`, `ip_adresi`, `user_agent`, `basarili_mi`, `hata_mesaji`, `deneme_tarihi`) VALUES
	(1, 'test.user@example.com', 7, _binary 0x7f000001, NULL, 1, 'KAYIT', '2026-09-27 15:23:37'),
	(2, 'test.user@example.com', 7, _binary 0x7f000001, NULL, 1, NULL, '2026-09-27 15:23:38'),
	(3, 'ahmet.test@example.com', 8, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 1, 'KAYIT', '2026-09-27 15:42:17'),
	(4, 'ahmet.test@example.com', 8, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 1, NULL, '2026-09-27 15:43:14'),
	(5, 'ahmet.test@example.com', 8, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 1, NULL, '2026-09-27 15:46:28'),
	(6, 'test2@example.com', 9, _binary 0x7f000001, 'curl/8.21.0', 1, 'KAYIT', '2026-09-27 15:47:20'),
	(7, 'yeni.kullanici@example.com', 10, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 1, 'KAYIT', '2026-09-27 15:47:49'),
	(8, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, 'KAYIT', '2026-09-27 15:49:30'),
	(9, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-27 15:50:14'),
	(10, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-27 15:50:53'),
	(11, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 0, 'PAROLA_YANLIS', '2026-09-27 15:50:55'),
	(12, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 0, 'PAROLA_YANLIS', '2026-09-27 15:51:45'),
	(13, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-27 15:52:25'),
	(14, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 0, 'PAROLA_YANLIS', '2026-09-27 15:52:28'),
	(15, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-27 15:52:45'),
	(16, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 0, 'PAROLA_YANLIS', '2026-09-27 15:52:46'),
	(17, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-27 16:12:37'),
	(18, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-27 16:12:51'),
	(19, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 0, 'PAROLA_YANLIS', '2026-09-27 16:30:38'),
	(20, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 0, 'PAROLA_YANLIS', '2026-09-27 16:30:39'),
	(21, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 0, 'PAROLA_YANLIS', '2026-09-27 16:30:39'),
	(22, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 0, 'PAROLA_YANLIS', '2026-09-27 16:30:41'),
	(23, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 0, 'KILITLENDI', '2026-09-27 16:30:41'),
	(24, 'audit.test2@example.com', 12, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, 'KAYIT', '2026-09-27 16:52:13'),
	(25, 'test.audit.final@example.com', 13, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, 'KAYIT', '2026-09-27 16:56:24'),
	(26, 'yeni.audit@example.com', 14, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, 'KAYIT', '2026-09-27 17:29:09'),
	(27, 'final.audit2@example.com', 15, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, 'KAYIT', '2026-09-27 17:46:12'),
	(38, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-27 18:49:52'),
	(39, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-27 18:51:48'),
	(40, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-27 18:52:32'),
	(41, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-27 18:56:38'),
	(42, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-27 18:56:52'),
	(43, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-27 19:40:33'),
	(44, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-27 20:22:07'),
	(45, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-27 20:23:50'),
	(46, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-27 20:27:48'),
	(47, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-27 20:30:31'),
	(48, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-27 20:34:08'),
	(49, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-27 20:58:08'),
	(50, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-27 20:59:17'),
	(51, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-27 21:02:03'),
	(52, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-27 21:03:28'),
	(53, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-27 21:03:57'),
	(54, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-27 21:06:15'),
	(55, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-27 21:06:29'),
	(56, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-27 21:14:22'),
	(57, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-28 20:23:47'),
	(58, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-28 20:25:04'),
	(59, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-28 20:26:19'),
	(60, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-28 20:40:06'),
	(61, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-28 20:41:14'),
	(62, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-28 20:50:14'),
	(63, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-28 20:56:55'),
	(64, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-28 20:57:56'),
	(65, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-28 21:12:49'),
	(66, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-28 21:12:56'),
	(67, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-28 21:14:20'),
	(68, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-28 21:15:49'),
	(69, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-28 21:18:20'),
	(70, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-28 21:24:23'),
	(71, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-28 21:43:30'),
	(72, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-28 21:44:37'),
	(73, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-28 21:48:13'),
	(74, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-28 21:58:10'),
	(75, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-28 21:59:11'),
	(76, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-28 22:14:51'),
	(77, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', 1, NULL, '2026-09-29 18:58:49'),
	(78, 'test.kullanici@example.com', 11, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 19:40:18'),
	(79, 'ali.yilmaz@mail.com', NULL, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 0, 'KULLANICI_YOK', '2026-09-29 19:49:08'),
	(80, 'ali.yilmaz@mail.com', NULL, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 0, 'KULLANICI_YOK', '2026-09-29 19:50:08'),
	(81, 'ali.yilmaz@mail.com', NULL, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 0, 'KULLANICI_YOK', '2026-09-29 19:55:40'),
	(82, 'ali.yilmaz@mail.com', NULL, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 0, 'KULLANICI_YOK', '2026-09-29 19:56:04'),
	(83, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:15:51'),
	(84, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:15:52'),
	(85, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:15:52'),
	(86, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, NULL, '2026-09-29 20:15:53'),
	(87, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:15:53'),
	(88, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 20:15:54'),
	(89, 'olmayan@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'KULLANICI_YOK', '2026-09-29 20:15:54'),
	(90, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:15:55'),
	(91, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, NULL, '2026-09-29 20:15:55'),
	(92, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:15:56'),
	(93, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, NULL, '2026-09-29 20:15:56'),
	(94, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:15:57'),
	(95, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 20:15:57'),
	(96, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 20:15:57'),
	(97, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 20:15:58'),
	(98, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 20:15:58'),
	(99, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'KILITLENDI', '2026-09-29 20:15:58'),
	(100, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'HESAP_KILITLI', '2026-09-29 20:15:58'),
	(101, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:16:31'),
	(102, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:16:32'),
	(103, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:16:33'),
	(104, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, NULL, '2026-09-29 20:16:34'),
	(105, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:16:35'),
	(106, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 20:16:36'),
	(107, 'olmayan@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'KULLANICI_YOK', '2026-09-29 20:16:36'),
	(108, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:16:37'),
	(109, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, NULL, '2026-09-29 20:16:38'),
	(110, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:16:39'),
	(111, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, NULL, '2026-09-29 20:16:39'),
	(112, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:16:39'),
	(113, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 20:16:39'),
	(114, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 20:16:40'),
	(115, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 20:16:40'),
	(116, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 20:16:40'),
	(117, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'KILITLENDI', '2026-09-29 20:16:40'),
	(118, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'HESAP_KILITLI', '2026-09-29 20:16:41'),
	(119, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:18:13'),
	(120, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:18:14'),
	(121, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:18:14'),
	(122, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, NULL, '2026-09-29 20:18:14'),
	(123, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:18:15'),
	(124, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 20:18:15'),
	(125, 'olmayan@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'KULLANICI_YOK', '2026-09-29 20:18:15'),
	(126, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:18:16'),
	(127, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, NULL, '2026-09-29 20:18:16'),
	(128, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:18:17'),
	(129, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, NULL, '2026-09-29 20:18:17'),
	(130, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:18:18'),
	(131, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 20:18:18'),
	(132, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 20:18:18'),
	(133, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 20:18:18'),
	(134, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 20:18:18'),
	(135, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'KILITLENDI', '2026-09-29 20:18:18'),
	(136, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'HESAP_KILITLI', '2026-09-29 20:18:18'),
	(137, 'ali.yilmaz@mail.com', NULL, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 0, 'KULLANICI_YOK', '2026-09-29 20:18:51'),
	(138, 'ali.yilmaz@mail.com', NULL, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 0, 'KULLANICI_YOK', '2026-09-29 20:19:57'),
	(139, 'ali.yilmaz@mail.com', NULL, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 0, 'KULLANICI_YOK', '2026-09-29 20:20:27'),
	(140, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:21:38'),
	(141, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:21:38'),
	(142, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:21:39'),
	(143, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, NULL, '2026-09-29 20:21:39'),
	(144, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:21:40'),
	(145, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 20:21:40'),
	(146, 'olmayan@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'KULLANICI_YOK', '2026-09-29 20:21:40'),
	(147, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:21:40'),
	(148, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, NULL, '2026-09-29 20:21:40'),
	(149, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:21:41'),
	(150, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, NULL, '2026-09-29 20:21:41'),
	(151, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:21:41'),
	(152, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 20:21:41'),
	(153, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 20:21:42'),
	(154, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 20:21:42'),
	(155, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 20:21:42'),
	(156, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'KILITLENDI', '2026-09-29 20:21:42'),
	(157, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'HESAP_KILITLI', '2026-09-29 20:21:42'),
	(158, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:28:08'),
	(159, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:28:11'),
	(160, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:28:12'),
	(161, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, NULL, '2026-09-29 20:28:13'),
	(162, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:28:14'),
	(163, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 20:28:14'),
	(164, 'olmayan@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'KULLANICI_YOK', '2026-09-29 20:28:15'),
	(165, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:28:17'),
	(166, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, NULL, '2026-09-29 20:28:18'),
	(167, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:28:19'),
	(168, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, NULL, '2026-09-29 20:28:19'),
	(169, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:28:20'),
	(170, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 20:28:21'),
	(171, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 20:28:21'),
	(172, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 20:28:22'),
	(173, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 20:28:22'),
	(174, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'KILITLENDI', '2026-09-29 20:28:23'),
	(175, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'HESAP_KILITLI', '2026-09-29 20:28:23'),
	(176, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:28:44'),
	(177, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:28:45'),
	(178, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:28:45'),
	(179, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, NULL, '2026-09-29 20:28:45'),
	(180, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:28:46'),
	(181, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 20:28:46'),
	(182, 'olmayan@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'KULLANICI_YOK', '2026-09-29 20:28:46'),
	(183, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:28:47'),
	(184, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, NULL, '2026-09-29 20:28:48'),
	(185, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:28:49'),
	(186, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, NULL, '2026-09-29 20:28:49'),
	(187, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:28:50'),
	(188, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 20:28:50'),
	(189, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 20:28:50'),
	(190, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 20:28:51'),
	(191, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 20:28:51'),
	(192, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'KILITLENDI', '2026-09-29 20:28:52'),
	(193, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'HESAP_KILITLI', '2026-09-29 20:28:52'),
	(194, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:34:38'),
	(195, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:34:39'),
	(196, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:34:39'),
	(197, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, NULL, '2026-09-29 20:34:40'),
	(198, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:34:40'),
	(199, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 20:34:40'),
	(200, 'olmayan@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'KULLANICI_YOK', '2026-09-29 20:34:40'),
	(201, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:34:40'),
	(202, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, NULL, '2026-09-29 20:34:41'),
	(203, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:34:41'),
	(204, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, NULL, '2026-09-29 20:34:41'),
	(205, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:34:41'),
	(206, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 20:34:42'),
	(207, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 20:34:42'),
	(208, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 20:34:42'),
	(209, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 20:34:42'),
	(210, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'KILITLENDI', '2026-09-29 20:34:42'),
	(211, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'HESAP_KILITLI', '2026-09-29 20:34:42'),
	(212, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:44:30'),
	(213, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:44:31'),
	(214, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:44:32'),
	(215, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, NULL, '2026-09-29 20:44:32'),
	(216, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:44:34'),
	(217, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 20:44:34'),
	(218, 'olmayan@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'KULLANICI_YOK', '2026-09-29 20:44:34'),
	(219, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:44:35'),
	(220, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, NULL, '2026-09-29 20:44:35'),
	(221, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:44:36'),
	(222, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, NULL, '2026-09-29 20:44:36'),
	(223, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:45:01'),
	(224, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:45:02'),
	(225, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:45:03'),
	(226, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, NULL, '2026-09-29 20:45:03'),
	(227, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:45:04'),
	(228, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 20:45:04'),
	(229, 'olmayan@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'KULLANICI_YOK', '2026-09-29 20:45:04'),
	(230, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:45:04'),
	(231, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, NULL, '2026-09-29 20:45:05'),
	(232, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 20:45:05'),
	(233, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, NULL, '2026-09-29 20:45:05'),
	(245, 'ali.yilmaz@mail.com', NULL, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 0, 'KULLANICI_YOK', '2026-09-29 20:47:30'),
	(257, 'olmayan@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'KULLANICI_YOK', '2026-09-29 21:01:01'),
	(258, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 21:01:46'),
	(259, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 21:01:47'),
	(260, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 21:01:48'),
	(261, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, NULL, '2026-09-29 21:01:49'),
	(262, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 21:01:50'),
	(263, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 21:01:50'),
	(264, 'olmayan@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'KULLANICI_YOK', '2026-09-29 21:01:50'),
	(265, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 21:01:51'),
	(266, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, NULL, '2026-09-29 21:01:52'),
	(267, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 21:01:53'),
	(268, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, NULL, '2026-09-29 21:01:53'),
	(269, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 21:01:55'),
	(270, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 21:01:56'),
	(271, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 21:01:56'),
	(272, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 21:01:56'),
	(273, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 21:01:56'),
	(274, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'KILITLENDI', '2026-09-29 21:01:57'),
	(275, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'HESAP_KILITLI', '2026-09-29 21:01:57'),
	(276, 'ali.yilmaz@mail.com', NULL, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 0, 'KULLANICI_YOK', '2026-09-29 21:02:02'),
	(277, 'ali.yilmaz@mail.com', NULL, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 1, 'KAYIT', '2026-09-29 21:02:23'),
	(278, 'ali.yilmaz11@mail.com', 110, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 1, 'KAYIT', '2026-09-29 21:02:47'),
	(279, 'ali.yilmaz11@mail.com', 110, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 1, NULL, '2026-09-29 21:03:33'),
	(280, 'ali.yilmaz11@mail.com', 110, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 1, NULL, '2026-09-29 21:04:23'),
	(281, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 21:08:03'),
	(282, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 21:08:05'),
	(283, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 21:08:05'),
	(284, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, NULL, '2026-09-29 21:08:06'),
	(285, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 21:08:06'),
	(286, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 21:08:06'),
	(287, 'olmayan@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'KULLANICI_YOK', '2026-09-29 21:08:06'),
	(288, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 21:08:07'),
	(289, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, NULL, '2026-09-29 21:08:07'),
	(290, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 21:08:07'),
	(291, 'pytest.auth@example.com', NULL, _binary 0x7f000001, 'python-httpx/0.28.1', 1, NULL, '2026-09-29 21:08:07'),
	(292, 'pytest.auth@example.com', 117, _binary 0x7f000001, 'python-httpx/0.28.1', 1, 'KAYIT', '2026-09-29 21:08:08'),
	(293, 'pytest.auth@example.com', 117, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 21:08:08'),
	(294, 'pytest.auth@example.com', 117, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 21:08:08'),
	(295, 'pytest.auth@example.com', 117, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 21:08:08'),
	(296, 'pytest.auth@example.com', 117, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'PAROLA_YANLIS', '2026-09-29 21:08:08'),
	(297, 'pytest.auth@example.com', 117, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'KILITLENDI', '2026-09-29 21:08:09'),
	(298, 'pytest.auth@example.com', 117, _binary 0x7f000001, 'python-httpx/0.28.1', 0, 'HESAP_KILITLI', '2026-09-29 21:08:09'),
	(299, 'ali.yilmaz11@mail.com', 110, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 1, NULL, '2026-09-29 21:08:59'),
	(300, 'ali.yilmaz11@mail.com', 110, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 1, NULL, '2026-09-29 21:13:13'),
	(301, 'ali.yilmaz@mail.com', 110, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 1, NULL, '2026-09-29 21:15:32'),
	(302, 'ali.yilmaz@mail.com', 110, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 1, NULL, '2026-09-29 21:50:57'),
	(303, 'ali.yilmaz@mail.com', 110, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 1, NULL, '2026-09-30 18:37:11'),
	(304, 'ali.yilmaz@mail.com', 110, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 1, NULL, '2026-09-30 18:39:16'),
	(305, 'netaerk@mail.com', 118, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 1, 'KAYIT', '2026-09-30 18:48:45'),
	(306, 'netaerk@mail.com', 118, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 1, NULL, '2026-09-30 18:49:49'),
	(307, 'ali.yilmaz@mail.com', 110, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 1, NULL, '2026-09-30 19:37:59'),
	(308, 'ali.yilmaz@mail.com', 110, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 1, NULL, '2026-09-30 20:10:39'),
	(309, 'ali.yilmaz@mail.com', 110, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 1, NULL, '2026-09-30 20:12:43'),
	(310, 'ali.yilmaz@mail.com', 110, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 1, NULL, '2026-09-30 20:15:16'),
	(311, 'ali.yilmaz@mail.com', 110, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 1, NULL, '2026-09-30 20:34:30'),
	(312, 'ali.yilmaz@mail.com', 110, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 1, NULL, '2026-09-30 20:39:16'),
	(313, 'ali.yilmaz@mail.com', 110, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 1, NULL, '2026-09-30 21:01:48'),
	(314, 'ali.yilmaz@mail.com', 110, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 1, NULL, '2026-09-30 21:03:28'),
	(315, 'ali.yilmaz@mail.com', 110, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 1, NULL, '2026-09-30 21:09:27'),
	(316, 'ali.yilmaz@mail.com', 110, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 1, NULL, '2026-09-30 21:14:01'),
	(317, 'ali.yilmaz@mail.com', 110, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 1, NULL, '2026-10-05 17:38:30'),
	(318, 'ali.yilmaz@mail.com', 110, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 1, NULL, '2026-10-08 19:35:07'),
	(319, 'ali.yilmaz@mail.com', 110, _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 1, NULL, '2026-10-08 19:54:23');

-- tablo yapısı dökülüyor appapartman.mesaj
CREATE TABLE IF NOT EXISTS `mesaj` (
  `mesaj_no` bigint NOT NULL AUTO_INCREMENT,
  `gonderen_no` int NOT NULL,
  `alici_no` int NOT NULL,
  `site_no` int NOT NULL,
  `parent_mesaj_no` bigint DEFAULT NULL,
  `konu` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icerik` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `gonderim_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `okundu_mu` tinyint(1) NOT NULL DEFAULT '0',
  `okunma_tarihi` datetime DEFAULT NULL,
  PRIMARY KEY (`mesaj_no`),
  KEY `gonderen_no` (`gonderen_no`),
  KEY `alici_no` (`alici_no`),
  KEY `parent_mesaj_no` (`parent_mesaj_no`),
  KEY `idx_mesaj_site_alici_okundu` (`site_no`,`alici_no`,`okundu_mu`),
  CONSTRAINT `mesaj_ibfk_1` FOREIGN KEY (`gonderen_no`) REFERENCES `kullanici` (`kullanici_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mesaj_ibfk_2` FOREIGN KEY (`alici_no`) REFERENCES `kullanici` (`kullanici_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mesaj_ibfk_3` FOREIGN KEY (`site_no`) REFERENCES `site` (`site_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mesaj_ibfk_4` FOREIGN KEY (`parent_mesaj_no`) REFERENCES `mesaj` (`mesaj_no`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.mesaj: ~3 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `mesaj` (`mesaj_no`, `gonderen_no`, `alici_no`, `site_no`, `parent_mesaj_no`, `konu`, `icerik`, `gonderim_tarihi`, `okundu_mu`, `okunma_tarihi`) VALUES
	(1, 4, 1, 1, NULL, 'Aidat Dekontu', 'Eylul aidat odeme dekontumu iletiyorum.', '2026-09-27 16:08:57', 1, NULL),
	(2, 1, 4, 1, NULL, 'Re: Aidat Dekontu', 'Odemeniz onaylanmistir, tesekkurler.', '2026-09-27 16:08:57', 1, NULL),
	(3, 6, 1, 2, NULL, 'Otopark Talebi', 'Arac kaydi icin plaka bilgilerimi iletiyorum.', '2026-09-27 16:08:57', 0, NULL);

-- tablo yapısı dökülüyor appapartman.odeme
CREATE TABLE IF NOT EXISTS `odeme` (
  `odeme_no` int NOT NULL AUTO_INCREMENT,
  `site_no` int NOT NULL,
  `odeme_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `toplam_tutar` decimal(12,2) NOT NULL,
  `odeme_kanali_no` int NOT NULL,
  `dekont_no` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `referans_no` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `onay_durum_no` int NOT NULL DEFAULT '1',
  `onaylayan_no` int DEFAULT NULL,
  `onay_tarihi` datetime DEFAULT NULL,
  `aciklama` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `olusturan_no` int NOT NULL,
  `olusturma_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `guncellenme_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`odeme_no`),
  KEY `odeme_kanali_no` (`odeme_kanali_no`),
  KEY `onaylayan_no` (`onaylayan_no`),
  KEY `olusturan_no` (`olusturan_no`),
  KEY `idx_odeme_site_tarih` (`site_no`,`odeme_tarihi`),
  KEY `idx_odeme_onay` (`onay_durum_no`,`odeme_tarihi`),
  CONSTRAINT `odeme_ibfk_1` FOREIGN KEY (`site_no`) REFERENCES `site` (`site_no`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `odeme_ibfk_2` FOREIGN KEY (`odeme_kanali_no`) REFERENCES `odeme_kanali` (`kanal_no`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `odeme_ibfk_3` FOREIGN KEY (`onay_durum_no`) REFERENCES `onay_durum` (`durum_no`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `odeme_ibfk_4` FOREIGN KEY (`onaylayan_no`) REFERENCES `kullanici` (`kullanici_no`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `odeme_ibfk_5` FOREIGN KEY (`olusturan_no`) REFERENCES `kullanici` (`kullanici_no`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.odeme: ~5 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `odeme` (`odeme_no`, `site_no`, `odeme_tarihi`, `toplam_tutar`, `odeme_kanali_no`, `dekont_no`, `referans_no`, `onay_durum_no`, `onaylayan_no`, `onay_tarihi`, `aciklama`, `olusturan_no`, `olusturma_tarihi`, `guncellenme_tarihi`) VALUES
	(1, 1, '2026-09-05 10:30:00', 1500.00, 5, NULL, 'POS-778899', 1, 2, NULL, NULL, 1, '2026-09-27 16:08:57', '2026-09-27 16:08:57'),
	(2, 1, '2026-09-08 09:15:00', 1500.00, 6, NULL, 'OTM-445566', 1, 2, NULL, NULL, 1, '2026-09-27 16:08:57', '2026-09-27 16:08:57'),
	(3, 1, '2026-08-25 14:00:00', 1500.00, 1, NULL, NULL, 1, 2, NULL, NULL, 1, '2026-09-27 16:08:57', '2026-09-27 16:08:57'),
	(4, 1, '2026-09-27 20:23:53', 1800.00, 1, 'HB-TEST-001', NULL, 3, 11, '2026-09-27 20:23:53', 'Test tahsilat - aidat 2 | IPTAL: Yanlis girilen tutar', 11, '2026-09-27 23:23:52', '2026-09-27 23:24:25'),
	(5, 1, '2026-09-27 20:34:09', 1800.00, 1, 'HB-FIX-001', NULL, 3, 11, '2026-09-27 20:34:09', ' | IPTAL: Test iptal', 11, '2026-09-27 23:34:08', '2026-09-27 23:34:09');

-- tablo yapısı dökülüyor appapartman.odeme_detay
CREATE TABLE IF NOT EXISTS `odeme_detay` (
  `detay_no` int NOT NULL AUTO_INCREMENT,
  `odeme_no` int NOT NULL,
  `aidat_no` int DEFAULT NULL,
  `gider_no` int DEFAULT NULL,
  `tutar` decimal(12,2) NOT NULL,
  `aciklama` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`detay_no`),
  KEY `idx_od_detay_odeme` (`odeme_no`),
  KEY `idx_od_detay_aidat` (`aidat_no`),
  CONSTRAINT `odeme_detay_ibfk_1` FOREIGN KEY (`odeme_no`) REFERENCES `odeme` (`odeme_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `odeme_detay_ibfk_2` FOREIGN KEY (`aidat_no`) REFERENCES `aidat` (`aidat_no`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.odeme_detay: ~3 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `odeme_detay` (`detay_no`, `odeme_no`, `aidat_no`, `gider_no`, `tutar`, `aciklama`) VALUES
	(1, 1, 1, NULL, 1500.00, NULL),
	(2, 2, 3, NULL, 1500.00, NULL),
	(3, 3, 7, NULL, 1500.00, NULL),
	(4, 5, 2, NULL, 1800.00, NULL);

-- tablo yapısı dökülüyor appapartman.odeme_kanali
CREATE TABLE IF NOT EXISTS `odeme_kanali` (
  `kanal_no` int NOT NULL AUTO_INCREMENT,
  `ad` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`kanal_no`),
  UNIQUE KEY `ad` (`ad`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.odeme_kanali: ~6 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `odeme_kanali` (`kanal_no`, `ad`) VALUES
	(2, 'EFT'),
	(1, 'HAVALE'),
	(4, 'KREDI_KARTI'),
	(3, 'NAKIT'),
	(6, 'OTOMATIK_TALEP'),
	(5, 'SANAL_POS');

-- tablo yapısı dökülüyor appapartman.onay_durum
CREATE TABLE IF NOT EXISTS `onay_durum` (
  `durum_no` int NOT NULL AUTO_INCREMENT,
  `ad` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`durum_no`),
  UNIQUE KEY `ad` (`ad`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.onay_durum: ~3 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `onay_durum` (`durum_no`, `ad`) VALUES
	(2, 'BEKLIYOR'),
	(1, 'ONAYLANDI'),
	(3, 'REDDEDILDI');

-- tablo yapısı dökülüyor appapartman.otopark_yeri
CREATE TABLE IF NOT EXISTS `otopark_yeri` (
  `yer_no` int NOT NULL AUTO_INCREMENT,
  `site_no` int NOT NULL,
  `yer_kodu` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tip` enum('KAPALI','ACIK','MISAFIR','ENGELLI') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACIK',
  PRIMARY KEY (`yer_no`),
  UNIQUE KEY `site_no` (`site_no`,`yer_kodu`),
  CONSTRAINT `otopark_yeri_ibfk_1` FOREIGN KEY (`site_no`) REFERENCES `site` (`site_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.otopark_yeri: ~6 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `otopark_yeri` (`yer_no`, `site_no`, `yer_kodu`, `tip`) VALUES
	(1, 1, 'A-01', 'KAPALI'),
	(2, 1, 'A-02', 'KAPALI'),
	(3, 1, 'M-01', 'MISAFIR'),
	(4, 1, 'E-01', 'ENGELLI'),
	(5, 2, 'P-01', 'ACIK'),
	(6, 2, 'P-02', 'ACIK');

-- tablo yapısı dökülüyor appapartman.oturum
CREATE TABLE IF NOT EXISTS `oturum` (
  `oturum_no` int NOT NULL AUTO_INCREMENT,
  `kullanici_no` int NOT NULL,
  `refresh_token_hash` char(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip_adresi` varbinary(16) DEFAULT NULL,
  `user_agent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `olusturma_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `son_kullanma_tarihi` datetime NOT NULL,
  `iptal_mi` tinyint(1) NOT NULL DEFAULT '0',
  `iptal_tarihi` datetime DEFAULT NULL,
  PRIMARY KEY (`oturum_no`),
  UNIQUE KEY `refresh_token_hash` (`refresh_token_hash`),
  KEY `idx_oturum_kullanici_aktif` (`kullanici_no`,`iptal_mi`,`son_kullanma_tarihi`),
  CONSTRAINT `oturum_ibfk_1` FOREIGN KEY (`kullanici_no`) REFERENCES `kullanici` (`kullanici_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.oturum: ~59 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `oturum` (`oturum_no`, `kullanici_no`, `refresh_token_hash`, `ip_adresi`, `user_agent`, `olusturma_tarihi`, `son_kullanma_tarihi`, `iptal_mi`, `iptal_tarihi`) VALUES
	(29, 11, '39918dfecd23a20f6b4e01cc55c518b33df9afd272738d6a21aa4a1474d77452', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 18:49:52', '2026-10-04 18:49:52', 0, NULL),
	(30, 11, 'efce7c7d5ac03adc8e3ce1b10d96c60272292e104ae25551e0deba77a7ce1301', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 18:51:48', '2026-10-04 18:51:48', 0, NULL),
	(31, 11, '0d505432b0d57089a38461d7aa91f408b7a9bdfb53fb7082aae32d0d27c979d5', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 18:52:32', '2026-10-04 18:52:32', 0, NULL),
	(32, 11, '2a0287f32c161a6bf47c83e8fe856f4e0250969ab3cb227c6d70b0db32ee3eb7', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 18:56:38', '2026-10-04 18:56:38', 0, NULL),
	(33, 11, '918d0916cc1f3eaa73975d33f7e3ab6b90c9d855777a5449793df802aee00b86', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 18:56:52', '2026-10-04 18:56:52', 0, NULL),
	(34, 11, 'f88db82fa60fbea51636af20b5a9c4cd83f760e83439596616af231877e067d1', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 19:40:34', '2026-10-04 19:40:34', 0, NULL),
	(35, 11, 'b6a398a54299326d6777fbce70adac61e3dd4055fbb2bdad8ec7dc4b8bb559a1', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 20:22:08', '2026-10-04 20:22:08', 0, NULL),
	(36, 11, '7a7642e6eb8f69b7851175e017fef0dce49f2e5b07bfe5a69acf4d65bce6151d', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 20:23:50', '2026-10-04 20:23:50', 0, NULL),
	(37, 11, '12bc6368f0f5926be86b135503a16bef519c5e825eebcf632c30521b629b843b', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 20:27:48', '2026-10-04 20:27:48', 0, NULL),
	(38, 11, '77515e933097abb0805150fba155f1bec2081e51d6c282965781676a8823ffd3', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 20:30:31', '2026-10-04 20:30:31', 0, NULL),
	(39, 11, '57c10deab4ae286959611e70a879e2c4266ac3e94d685190167ef0547963a113', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 20:34:08', '2026-10-04 20:34:08', 0, NULL),
	(40, 11, '57b76ab61f4bb9b421b2bc65f827200b9aee46ada6de93d95c1f96087469998c', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 20:58:08', '2026-10-04 20:58:08', 0, NULL),
	(41, 11, 'b2eb0d971d7d4d1f4817cd5f780afe2b93d5a3e61a9dad67c6958564832f433e', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 20:59:17', '2026-10-04 20:59:17', 0, NULL),
	(42, 11, 'b2a380c900b4a45b2d49c66c985969189bccfbb58138efa60208add2b6b6677a', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 21:02:03', '2026-10-04 21:02:03', 0, NULL),
	(43, 11, 'e2657fc935a4efb9921c5830d7d6cf1ec3b6d5648f0a5245faf7e77f687f0120', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 21:03:28', '2026-10-04 21:03:28', 0, NULL),
	(44, 11, '245db6f7c25eeb7829212423f0f59393d336e88f40c187ed4ef813192782668d', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 21:03:57', '2026-10-04 21:03:57', 0, NULL),
	(45, 11, 'faf25109878d53d56769f4b2e32ff2c46a136f9440d2bcbae0553eaeadad7ba2', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 21:06:15', '2026-10-04 21:06:15', 0, NULL),
	(46, 11, '218aa6459ea5dd593403a39dec5f5b67d9ee0a018460eb22f6a448920d9716d1', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 21:06:29', '2026-10-04 21:06:29', 0, NULL),
	(47, 11, 'e43af276219742ce48b6417b06ed45a1a21da65f23dfaaa057049c0999083c43', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-27 21:14:22', '2026-10-04 21:14:22', 0, NULL),
	(48, 11, '7942d982e0e0d0d18388b21e36a74b87f047d9af2d6ea969dd8e930a75aa96f8', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 20:23:47', '2026-10-05 20:23:47', 0, NULL),
	(49, 11, '1e5e665868f41c6f371c493f8a1a915a6f8c021408772047bbc41ec5d3945d1a', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 20:25:04', '2026-10-05 20:25:04', 0, NULL),
	(50, 11, '0780b8d9f2d09b9c451c909580c4520e2e61ed400c61b43f1ea57dcfa99e9cb3', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 20:26:19', '2026-10-05 20:26:19', 0, NULL),
	(51, 11, '8fba4d3456a4fc40bdb4811d469f6262df038cf664ccf25519e638342f3a014f', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 20:40:07', '2026-10-05 20:40:07', 0, NULL),
	(52, 11, 'a45130a9fcc49acb081ed2a1dafc88fdbcdb4e70a4baa5faaa7ccfbd0d5d3c0b', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 20:41:14', '2026-10-05 20:41:14', 0, NULL),
	(53, 11, 'ecfd32f38af1f88d9bb00a022f4dba1373910656db270d4d462cb7cdcecc6ed5', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 20:50:14', '2026-10-05 20:50:14', 0, NULL),
	(54, 11, 'c597c09f93f2d77a256187262c627ae3f144d497858f95af12767343cc1a4ea2', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 20:56:55', '2026-10-05 20:56:55', 0, NULL),
	(55, 11, '99aabe3d12f0eaa66eaa2117d1256f161d52d9e48706544e8cbdd7cb85f853fd', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 20:57:56', '2026-10-05 20:57:56', 0, NULL),
	(56, 11, '7c664bdd7a9634c32405fba5db68d8ae36f4baba87458ffb1df6647f943c06bd', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 21:12:49', '2026-10-05 21:12:49', 0, NULL),
	(57, 11, '25d864222dab534c672c2d21ee1b12cd9d05a943bdab8f4d4ae8a8986d3b067f', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 21:12:56', '2026-10-05 21:12:56', 0, NULL),
	(58, 11, '00a3117efadf964e781be4ce9f90eb3453a47fbc13ac502584afabc1d6bb3fc3', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 21:14:20', '2026-10-05 21:14:20', 0, NULL),
	(59, 11, 'f70c38acd95b019c533914d11abd76843c97247a83c522d51d10215cc8ff6803', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 21:15:49', '2026-10-05 21:15:49', 0, NULL),
	(60, 11, '812d33408a8a74daea04d2b9a70905761e80e0a8523c7951cf53a92db603a21e', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 21:18:20', '2026-10-05 21:18:20', 0, NULL),
	(61, 11, '97995efe675c5ff40bc13f9cb7d3e7a9d0e82aca444ada24bc1e781cb2f8730c', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 21:24:23', '2026-10-05 21:24:23', 0, NULL),
	(62, 11, 'd995ba8c3ea0a752cda497a41b793b266a4bc96f2d261b03f15d51e3e174baf5', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 21:43:30', '2026-10-05 21:43:30', 0, NULL),
	(63, 11, 'c28f4203f5e4fc9f38b3c0073bb0e94c1f7680626311dfec1c49ef7034ee8555', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 21:44:37', '2026-10-05 21:44:37', 0, NULL),
	(64, 11, '8489cc29b0d0b8e6d56c330416ed4061d76f7638a291e9c8007d38ee29fb8ff4', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 21:48:13', '2026-10-05 21:48:13', 0, NULL),
	(65, 11, 'd41c150ee185b6e8a23dc0fd142ebc7a0e0072592f67cbb7489bd04a32132ff7', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 21:58:11', '2026-10-05 21:58:11', 0, NULL),
	(66, 11, 'e77d6919e93bb10e36e205720eaaa81d6256d2a764829cc87b779aca790b2134', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 21:59:11', '2026-10-05 21:59:11', 0, NULL),
	(67, 11, '847eb30448462e40491045eacea648804bc2746904f115c840fd957f3ac4fba6', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-28 22:14:51', '2026-10-05 22:14:51', 0, NULL),
	(68, 11, 'b880405fc6145ce8bd9211a08c7b29ac5042f31b227b79abce4d48aee8188566', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; tr-TR) WindowsPowerShell/5.1.26100.9444', '2026-09-29 18:58:50', '2026-10-06 18:58:50', 0, NULL),
	(117, 110, '9eca098c2c93effc4b48062d5bbed68e860744027af34899fa5c29e2573d65d2', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-29 21:03:33', '2026-10-06 21:03:33', 0, NULL),
	(118, 110, '185417de1170682abda64647a9368a7677c7eb9cab2ad8537b1112e4f76d9bfb', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-29 21:04:23', '2026-10-06 21:04:23', 0, NULL),
	(123, 110, '45d190d78da159c407bd75ddff608e37732c7a8ccb90fac26cb3403b7e422715', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-29 21:08:59', '2026-10-06 21:08:59', 0, NULL),
	(124, 110, '769f89aeb990f9c2c466d3622d15b557ba134e8d244ad8834e0091a14757143d', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-29 21:13:13', '2026-10-06 21:13:13', 0, NULL),
	(125, 110, '802a0035b6638c09b8a966b6c6099cbad23c93851f303ac6f28941cf6883a2bf', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-29 21:15:32', '2026-10-06 21:15:32', 0, NULL),
	(126, 110, 'bccc33a9387d5f75ec39e123f226f9121c9a939dfc1ff912eccaf090af1c0592', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-29 21:50:58', '2026-10-06 21:50:58', 0, NULL),
	(127, 110, 'dbe69901820ff520649464a57a0f034d524c4ea09553a6b7265a52a367288f2d', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-30 18:37:11', '2026-10-07 18:37:11', 0, NULL),
	(128, 110, 'c848e60a26c3b60462244e345b2a5b8abbb237e8ef0ae78ff94e8f785e0ac301', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-30 18:39:16', '2026-10-07 18:39:16', 0, NULL),
	(129, 118, '19d2e3cb34b23ab59384ab3b315c5062f85a06a2399b45c705124323843a3805', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-30 18:49:49', '2026-10-07 18:49:49', 0, NULL),
	(130, 110, 'd01c18bcd18cecfa2d97f484173a9bbf08ce08e384b11ff93a9c3eba21daf05a', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-30 19:37:59', '2026-10-07 19:37:59', 0, NULL),
	(131, 110, 'f7523875f2c2c208a87ba7d5f55ad9dcf51f2137574dd85a46636480c92b8b0b', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-30 20:10:39', '2026-10-07 20:10:39', 0, NULL),
	(132, 110, '54c24b8da318e8c6869ff24f378e9437a03e7b4e50e3bd5a74a6229f0673ac10', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-30 20:12:43', '2026-10-07 20:12:43', 0, NULL),
	(133, 110, 'ed90b03224348f19eb30532f660a9347a22c12c76a1d949afd7bdea766122f76', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-30 20:15:16', '2026-10-07 20:15:16', 0, NULL),
	(134, 110, '68ba432d8eeebeb7ae2528f53d0778ab06c2ef2362c01bfd5483c54d74d3250b', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-30 20:34:30', '2026-10-07 20:34:30', 0, NULL),
	(135, 110, '0f62287e4e89011f7597c9d1e0b6429f31e07ad30242775ae8df1a29588eb4a7', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-30 20:39:16', '2026-10-07 20:39:16', 0, NULL),
	(136, 110, '4fc82a1b83eaa2d4650427e79962ac20e8536480cd8be14fae0fbcec7743247f', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-30 21:01:48', '2026-10-07 21:01:48', 0, NULL),
	(137, 110, 'e1081997852d7c6621b84fca8a5e687894d79266ac69b3c4bedee0399133c7f0', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-30 21:03:28', '2026-10-07 21:03:28', 0, NULL),
	(138, 110, 'cf0ed4c8fc9b46672d219ea6513f91c02d68d725ffc4c515e84cf549b51cf50c', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-30 21:09:27', '2026-10-07 21:09:27', 0, NULL),
	(139, 110, '622104e986b54a3629ca108ad95375383d268a44874b189c5256cfb1b0fafe47', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-30 21:14:01', '2026-10-07 21:14:01', 0, NULL),
	(140, 110, '41235d69af09e7d66c991952e9009ff64dd4c1f2fd73dec386d48c61877fbd8f', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 17:38:31', '2026-10-12 17:38:31', 0, NULL),
	(141, 110, '7920f748948254ca48b7b645eccc524093d39931ff60f7b058fc94fffc0bd4c8', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-08 19:35:07', '2026-10-15 19:35:07', 0, NULL),
	(142, 110, 'c6744a2e34b9e16f84d06f5512c8f2cd13d5ad25ef97c55f36f739ca59254ff5', _binary 0x7f000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-08 19:54:23', '2026-10-15 19:54:23', 0, NULL);

-- tablo yapısı dökülüyor appapartman.parola_sifirlama_token
CREATE TABLE IF NOT EXISTS `parola_sifirlama_token` (
  `token_no` int NOT NULL AUTO_INCREMENT,
  `kullanici_no` int NOT NULL,
  `token_hash` char(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `son_kullanma_tarihi` datetime NOT NULL,
  `kullanildi_mi` tinyint(1) NOT NULL DEFAULT '0',
  `kullanilma_tarihi` datetime DEFAULT NULL,
  `ip_adresi` varbinary(16) DEFAULT NULL,
  `olusturma_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`token_no`),
  UNIQUE KEY `token_hash` (`token_hash`),
  KEY `idx_pst_kullanici_kullanildi` (`kullanici_no`,`kullanildi_mi`),
  CONSTRAINT `parola_sifirlama_token_ibfk_1` FOREIGN KEY (`kullanici_no`) REFERENCES `kullanici` (`kullanici_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.parola_sifirlama_token: ~0 rows (yaklaşık) tablosu için veriler indiriliyor

-- tablo yapısı dökülüyor appapartman.personel
CREATE TABLE IF NOT EXISTS `personel` (
  `personel_no` int NOT NULL AUTO_INCREMENT,
  `firma_no` int NOT NULL,
  `kullanici_no` int DEFAULT NULL,
  `ad` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `soyad` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gorevi` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefon` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `e_posta` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tc_kimlik_sifreli` varbinary(128) DEFAULT NULL,
  `ise_baslama_tarihi` date NOT NULL,
  `isten_cikis_tarihi` date DEFAULT NULL,
  `aktif_mi` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`personel_no`),
  KEY `kullanici_no` (`kullanici_no`),
  KEY `idx_personel_firma_aktif` (`firma_no`,`aktif_mi`),
  CONSTRAINT `personel_ibfk_1` FOREIGN KEY (`firma_no`) REFERENCES `yonetim_firmasi` (`firma_no`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `personel_ibfk_2` FOREIGN KEY (`kullanici_no`) REFERENCES `kullanici` (`kullanici_no`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.personel: ~1 rows (yaklaşık) tablosu için veriler indiriliyor

-- tablo yapısı dökülüyor appapartman.personel_izin
CREATE TABLE IF NOT EXISTS `personel_izin` (
  `izin_no` int NOT NULL AUTO_INCREMENT,
  `personel_no` int NOT NULL,
  `izin_tipi` enum('YILLIK','RAPOR','MAZERET','UCRETSIZ','DOGUM','EVLILIK') COLLATE utf8mb4_unicode_ci NOT NULL,
  `baslangic_tarihi` date NOT NULL,
  `bitis_tarihi` date NOT NULL,
  `gun_sayisi` smallint NOT NULL,
  `aciklama` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `onaylayan_no` int DEFAULT NULL,
  `onay_durum_no` int NOT NULL DEFAULT '2',
  `olusturma_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`izin_no`),
  KEY `onaylayan_no` (`onaylayan_no`),
  KEY `onay_durum_no` (`onay_durum_no`),
  KEY `idx_pi_personel_tarih` (`personel_no`,`baslangic_tarihi`),
  CONSTRAINT `personel_izin_ibfk_1` FOREIGN KEY (`personel_no`) REFERENCES `personel` (`personel_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `personel_izin_ibfk_2` FOREIGN KEY (`onaylayan_no`) REFERENCES `kullanici` (`kullanici_no`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `personel_izin_ibfk_3` FOREIGN KEY (`onay_durum_no`) REFERENCES `onay_durum` (`durum_no`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.personel_izin: ~1 rows (yaklaşık) tablosu için veriler indiriliyor

-- tablo yapısı dökülüyor appapartman.personel_maas_odeme
CREATE TABLE IF NOT EXISTS `personel_maas_odeme` (
  `maas_odeme_no` int NOT NULL AUTO_INCREMENT,
  `personel_no` int NOT NULL,
  `donem_yil` smallint NOT NULL,
  `donem_ay` tinyint NOT NULL,
  `brut_maas` decimal(12,2) NOT NULL,
  `kesintiler` decimal(12,2) NOT NULL DEFAULT '0.00',
  `net_maas` decimal(12,2) GENERATED ALWAYS AS ((`brut_maas` - `kesintiler`)) STORED,
  `odeme_tarihi` date DEFAULT NULL,
  PRIMARY KEY (`maas_odeme_no`),
  UNIQUE KEY `personel_no` (`personel_no`,`donem_yil`,`donem_ay`),
  CONSTRAINT `personel_maas_odeme_ibfk_1` FOREIGN KEY (`personel_no`) REFERENCES `personel` (`personel_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.personel_maas_odeme: ~0 rows (yaklaşık) tablosu için veriler indiriliyor

-- tablo yapısı dökülüyor appapartman.personel_puantaj
CREATE TABLE IF NOT EXISTS `personel_puantaj` (
  `puantaj_no` bigint NOT NULL AUTO_INCREMENT,
  `personel_no` int NOT NULL,
  `tarih` date NOT NULL,
  `giris_saati` time DEFAULT NULL,
  `cikis_saati` time DEFAULT NULL,
  `toplam_saat` decimal(5,2) DEFAULT NULL,
  `devamsiz_mi` tinyint(1) NOT NULL DEFAULT '0',
  `aciklama` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`puantaj_no`),
  UNIQUE KEY `personel_no` (`personel_no`,`tarih`),
  CONSTRAINT `personel_puantaj_ibfk_1` FOREIGN KEY (`personel_no`) REFERENCES `personel` (`personel_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.personel_puantaj: ~0 rows (yaklaşık) tablosu için veriler indiriliyor

-- tablo yapısı dökülüyor appapartman.personel_site
CREATE TABLE IF NOT EXISTS `personel_site` (
  `kayit_no` int NOT NULL AUTO_INCREMENT,
  `personel_no` int NOT NULL,
  `site_no` int NOT NULL,
  `baslangic_tarihi` date NOT NULL,
  `bitis_tarihi` date DEFAULT NULL,
  PRIMARY KEY (`kayit_no`),
  UNIQUE KEY `personel_no` (`personel_no`,`site_no`,`baslangic_tarihi`),
  KEY `site_no` (`site_no`),
  CONSTRAINT `personel_site_ibfk_1` FOREIGN KEY (`personel_no`) REFERENCES `personel` (`personel_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `personel_site_ibfk_2` FOREIGN KEY (`site_no`) REFERENCES `site` (`site_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.personel_site: ~1 rows (yaklaşık) tablosu için veriler indiriliyor

-- tablo yapısı dökülüyor appapartman.rol
CREATE TABLE IF NOT EXISTS `rol` (
  `rol_no` int NOT NULL AUTO_INCREMENT,
  `ad` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `aciklama` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sistem_rolu` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`rol_no`),
  UNIQUE KEY `ad` (`ad`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.rol: ~5 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `rol` (`rol_no`, `ad`, `aciklama`, `sistem_rolu`) VALUES
	(1, 'YONETICI', 'Site yoneticisi - tam yetki', 1),
	(2, 'MUHASEBECI', 'Muhasebe islemleri', 1),
	(3, 'SAKIN', 'Daire sakini', 1),
	(4, 'PERSONEL', 'Site personeli', 1),
	(5, 'DENETCI', 'Salt okunur denetci', 1);

-- tablo yapısı dökülüyor appapartman.rol_yetki
CREATE TABLE IF NOT EXISTS `rol_yetki` (
  `rol_no` int NOT NULL,
  `yetki_no` int NOT NULL,
  PRIMARY KEY (`rol_no`,`yetki_no`),
  KEY `yetki_no` (`yetki_no`),
  CONSTRAINT `rol_yetki_ibfk_1` FOREIGN KEY (`rol_no`) REFERENCES `rol` (`rol_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rol_yetki_ibfk_2` FOREIGN KEY (`yetki_no`) REFERENCES `yetki` (`yetki_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.rol_yetki: ~17 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `rol_yetki` (`rol_no`, `yetki_no`) VALUES
	(1, 1),
	(2, 1),
	(3, 1),
	(4, 1),
	(5, 1),
	(1, 2),
	(1, 3),
	(1, 4),
	(2, 4),
	(5, 4),
	(1, 5),
	(2, 5),
	(1, 6),
	(1, 7),
	(1, 8),
	(2, 8),
	(5, 8);

-- tablo yapısı dökülüyor appapartman.sayac_birim
CREATE TABLE IF NOT EXISTS `sayac_birim` (
  `birim_no` int NOT NULL AUTO_INCREMENT,
  `ad` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`birim_no`),
  UNIQUE KEY `ad` (`ad`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.sayac_birim: ~4 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `sayac_birim` (`birim_no`, `ad`) VALUES
	(2, 'kWh'),
	(3, 'lt'),
	(1, 'm3'),
	(4, 'ton');

-- tablo yapısı dökülüyor appapartman.sayac_faturasi
CREATE TABLE IF NOT EXISTS `sayac_faturasi` (
  `fatura_no` int NOT NULL AUTO_INCREMENT,
  `site_no` int NOT NULL,
  `sayac_turu_no` int NOT NULL,
  `donem_yil` smallint NOT NULL,
  `donem_ay` tinyint NOT NULL,
  `toplam_tutar` decimal(14,2) NOT NULL,
  `ortak_alan_tutar` decimal(14,2) NOT NULL DEFAULT '0.00',
  `dagitim_sekli` enum('TUKETIME_GORE','ESIT','METREKARE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'TUKETIME_GORE',
  `olusturma_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`fatura_no`),
  UNIQUE KEY `site_no` (`site_no`,`sayac_turu_no`,`donem_yil`,`donem_ay`),
  KEY `sayac_turu_no` (`sayac_turu_no`),
  CONSTRAINT `sayac_faturasi_ibfk_1` FOREIGN KEY (`site_no`) REFERENCES `site` (`site_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sayac_faturasi_ibfk_2` FOREIGN KEY (`sayac_turu_no`) REFERENCES `sayac_turu` (`sayac_turu_no`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.sayac_faturasi: ~1 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `sayac_faturasi` (`fatura_no`, `site_no`, `sayac_turu_no`, `donem_yil`, `donem_ay`, `toplam_tutar`, `ortak_alan_tutar`, `dagitim_sekli`, `olusturma_tarihi`) VALUES
	(2, 1, 1, 2026, 10, 2000.00, 200.00, 'ESIT', '2026-09-28 20:56:05');

-- tablo yapısı dökülüyor appapartman.sayac_fatura_payi
CREATE TABLE IF NOT EXISTS `sayac_fatura_payi` (
  `pay_no` int NOT NULL AUTO_INCREMENT,
  `fatura_no` int NOT NULL,
  `daire_no` int NOT NULL,
  `tuketim` decimal(12,2) NOT NULL DEFAULT '0.00',
  `daire_tutari` decimal(12,2) NOT NULL,
  `aidat_no` int DEFAULT NULL,
  PRIMARY KEY (`pay_no`),
  UNIQUE KEY `fatura_no` (`fatura_no`,`daire_no`),
  KEY `daire_no` (`daire_no`),
  KEY `aidat_no` (`aidat_no`),
  CONSTRAINT `sayac_fatura_payi_ibfk_1` FOREIGN KEY (`fatura_no`) REFERENCES `sayac_faturasi` (`fatura_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sayac_fatura_payi_ibfk_2` FOREIGN KEY (`daire_no`) REFERENCES `daire` (`daire_no`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `sayac_fatura_payi_ibfk_3` FOREIGN KEY (`aidat_no`) REFERENCES `aidat` (`aidat_no`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.sayac_fatura_payi: ~4 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `sayac_fatura_payi` (`pay_no`, `fatura_no`, `daire_no`, `tuketim`, `daire_tutari`, `aidat_no`) VALUES
	(5, 2, 1, 0.00, 450.00, NULL),
	(6, 2, 2, 0.00, 450.00, NULL),
	(7, 2, 3, 0.00, 450.00, NULL),
	(8, 2, 4, 0.00, 450.00, NULL);

-- tablo yapısı dökülüyor appapartman.sayac_okuma
CREATE TABLE IF NOT EXISTS `sayac_okuma` (
  `okuma_no` bigint NOT NULL AUTO_INCREMENT,
  `daire_sayac_no` int NOT NULL,
  `okuma_tarihi` date NOT NULL,
  `guncel_deger` decimal(12,2) NOT NULL,
  `tuketim` decimal(12,2) DEFAULT NULL,
  `okuyan_no` int DEFAULT NULL,
  `olusturma_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`okuma_no`),
  UNIQUE KEY `daire_sayac_no` (`daire_sayac_no`,`okuma_tarihi`),
  KEY `okuyan_no` (`okuyan_no`),
  KEY `idx_so_sayac_tarih` (`daire_sayac_no`,`okuma_tarihi`),
  CONSTRAINT `sayac_okuma_ibfk_1` FOREIGN KEY (`daire_sayac_no`) REFERENCES `daire_sayaci` (`daire_sayac_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sayac_okuma_ibfk_2` FOREIGN KEY (`okuyan_no`) REFERENCES `kullanici` (`kullanici_no`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.sayac_okuma: ~2 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `sayac_okuma` (`okuma_no`, `daire_sayac_no`, `okuma_tarihi`, `guncel_deger`, `tuketim`, `okuyan_no`, `olusturma_tarihi`) VALUES
	(6, 1, '2026-09-28', 200.00, 200.00, 3, '2026-09-28 20:46:10'),
	(7, 1, '2026-10-28', 230.00, 30.00, 3, '2026-09-28 20:46:10');

-- tablo yapısı dökülüyor appapartman.sayac_turu
CREATE TABLE IF NOT EXISTS `sayac_turu` (
  `sayac_turu_no` int NOT NULL AUTO_INCREMENT,
  `adi` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `birim_no` int NOT NULL,
  PRIMARY KEY (`sayac_turu_no`),
  UNIQUE KEY `adi` (`adi`),
  KEY `birim_no` (`birim_no`),
  CONSTRAINT `sayac_turu_ibfk_1` FOREIGN KEY (`birim_no`) REFERENCES `sayac_birim` (`birim_no`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.sayac_turu: ~4 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `sayac_turu` (`sayac_turu_no`, `adi`, `birim_no`) VALUES
	(1, 'Soguk Su', 1),
	(2, 'Sicak Su', 1),
	(3, 'Dogalgaz', 1),
	(4, 'Elektrik', 2);

-- tablo yapısı dökülüyor appapartman.sigorta_policesi
CREATE TABLE IF NOT EXISTS `sigorta_policesi` (
  `police_no` int NOT NULL AUTO_INCREMENT,
  `site_no` int NOT NULL,
  `demirbas_no` int DEFAULT NULL,
  `sigorta_sirketi` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `police_tipi` enum('YANGIN','DEPREM','SU_BASKINI','HIRSIZLIK','SORUMLULUK','KASKO','DIGER') COLLATE utf8mb4_unicode_ci NOT NULL,
  `police_numarasi` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `baslangic_tarihi` date NOT NULL,
  `bitis_tarihi` date NOT NULL,
  `prim_tutar` decimal(12,2) NOT NULL,
  `teminat_tutar` decimal(14,2) DEFAULT NULL,
  `belge_no` bigint DEFAULT NULL,
  `aktif_mi` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`police_no`),
  KEY `site_no` (`site_no`),
  KEY `demirbas_no` (`demirbas_no`),
  KEY `belge_no` (`belge_no`),
  KEY `idx_sp_bitis` (`bitis_tarihi`,`aktif_mi`),
  CONSTRAINT `sigorta_policesi_ibfk_1` FOREIGN KEY (`site_no`) REFERENCES `site` (`site_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sigorta_policesi_ibfk_2` FOREIGN KEY (`demirbas_no`) REFERENCES `demirbas` (`demirbas_no`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `sigorta_policesi_ibfk_3` FOREIGN KEY (`belge_no`) REFERENCES `belge` (`belge_no`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.sigorta_policesi: ~2 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `sigorta_policesi` (`police_no`, `site_no`, `demirbas_no`, `sigorta_sirketi`, `police_tipi`, `police_numarasi`, `baslangic_tarihi`, `bitis_tarihi`, `prim_tutar`, `teminat_tutar`, `belge_no`, `aktif_mi`) VALUES
	(1, 1, NULL, 'Allianz', 'SORUMLULUK', 'POL-2026-001', '2026-01-01', '2026-12-31', 12000.00, 1000000.00, NULL, 1),
	(2, 2, 2, 'Anadolu Sigorta', 'YANGIN', 'POL-2026-002', '2026-03-01', '2027-02-28', 8000.00, 500000.00, NULL, 1);

-- tablo yapısı dökülüyor appapartman.site
CREATE TABLE IF NOT EXISTS `site` (
  `site_no` int NOT NULL AUTO_INCREMENT,
  `firma_no` int NOT NULL,
  `site_adi` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `site_tipi_no` int NOT NULL,
  `adres` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `il` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ilce` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `daire_sayisi` smallint NOT NULL DEFAULT '0',
  `aylik_aidat` decimal(10,2) NOT NULL DEFAULT '0.00',
  `aidat_gunu` tinyint NOT NULL DEFAULT '5',
  `otomatik_borclandir` tinyint(1) NOT NULL DEFAULT '1',
  `aktif_mi` tinyint(1) NOT NULL DEFAULT '1',
  `olusturma_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `guncellenme_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`site_no`),
  KEY `site_tipi_no` (`site_tipi_no`),
  KEY `idx_site_firma_aktif` (`firma_no`,`aktif_mi`),
  CONSTRAINT `site_ibfk_1` FOREIGN KEY (`firma_no`) REFERENCES `yonetim_firmasi` (`firma_no`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `site_ibfk_2` FOREIGN KEY (`site_tipi_no`) REFERENCES `site_tipi` (`tip_no`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.site: ~2 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `site` (`site_no`, `firma_no`, `site_adi`, `site_tipi_no`, `adres`, `il`, `ilce`, `daire_sayisi`, `aylik_aidat`, `aidat_gunu`, `otomatik_borclandir`, `aktif_mi`, `olusturma_tarihi`, `guncellenme_tarihi`) VALUES
	(1, 1, 'Gul Sitesi', 2, 'Cumhuriyet Mah. Gul Sok. No:1', 'Istanbul', 'Kadikoy', 24, 1500.00, 5, 1, 1, '2026-09-27 16:08:57', '2026-09-27 16:08:57'),
	(2, 1, 'Yildiz Apartmani', 1, 'Baris Mah. Yildiz Cad. No:12', 'Ankara', 'Cankaya', 12, 2000.00, 10, 1, 1, '2026-09-27 16:08:57', '2026-09-27 16:08:57');

-- tablo yapısı dökülüyor appapartman.site_aidat_ayari
CREATE TABLE IF NOT EXISTS `site_aidat_ayari` (
  `ayar_no` int NOT NULL AUTO_INCREMENT,
  `site_no` int NOT NULL,
  `aidat_tipi_no` int NOT NULL,
  `tutar` decimal(10,2) NOT NULL,
  `aktif_mi` tinyint(1) NOT NULL DEFAULT '1',
  `baslangic_tarihi` date NOT NULL,
  `bitis_tarihi` date DEFAULT NULL,
  PRIMARY KEY (`ayar_no`),
  UNIQUE KEY `site_no` (`site_no`,`aidat_tipi_no`,`baslangic_tarihi`),
  KEY `aidat_tipi_no` (`aidat_tipi_no`),
  CONSTRAINT `site_aidat_ayari_ibfk_1` FOREIGN KEY (`site_no`) REFERENCES `site` (`site_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `site_aidat_ayari_ibfk_2` FOREIGN KEY (`aidat_tipi_no`) REFERENCES `aidat_tipi` (`tip_no`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.site_aidat_ayari: ~3 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `site_aidat_ayari` (`ayar_no`, `site_no`, `aidat_tipi_no`, `tutar`, `aktif_mi`, `baslangic_tarihi`, `bitis_tarihi`) VALUES
	(1, 1, 1, 1500.00, 1, '2025-01-01', NULL),
	(2, 1, 6, 300.00, 1, '2025-01-01', NULL),
	(3, 2, 1, 2000.00, 1, '2025-01-01', NULL);

-- tablo yapısı dökülüyor appapartman.site_tipi
CREATE TABLE IF NOT EXISTS `site_tipi` (
  `tip_no` int NOT NULL AUTO_INCREMENT,
  `ad` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`tip_no`),
  UNIQUE KEY `ad` (`ad`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.site_tipi: ~4 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `site_tipi` (`tip_no`, `ad`) VALUES
	(1, 'APARTMAN'),
	(4, 'PLAZA'),
	(3, 'REZIDANS'),
	(2, 'SITE');

-- tablo yapısı dökülüyor appapartman.talep
CREATE TABLE IF NOT EXISTS `talep` (
  `talep_no` bigint NOT NULL AUTO_INCREMENT,
  `site_no` int NOT NULL,
  `acan_no` int NOT NULL,
  `daire_no` int DEFAULT NULL,
  `kategori_no` int NOT NULL,
  `konu` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `aciklama` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `oncelik_no` int NOT NULL,
  `durum_no` int NOT NULL,
  `acilis_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cozum_tarihi` datetime DEFAULT NULL,
  `cozen_no` int DEFAULT NULL,
  `cozum_notu` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`talep_no`),
  KEY `acan_no` (`acan_no`),
  KEY `daire_no` (`daire_no`),
  KEY `kategori_no` (`kategori_no`),
  KEY `oncelik_no` (`oncelik_no`),
  KEY `durum_no` (`durum_no`),
  KEY `cozen_no` (`cozen_no`),
  KEY `idx_talep_site_durum` (`site_no`,`durum_no`),
  CONSTRAINT `talep_ibfk_1` FOREIGN KEY (`site_no`) REFERENCES `site` (`site_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `talep_ibfk_2` FOREIGN KEY (`acan_no`) REFERENCES `kullanici` (`kullanici_no`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `talep_ibfk_3` FOREIGN KEY (`daire_no`) REFERENCES `daire` (`daire_no`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `talep_ibfk_4` FOREIGN KEY (`kategori_no`) REFERENCES `talep_kategori` (`kategori_no`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `talep_ibfk_5` FOREIGN KEY (`oncelik_no`) REFERENCES `is_oncelik` (`oncelik_no`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `talep_ibfk_6` FOREIGN KEY (`durum_no`) REFERENCES `talep_durum` (`durum_no`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `talep_ibfk_7` FOREIGN KEY (`cozen_no`) REFERENCES `kullanici` (`kullanici_no`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.talep: ~2 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `talep` (`talep_no`, `site_no`, `acan_no`, `daire_no`, `kategori_no`, `konu`, `aciklama`, `oncelik_no`, `durum_no`, `acilis_tarihi`, `cozum_tarihi`, `cozen_no`, `cozum_notu`) VALUES
	(1, 1, 4, 1, 1, 'Merdiven Aydinlatmasi', '2. kat merdiven lambasi yanmiyor.', 3, 1, '2026-09-27 16:08:57', NULL, NULL, NULL),
	(2, 2, 6, 6, 2, 'Ortak Alan Temizligi', 'Giris holu zemini kirli.', 4, 2, '2026-09-27 16:08:57', NULL, NULL, NULL);

-- tablo yapısı dökülüyor appapartman.talep_durum
CREATE TABLE IF NOT EXISTS `talep_durum` (
  `durum_no` int NOT NULL AUTO_INCREMENT,
  `ad` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kapanis_mi` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`durum_no`),
  UNIQUE KEY `ad` (`ad`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.talep_durum: ~5 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `talep_durum` (`durum_no`, `ad`, `kapanis_mi`) VALUES
	(1, 'ACIK', 0),
	(2, 'INCELENIYOR', 0),
	(3, 'COZULDU', 1),
	(4, 'REDDEDILDI', 1),
	(5, 'KAPANDI', 1);

-- tablo yapısı dökülüyor appapartman.talep_kategori
CREATE TABLE IF NOT EXISTS `talep_kategori` (
  `kategori_no` int NOT NULL AUTO_INCREMENT,
  `ad` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`kategori_no`),
  UNIQUE KEY `ad` (`ad`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.talep_kategori: ~5 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `talep_kategori` (`kategori_no`, `ad`) VALUES
	(1, 'ARIZA'),
	(5, 'DIGER'),
	(4, 'IZIN'),
	(3, 'ONERI'),
	(2, 'SIKAYET');

-- tablo yapısı dökülüyor appapartman.toplanti
CREATE TABLE IF NOT EXISTS `toplanti` (
  `toplanti_no` bigint NOT NULL AUTO_INCREMENT,
  `site_no` int NOT NULL,
  `baslik` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `aciklama` text COLLATE utf8mb4_unicode_ci,
  `toplanti_tarihi` datetime NOT NULL,
  `yer` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `olusturan_no` int NOT NULL,
  `durum` enum('PLANLANDI','YAPILDI','IPTAL') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PLANLANDI',
  PRIMARY KEY (`toplanti_no`),
  KEY `olusturan_no` (`olusturan_no`),
  KEY `idx_toplanti_site_tarih` (`site_no`,`toplanti_tarihi`),
  CONSTRAINT `toplanti_ibfk_1` FOREIGN KEY (`site_no`) REFERENCES `site` (`site_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `toplanti_ibfk_2` FOREIGN KEY (`olusturan_no`) REFERENCES `kullanici` (`kullanici_no`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.toplanti: ~1 rows (yaklaşık) tablosu için veriler indiriliyor

-- tablo yapısı dökülüyor appapartman.toplanti_karar
CREATE TABLE IF NOT EXISTS `toplanti_karar` (
  `karar_no` int NOT NULL AUTO_INCREMENT,
  `toplanti_no` bigint NOT NULL,
  `karar_metni` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `karar_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`karar_no`),
  KEY `toplanti_no` (`toplanti_no`),
  CONSTRAINT `toplanti_karar_ibfk_1` FOREIGN KEY (`toplanti_no`) REFERENCES `toplanti` (`toplanti_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.toplanti_karar: ~0 rows (yaklaşık) tablosu için veriler indiriliyor

-- tablo yapısı dökülüyor appapartman.toplanti_katilimci
CREATE TABLE IF NOT EXISTS `toplanti_katilimci` (
  `katilim_no` int NOT NULL AUTO_INCREMENT,
  `toplanti_no` bigint NOT NULL,
  `kullanici_no` int NOT NULL,
  `katildi_mi` tinyint(1) NOT NULL DEFAULT '0',
  `vekalet_kullanici_no` int DEFAULT NULL,
  PRIMARY KEY (`katilim_no`),
  UNIQUE KEY `toplanti_no` (`toplanti_no`,`kullanici_no`),
  KEY `kullanici_no` (`kullanici_no`),
  KEY `vekalet_kullanici_no` (`vekalet_kullanici_no`),
  CONSTRAINT `toplanti_katilimci_ibfk_1` FOREIGN KEY (`toplanti_no`) REFERENCES `toplanti` (`toplanti_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `toplanti_katilimci_ibfk_2` FOREIGN KEY (`kullanici_no`) REFERENCES `kullanici` (`kullanici_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `toplanti_katilimci_ibfk_3` FOREIGN KEY (`vekalet_kullanici_no`) REFERENCES `kullanici` (`kullanici_no`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.toplanti_katilimci: ~0 rows (yaklaşık) tablosu için veriler indiriliyor

-- tablo yapısı dökülüyor appapartman.yetki
CREATE TABLE IF NOT EXISTS `yetki` (
  `yetki_no` int NOT NULL AUTO_INCREMENT,
  `kod` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ad` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `modul` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`yetki_no`),
  UNIQUE KEY `kod` (`kod`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.yetki: ~8 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `yetki` (`yetki_no`, `kod`, `ad`, `modul`) VALUES
	(1, 'aidat.goruntule', 'Aidat Goruntule', 'aidat'),
	(2, 'aidat.olustur', 'Aidat Olustur', 'aidat'),
	(3, 'aidat.sil', 'Aidat Sil', 'aidat'),
	(4, 'gider.goruntule', 'Gider Goruntule', 'gider'),
	(5, 'gider.olustur', 'Gider Olustur', 'gider'),
	(6, 'kullanici.yonet', 'Kullanici Yonet', 'kullanici'),
	(7, 'site.yonet', 'Site Yonet', 'site'),
	(8, 'rapor.goruntule', 'Rapor Goruntule', 'rapor');

-- tablo yapısı dökülüyor appapartman.yonetim_firmasi
CREATE TABLE IF NOT EXISTS `yonetim_firmasi` (
  `firma_no` int NOT NULL AUTO_INCREMENT,
  `firma_adi` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `vergi_no` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `adres` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefon` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `e_posta` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `yetkili_kisi` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `aktif_mi` tinyint(1) NOT NULL DEFAULT '1',
  `olusturma_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `guncellenme_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`firma_no`),
  UNIQUE KEY `vergi_no` (`vergi_no`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.yonetim_firmasi: ~0 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `yonetim_firmasi` (`firma_no`, `firma_adi`, `vergi_no`, `adres`, `telefon`, `e_posta`, `yetkili_kisi`, `aktif_mi`, `olusturma_tarihi`, `guncellenme_tarihi`) VALUES
	(1, 'Ornek Yonetim Ltd. Sti.', '1234567890', 'Ataturk Cad. No:45 Kadikoy/Istanbul', '02161234567', 'info@ornekyonetim.com', 'Ahmet Yilmaz', 1, '2026-09-27 16:08:57', '2026-09-27 16:08:57');

-- tablo yapısı dökülüyor appapartman.ziyaretci_kaydi
CREATE TABLE IF NOT EXISTS `ziyaretci_kaydi` (
  `ziyaret_no` bigint NOT NULL AUTO_INCREMENT,
  `site_no` int NOT NULL,
  `daire_no` int NOT NULL,
  `ad_soyad` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefon` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ziyaret_sebebi` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `arac_plaka` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `giris_tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cikis_tarihi` datetime DEFAULT NULL,
  `onaylayan_kullanici_no` int DEFAULT NULL,
  PRIMARY KEY (`ziyaret_no`),
  KEY `daire_no` (`daire_no`),
  KEY `onaylayan_kullanici_no` (`onaylayan_kullanici_no`),
  KEY `idx_zk_site_giris` (`site_no`,`giris_tarihi`),
  CONSTRAINT `ziyaretci_kaydi_ibfk_1` FOREIGN KEY (`site_no`) REFERENCES `site` (`site_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ziyaretci_kaydi_ibfk_2` FOREIGN KEY (`daire_no`) REFERENCES `daire` (`daire_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ziyaretci_kaydi_ibfk_3` FOREIGN KEY (`onaylayan_kullanici_no`) REFERENCES `kullanici` (`kullanici_no`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- appapartman.ziyaretci_kaydi: ~2 rows (yaklaşık) tablosu için veriler indiriliyor
INSERT INTO `ziyaretci_kaydi` (`ziyaret_no`, `site_no`, `daire_no`, `ad_soyad`, `telefon`, `ziyaret_sebebi`, `arac_plaka`, `giris_tarihi`, `cikis_tarihi`, `onaylayan_kullanici_no`) VALUES
	(1, 1, 1, 'Ali Veli', '05551112233', 'Misafir', NULL, '2026-09-27 16:08:57', NULL, 4),
	(2, 2, 5, 'Hasan Kaya', '05554445566', 'Kargo teslimi', NULL, '2026-09-27 16:08:57', NULL, 6);

-- tetikleyici yapısı dökülüyor appapartman.trg_aidat_before_insert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `trg_aidat_before_insert` BEFORE INSERT ON `aidat` FOR EACH ROW BEGIN
    IF NEW.donem_ay < 1 OR NEW.donem_ay > 12 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'aidat: donem_ay 1 ile 12 arasinda olmalidir.';
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- tetikleyici yapısı dökülüyor appapartman.trg_aidat_before_update
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `trg_aidat_before_update` BEFORE UPDATE ON `aidat` FOR EACH ROW BEGIN
    IF NEW.donem_ay < 1 OR NEW.donem_ay > 12 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'aidat: donem_ay 1 ile 12 arasinda olmalidir.';
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- tetikleyici yapısı dökülüyor appapartman.trg_odeme_detay_before_insert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `trg_odeme_detay_before_insert` BEFORE INSERT ON `odeme_detay` FOR EACH ROW BEGIN
    IF NOT (
        (NEW.aidat_no IS NOT NULL AND NEW.gider_no IS NULL) OR
        (NEW.aidat_no IS NULL AND NEW.gider_no IS NOT NULL)
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'odeme_detay: aidat_no veya gider_no alanlarindan yalnizca biri dolu olmalidir.';
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- tetikleyici yapısı dökülüyor appapartman.trg_odeme_detay_before_update
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `trg_odeme_detay_before_update` BEFORE UPDATE ON `odeme_detay` FOR EACH ROW BEGIN
    IF NOT (
        (NEW.aidat_no IS NOT NULL AND NEW.gider_no IS NULL) OR
        (NEW.aidat_no IS NULL AND NEW.gider_no IS NOT NULL)
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'odeme_detay: aidat_no veya gider_no alanlarindan yalnizca biri dolu olmalidir.';
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- tetikleyici yapısı dökülüyor appapartman.trg_personel_maas_before_insert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `trg_personel_maas_before_insert` BEFORE INSERT ON `personel_maas_odeme` FOR EACH ROW BEGIN
    IF NEW.donem_ay < 1 OR NEW.donem_ay > 12 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'personel_maas_odeme: donem_ay 1 ile 12 arasinda olmalidir.';
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- tetikleyici yapısı dökülüyor appapartman.trg_personel_maas_before_update
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `trg_personel_maas_before_update` BEFORE UPDATE ON `personel_maas_odeme` FOR EACH ROW BEGIN
    IF NEW.donem_ay < 1 OR NEW.donem_ay > 12 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'personel_maas_odeme: donem_ay 1 ile 12 arasinda olmalidir.';
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- tetikleyici yapısı dökülüyor appapartman.trg_sayac_faturasi_before_insert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `trg_sayac_faturasi_before_insert` BEFORE INSERT ON `sayac_faturasi` FOR EACH ROW BEGIN
    IF NEW.donem_ay < 1 OR NEW.donem_ay > 12 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'sayac_faturasi: donem_ay 1 ile 12 arasinda olmalidir.';
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- tetikleyici yapısı dökülüyor appapartman.trg_sayac_faturasi_before_update
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `trg_sayac_faturasi_before_update` BEFORE UPDATE ON `sayac_faturasi` FOR EACH ROW BEGIN
    IF NEW.donem_ay < 1 OR NEW.donem_ay > 12 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'sayac_faturasi: donem_ay 1 ile 12 arasinda olmalidir.';
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- tetikleyici yapısı dökülüyor appapartman.trg_sayac_okuma_tuketim
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `trg_sayac_okuma_tuketim` BEFORE INSERT ON `sayac_okuma` FOR EACH ROW BEGIN
    DECLARE onceki DECIMAL(12,2) DEFAULT 0;
    SELECT guncel_deger INTO onceki
    FROM sayac_okuma
    WHERE daire_sayac_no = NEW.daire_sayac_no
      AND okuma_tarihi < NEW.okuma_tarihi
    ORDER BY okuma_tarihi DESC
    LIMIT 1;
    IF onceki IS NULL THEN
        SELECT IFNULL(ilk_deger, 0) INTO onceki
        FROM daire_sayaci WHERE daire_sayac_no = NEW.daire_sayac_no;
    END IF;
    SET NEW.tuketim = NEW.guncel_deger - IFNULL(onceki, 0);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
