-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 12 Des 2025 pada 18.08
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbprakerin`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `berkas_peserta`
--

CREATE TABLE `berkas_peserta` (
  `id` int(11) NOT NULL,
  `id_peserta` int(11) NOT NULL,
  `surat_pengantar_magang` varchar(255) NOT NULL,
  `proposal_magang` varchar(255) NOT NULL,
  `curriculum_vitae` varchar(255) NOT NULL,
  `surat_pembuatan_idcard` varchar(255) DEFAULT NULL,
  `surat_penerimaan` varchar(255) DEFAULT NULL,
  `pas_foto` varchar(255) DEFAULT NULL,
  `surat_sehat` varchar(255) DEFAULT NULL,
  `kartu_tanda_mahasiswa` varchar(255) DEFAULT NULL,
  `ktp` varchar(255) DEFAULT NULL,
  `kartu_keluarga` varchar(255) DEFAULT NULL,
  `sim` varchar(255) DEFAULT NULL,
  `stnk` varchar(255) DEFAULT NULL,
  `skck` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `berkas_peserta`
--

INSERT INTO `berkas_peserta` (`id`, `id_peserta`, `surat_pengantar_magang`, `proposal_magang`, `curriculum_vitae`, `surat_pembuatan_idcard`, `surat_penerimaan`, `pas_foto`, `surat_sehat`, `kartu_tanda_mahasiswa`, `ktp`, `kartu_keluarga`, `sim`, `stnk`, `skck`, `created_at`, `updated_at`) VALUES
(3, 3, 'static/uploads\\File_Testing_Upload_CV.pdf', 'static/uploads\\File_Testing_Upload_CV.pdf', 'static/uploads\\File_Testing_Upload_CV.pdf', 'uploads\\File_Testing_Surat_IDCARD.pdf', 'uploads\\File_Testing_Surat_Penerimaan_Magang.pdf', 'uploads\\Contoh_File_Pas_Foto.pdf', 'uploads\\File_Testing_Surat_Keterangan_Sehat.pdf', 'uploads\\File_Testing_KTM.pdf', 'uploads\\File_Testing_KTP.pdf', 'uploads\\File_Testing_Kartu_Keluarga.pdf', 'uploads\\File_Testing_SIM.pdf', 'uploads\\File_Testing_STNK.pdf', 'uploads\\File_Testing_SKCK.pdf', '2025-07-05 16:50:24', '2025-07-05 21:07:21'),
(4, 4, 'uploads\\File_Testing_Upload_Surat_Pengantar.pdf', 'uploads\\File_Testing_Upload_Proposal_Magang.pdf', 'uploads\\File_Testing_Upload_CV.pdf', NULL, NULL, 'uploads\\Contoh_File_Pas_Foto.jpg', 'uploads\\File_Testing_Surat_Keterangan_Sehat.pdf', 'uploads\\File_Testing_KTM.pdf', 'uploads\\File_Testing_KTP.pdf', 'uploads\\File_Testing_Kartu_Keluarga.pdf', 'uploads\\File_Testing_SIM.pdf', 'uploads\\File_Testing_STNK.pdf', 'uploads\\File_Testing_SKCK.pdf', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(21, 5, 'uploads/File_Testing_Upload_Surat_Pengantar.pdf', 'uploads/File_Testing_Upload_Proposal_Magang.pdf', 'uploads/File_Testing_Upload_CV.pdf', 'uploads/File_Testing_Surat_IDCARD.pdf', 'uploads/File_Testing_Surat_Penerimaan_Magang.pdf', 'uploads\\Contoh_File_Pas_Foto.jpg', 'uploads/File_Testing_Surat_Keterangan_Sehat.pdf', 'uploads/File_Testing_KTM.pdf', 'uploads/File_Testing_KTP.pdf', 'uploads/File_Testing_Kartu_Keluarga.pdf', 'uploads/File_Testing_SIM.pdf', 'uploads/File_Testing_STNK.pdf', 'uploads/File_Testing_SKCK.pdf', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(32, 6, 'uploads/File_Testing_Upload_Surat_Pengantar.pdf', 'uploads/File_Testing_Upload_Proposal_Magang.pdf', 'uploads/File_Testing_Upload_CV.pdf', 'uploads/File_Testing_Surat_IDCARD.pdf', 'uploads/File_Testing_Surat_Penerimaan_Magang.pdf', 'uploads\\Contoh_File_Pas_Foto.jpg', 'uploads/File_Testing_Surat_Keterangan_Sehat.pdf', 'uploads/File_Testing_KTM.pdf', 'uploads/File_Testing_KTP.pdf', 'uploads/File_Testing_Kartu_Keluarga.pdf', 'uploads/File_Testing_SIM.pdf', 'uploads/File_Testing_STNK.pdf', 'uploads/File_Testing_SKCK.pdf', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(33, 7, 'uploads/File_Testing_Upload_Surat_Pengantar.pdf', 'uploads/File_Testing_Upload_Proposal_Magang.pdf', 'uploads/File_Testing_Upload_CV.pdf', 'uploads/File_Testing_Surat_IDCARD.pdf', 'uploads/File_Testing_Surat_Penerimaan_Magang.pdf', 'uploads\\Contoh_File_Pas_Foto.jpg', 'uploads/File_Testing_Surat_Keterangan_Sehat.pdf', 'uploads/File_Testing_KTM.pdf', 'uploads/File_Testing_KTP.pdf', 'uploads/File_Testing_Kartu_Keluarga.pdf', 'uploads/File_Testing_SIM.pdf', 'uploads/File_Testing_STNK.pdf', 'uploads/File_Testing_SKCK.pdf', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(35, 9, 'uploads/File_Testing_Upload_Surat_Pengantar.pdf', 'uploads/File_Testing_Upload_Proposal_Magang.pdf', 'uploads/File_Testing_Upload_CV.pdf', 'uploads/File_Testing_Surat_IDCARD.pdf', 'uploads/File_Testing_Surat_Penerimaan_Magang.pdf', 'uploads\\Contoh_File_Pas_Foto.jpg', 'uploads/File_Testing_Surat_Keterangan_Sehat.pdf', 'uploads/File_Testing_KTM.pdf', 'uploads/File_Testing_KTP.pdf', 'uploads/File_Testing_Kartu_Keluarga.pdf', 'uploads/File_Testing_SIM.pdf', 'uploads/File_Testing_STNK.pdf', 'uploads/File_Testing_SKCK.pdf', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(37, 11, 'uploads/File_Testing_Upload_Surat_Pengantar.pdf', 'uploads/File_Testing_Upload_Proposal_Magang.pdf', 'uploads/File_Testing_Upload_CV.pdf', 'uploads/File_Testing_Surat_IDCARD.pdf', 'uploads/File_Testing_Surat_Penerimaan_Magang.pdf', 'uploads\\Contoh_File_Pas_Foto.jpg', 'uploads/File_Testing_Surat_Keterangan_Sehat.pdf', 'uploads/File_Testing_KTM.pdf', 'uploads/File_Testing_KTP.pdf', 'uploads/File_Testing_Kartu_Keluarga.pdf', 'uploads/File_Testing_SIM.pdf', 'uploads/File_Testing_STNK.pdf', 'uploads/File_Testing_SKCK.pdf', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(38, 12, 'uploads/File_Testing_Upload_Surat_Pengantar.pdf', 'uploads/File_Testing_Upload_Proposal_Magang.pdf', 'uploads/File_Testing_Upload_CV.pdf', 'uploads/File_Testing_Surat_IDCARD.pdf', 'uploads/File_Testing_Surat_Penerimaan_Magang.pdf', 'uploads\\Contoh_File_Pas_Foto.jpg', 'uploads/File_Testing_Surat_Keterangan_Sehat.pdf', 'uploads/File_Testing_KTM.pdf', 'uploads/File_Testing_KTP.pdf', 'uploads/File_Testing_Kartu_Keluarga.pdf', 'uploads/File_Testing_SIM.pdf', 'uploads/File_Testing_STNK.pdf', 'uploads/File_Testing_SKCK.pdf', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(39, 13, 'uploads/File_Testing_Upload_Surat_Pengantar.pdf', 'uploads/File_Testing_Upload_Proposal_Magang.pdf', 'uploads/File_Testing_Upload_CV.pdf', 'uploads/File_Testing_Surat_IDCARD.pdf', 'uploads/File_Testing_Surat_Penerimaan_Magang.pdf', 'uploads\\Contoh_File_Pas_Foto.jpg', 'uploads/File_Testing_Surat_Keterangan_Sehat.pdf', 'uploads/File_Testing_KTM.pdf', 'uploads/File_Testing_KTP.pdf', 'uploads/File_Testing_Kartu_Keluarga.pdf', 'uploads/File_Testing_SIM.pdf', 'uploads/File_Testing_STNK.pdf', 'uploads/File_Testing_SKCK.pdf', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(40, 14, 'uploads/File_Testing_Upload_Surat_Pengantar.pdf', 'uploads/File_Testing_Upload_Proposal_Magang.pdf', 'uploads/File_Testing_Upload_CV.pdf', 'uploads\\File_Testing_Surat_IDCARD.pdf', 'uploads\\File_Testing_Surat_Penerimaan_Magang.pdf', 'uploads\\Contoh_File_Pas_Foto.jpg', 'uploads\\File_Testing_SKCK.pdf', 'uploads\\File_Testing_KTM.pdf', 'uploads\\File_Testing_KTP.pdf', 'uploads\\File_Testing_Kartu_Keluarga.pdf', 'uploads\\File_Testing_SIM.pdf', 'uploads\\File_Testing_STNK.pdf', 'uploads\\File_Testing_SKCK.pdf', '2025-07-05 16:50:24', '2025-12-12 22:55:58'),
(41, 15, 'uploads/File_Testing_Upload_Surat_Pengantar.pdf', 'uploads/File_Testing_Upload_Proposal_Magang.pdf', 'uploads/File_Testing_Upload_CV.pdf', 'uploads/File_Testing_Surat_IDCARD.pdf', 'uploads/File_Testing_Surat_Penerimaan_Magang.pdf', 'uploads\\Contoh_File_Pas_Foto.jpg', 'uploads/File_Testing_Surat_Keterangan_Sehat.pdf', 'uploads/File_Testing_KTM.pdf', 'uploads/File_Testing_KTP.pdf', 'uploads/File_Testing_Kartu_Keluarga.pdf', 'uploads/File_Testing_SIM.pdf', 'uploads/File_Testing_STNK.pdf', 'uploads/File_Testing_SKCK.pdf', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(42, 16, 'uploads/File_Testing_Upload_Surat_Pengantar.pdf', 'uploads/File_Testing_Upload_Proposal_Magang.pdf', 'uploads/File_Testing_Upload_CV.pdf', 'uploads/File_Testing_Surat_IDCARD.pdf', 'uploads/File_Testing_Surat_Penerimaan_Magang.pdf', 'uploads\\Contoh_File_Pas_Foto.jpg', 'uploads/File_Testing_Surat_Keterangan_Sehat.pdf', 'uploads/File_Testing_KTM.pdf', 'uploads/File_Testing_KTP.pdf', 'uploads/File_Testing_Kartu_Keluarga.pdf', 'uploads/File_Testing_SIM.pdf', 'uploads/File_Testing_STNK.pdf', 'uploads/File_Testing_SKCK.pdf', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(43, 17, 'uploads/File_Testing_Upload_Surat_Pengantar.pdf', 'uploads/File_Testing_Upload_Proposal_Magang.pdf', 'uploads/File_Testing_Upload_CV.pdf', 'uploads/File_Testing_Surat_IDCARD.pdf', 'uploads/File_Testing_Surat_Penerimaan_Magang.pdf', 'uploads\\Contoh_File_Pas_Foto.jpg', 'uploads/File_Testing_Surat_Keterangan_Sehat.pdf', 'uploads/File_Testing_KTM.pdf', 'uploads/File_Testing_KTP.pdf', 'uploads/File_Testing_Kartu_Keluarga.pdf', 'uploads/File_Testing_SIM.pdf', 'uploads/File_Testing_STNK.pdf', 'uploads/File_Testing_SKCK.pdf', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(44, 18, 'uploads/File_Testing_Upload_Surat_Pengantar.pdf', 'uploads/File_Testing_Upload_Proposal_Magang.pdf', 'uploads/File_Testing_Upload_CV.pdf', 'uploads/File_Testing_Surat_IDCARD.pdf', 'uploads/File_Testing_Surat_Penerimaan_Magang.pdf', 'uploads\\Contoh_File_Pas_Foto.jpg', 'uploads/File_Testing_Surat_Keterangan_Sehat.pdf', 'uploads/File_Testing_KTM.pdf', 'uploads/File_Testing_KTP.pdf', 'uploads/File_Testing_Kartu_Keluarga.pdf', 'uploads/File_Testing_SIM.pdf', 'uploads/File_Testing_STNK.pdf', 'uploads/File_Testing_SKCK.pdf', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(45, 19, 'uploads/File_Testing_Upload_Surat_Pengantar.pdf', 'uploads/File_Testing_Upload_Proposal_Magang.pdf', 'uploads/File_Testing_Upload_CV.pdf', 'uploads/File_Testing_Surat_IDCARD.pdf', 'uploads/File_Testing_Surat_Penerimaan_Magang.pdf', 'uploads\\Contoh_File_Pas_Foto.jpg', 'uploads/File_Testing_Surat_Keterangan_Sehat.pdf', 'uploads/File_Testing_KTM.pdf', 'uploads/File_Testing_KTP.pdf', 'uploads/File_Testing_Kartu_Keluarga.pdf', 'uploads/File_Testing_SIM.pdf', 'uploads/File_Testing_STNK.pdf', 'uploads/File_Testing_SKCK.pdf', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(46, 20, 'uploads/File_Testing_Upload_Surat_Pengantar.pdf', 'uploads/File_Testing_Upload_Proposal_Magang.pdf', 'uploads/File_Testing_Upload_CV.pdf', 'uploads/File_Testing_Surat_IDCARD.pdf', 'uploads/File_Testing_Surat_Penerimaan_Magang.pdf', 'uploads\\Contoh_File_Pas_Foto.jpg', 'uploads/File_Testing_Surat_Keterangan_Sehat.pdf', 'uploads/File_Testing_KTM.pdf', 'uploads/File_Testing_KTP.pdf', 'uploads/File_Testing_Kartu_Keluarga.pdf', 'uploads/File_Testing_SIM.pdf', 'uploads/File_Testing_STNK.pdf', 'uploads/File_Testing_SKCK.pdf', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(47, 21, 'uploads\\File_Testing_Upload_Surat_Pengantar.pdf', 'uploads\\File_Testing_Upload_Proposal_Magang.pdf', 'uploads\\File_Testing_Upload_CV.pdf', 'uploads\\File_Testing_Surat_Penerimaan_Magang.pdf', 'uploads\\File_Testing_Surat_IDCARD.pdf', 'uploads\\Contoh_File_Pas_Foto.jpg', 'uploads\\File_Testing_Surat_Keterangan_Sehat.pdf', 'uploads\\File_Testing_KTM.pdf', 'uploads\\File_Testing_KTP.pdf', 'uploads\\File_Testing_Kartu_Keluarga.pdf', 'uploads\\File_Testing_SIM.pdf', 'uploads\\File_Testing_STNK.pdf', 'uploads\\File_Testing_SKCK.pdf', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(48, 22, 'uploads\\Laporan_Final_Tim_Schrodinger_124.pdf', 'uploads\\Laporan_Final_Tim_Schrodinger_124.pdf', 'uploads\\Laporan_Final_Tim_Schrodinger_124.pdf', 'uploads\\Laporan_Final_Tim_Schrodinger_124.pdf', 'uploads\\Laporan_Final_Tim_Schrodinger_124.pdf', 'uploads\\Contoh_File_Pas_Foto.jpg', 'uploads\\Laporan_Final_Tim_Schrodinger_124.pdf', 'uploads\\Laporan_Final_Tim_Schrodinger_124.pdf', 'uploads\\Laporan_Final_Tim_Schrodinger_124.pdf', 'uploads\\Laporan_Final_Tim_Schrodinger_124.pdf', 'uploads\\Laporan_Final_Tim_Schrodinger_124.pdf', 'uploads\\Laporan_Final_Tim_Schrodinger_124.pdf', 'uploads\\Laporan_Final_Tim_Schrodinger_124.pdf', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(49, 23, 'uploads\\File_Testing_Upload_Surat_Pengantar.pdf', 'uploads\\File_Testing_Upload_Proposal_Magang.pdf', 'uploads\\File_Testing_Upload_CV.pdf', 'uploads\\File_Testing_Surat_IDCARD.pdf', 'uploads\\File_Testing_Surat_Penerimaan_Magang.pdf', 'uploads\\Contoh_File_Pas_Foto.jpg', 'uploads\\File_Testing_Surat_Keterangan_Sehat.pdf', 'uploads\\File_Testing_KTM.pdf', 'uploads\\File_Testing_KTP.pdf', 'uploads\\File_Testing_Kartu_Keluarga.pdf', 'uploads\\File_Testing_SIM.pdf', 'uploads\\File_Testing_STNK.pdf', 'uploads\\File_Testing_SKCK.pdf', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(50, 24, 'uploads\\CV_Aulia_H_2025.pdf', 'uploads\\CV_Aulia_H_2025.pdf', 'uploads\\CV_Aulia_H_2025.pdf', 'uploads\\Laporan_Peserta_Prakerin_3.pdf', 'uploads\\Laporan_Peserta_Prakerin_3.pdf', 'uploads\\Laporan_Peserta_Prakerin_3.pdf', 'uploads\\Laporan_Peserta_Prakerin_3.pdf', 'uploads\\Laporan_Peserta_Prakerin_3.pdf', 'uploads\\Laporan_Peserta_Prakerin_3.pdf', 'uploads\\Laporan_Peserta_Prakerin_3.pdf', 'uploads\\Laporan_Peserta_Prakerin_3.pdf', 'uploads\\Laporan_Peserta_Prakerin_3.pdf', 'uploads\\Laporan_Peserta_Prakerin_3.pdf', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(51, 25, 'uploads\\File_Testing_Upload_Surat_Pengantar.pdf', 'uploads\\File_Testing_Upload_Proposal_Magang.pdf', 'uploads\\File_Testing_Upload_CV.pdf', 'uploads\\File_Testing_Surat_IDCARD.pdf', 'uploads\\File_Testing_Surat_Penerimaan_Magang.pdf', 'uploads\\Contoh_File_Pas_Foto.jpg', 'uploads\\File_Testing_Surat_Keterangan_Sehat.pdf', 'uploads\\File_Testing_KTM.pdf', 'uploads\\File_Testing_KTP.pdf', 'uploads\\File_Testing_Kartu_Keluarga.pdf', 'uploads\\File_Testing_SIM.pdf', 'uploads\\File_Testing_STNK.pdf', 'uploads\\File_Testing_SKCK.pdf', '2025-07-05 16:50:24', '2025-07-07 02:00:04'),
(52, 26, 'uploads\\Contoh_Surat.pdf', 'uploads\\Contoh_Surat.pdf', 'uploads\\Contoh_Surat.pdf', 'uploads\\Contoh_Surat.pdf', 'uploads\\Contoh_Surat.pdf', 'uploads\\Contoh_Surat.pdf', 'uploads\\Contoh_Surat.pdf', 'uploads\\Contoh_Surat.pdf', 'uploads\\Contoh_Surat.pdf', 'uploads\\Contoh_Surat.pdf', 'uploads\\Contoh_Surat.pdf', 'uploads\\Contoh_Surat.pdf', 'uploads\\Contoh_Surat.pdf', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(53, 27, 'uploads\\Contoh_Surat.pdf', 'uploads\\Contoh_Surat.pdf', 'uploads\\Contoh_Surat.pdf', 'uploads\\Contoh_Surat.pdf', 'uploads\\Contoh_Surat.pdf', 'uploads\\Contoh_Surat.pdf', 'uploads\\Contoh_Surat.pdf', 'uploads\\Contoh_Surat.pdf', 'uploads\\Contoh_Surat.pdf', 'uploads\\Contoh_Surat.pdf', 'uploads\\Contoh_Surat.pdf', 'uploads\\Contoh_Surat.pdf', 'uploads\\Contoh_Surat.pdf', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(54, 28, 'uploads\\Contoh_Surat.pdf', 'uploads\\Contoh_Surat.pdf', 'uploads\\Contoh_Surat.pdf', 'uploads\\Contoh_Surat.pdf', 'uploads\\Contoh_Surat.pdf', 'uploads\\Aulia_Halimatussyifa_Pas_foto.jpeg', 'uploads\\Contoh_Surat.pdf', 'uploads\\Contoh_Surat.pdf', 'uploads\\Contoh_Surat.pdf', 'uploads\\Contoh_Surat.pdf', 'uploads\\Contoh_Surat.pdf', 'uploads\\Contoh_Surat.pdf', 'uploads\\Contoh_Surat.pdf', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(56, 31, 'uploads\\File_Testing_Upload_Surat_Pengantar.pdf', 'uploads\\File_Testing_Upload_Proposal_Magang.pdf', 'uploads\\File_Testing_Upload_CV.pdf', 'uploads\\File_Testing_Surat_IDCARD.pdf', 'uploads\\File_Testing_Surat_Penerimaan_Magang.pdf', 'uploads\\Contoh_File_Pas_Foto.pdf', 'uploads\\File_Testing_Surat_Keterangan_Sehat.pdf', 'uploads\\File_Testing_KTM.pdf', 'uploads\\File_Testing_KTP.pdf', 'uploads\\File_Testing_Kartu_Keluarga.pdf', 'uploads\\File_Testing_SIM.pdf', 'uploads\\File_Testing_STNK.pdf', 'uploads\\File_Testing_SKCK.pdf', '2025-07-05 16:50:24', '2025-07-05 21:16:13'),
(57, 32, 'uploads\\File_Testing_Upload_Surat_Pengantar.pdf', 'uploads\\File_Testing_Upload_Proposal_Magang.pdf', 'uploads\\File_Testing_Upload_CV.pdf', 'uploads\\File_Testing_Surat_IDCARD.pdf', 'uploads\\File_Testing_Surat_Penerimaan_Magang.pdf', 'uploads\\Contoh_File_Pas_Foto.jpg', 'uploads\\File_Testing_Surat_Keterangan_Sehat.pdf', 'uploads\\File_Testing_KTM.pdf', 'uploads\\File_Testing_KTP.pdf', 'uploads\\File_Testing_Kartu_Keluarga.pdf', 'uploads\\File_Testing_SIM.pdf', 'uploads\\File_Testing_STNK.pdf', 'uploads\\File_Testing_SKCK.pdf', '2025-07-06 11:41:07', '2025-07-06 13:06:40'),
(59, 34, 'uploads\\File_Testing_Upload_Surat_Pengantar.pdf', 'uploads\\File_Testing_Upload_Proposal_Magang.pdf', 'uploads\\File_Testing_Upload_CV.pdf', 'uploads\\File_Testing_Surat_IDCARD.pdf', 'uploads\\File_Testing_Surat_Penerimaan_Magang.pdf', 'uploads\\Contoh_File_Pas_Foto.jpg', 'uploads\\File_Testing_Surat_Keterangan_Sehat.pdf', 'uploads\\File_Testing_KTM.pdf', 'uploads\\File_Testing_KTP.pdf', 'uploads\\File_Testing_Kartu_Keluarga.pdf', 'uploads\\File_Testing_SIM.pdf', 'uploads\\File_Testing_STNK.pdf', 'uploads\\File_Testing_SKCK.pdf', '2025-07-06 23:32:07', '2025-07-06 23:57:42'),
(60, 35, 'uploads\\File_Testing_Upload_Surat_Pengantar.pdf', 'uploads\\File_Testing_Upload_Proposal_Magang.pdf', 'uploads\\File_Testing_Upload_CV.pdf', 'uploads\\File_Testing_Surat_IDCARD.pdf', 'uploads\\File_Testing_Surat_Penerimaan_Magang.pdf', 'uploads\\Contoh_File_Pas_Foto.jpg', 'uploads\\File_Testing_Surat_Keterangan_Sehat.pdf', 'uploads\\File_Testing_KTM.pdf', 'uploads\\File_Testing_KTP.pdf', 'uploads\\File_Testing_Kartu_Keluarga.pdf', 'uploads\\File_Testing_SIM.pdf', 'uploads\\File_Testing_STNK.pdf', 'uploads\\File_Testing_SKCK.pdf', '2025-07-07 01:27:32', '2025-07-07 01:36:42'),
(61, 36, 'uploads\\File_Testing_Upload_Proposal_Magang.pdf', 'uploads\\File_Testing_Upload_Proposal_Magang.pdf', 'uploads\\File_Testing_Upload_CV.pdf', 'uploads\\File_Testing_Surat_IDCARD.pdf', 'uploads\\File_Testing_Surat_Penerimaan_Magang.pdf', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-07-07 13:08:11', '2025-07-07 13:09:51'),
(62, 37, 'uploads\\File_Testing_Upload_Surat_Pengantar.pdf', 'uploads\\File_Testing_Upload_Proposal_Magang.pdf', 'uploads\\File_Testing_Upload_CV.pdf', 'uploads\\File_Testing_Surat_IDCARD.pdf', 'uploads\\File_Testing_Surat_Penerimaan_Magang.pdf', 'uploads\\Contoh_File_Pas_Foto.jpg', 'uploads\\File_Testing_Surat_Keterangan_Sehat.pdf', 'uploads\\File_Testing_KTM.pdf', 'uploads\\File_Testing_KTP.pdf', 'uploads\\File_Testing_Kartu_Keluarga.pdf', 'uploads\\File_Testing_SIM.pdf', 'uploads\\File_Testing_STNK.pdf', 'uploads\\File_Testing_SKCK.pdf', '2025-07-07 13:25:13', '2025-07-07 13:28:02');

-- --------------------------------------------------------

--
-- Struktur dari tabel `data_berkas_hc`
--

CREATE TABLE `data_berkas_hc` (
  `id` int(11) NOT NULL,
  `template_surat_pembuatan_idcard` varchar(255) DEFAULT NULL,
  `template_surat_penerimaan_prakerin` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `data_peserta`
--

CREATE TABLE `data_peserta` (
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `nohp` varchar(20) NOT NULL,
  `semester` int(11) NOT NULL,
  `asal_kampus` varchar(100) NOT NULL,
  `jenis_kelamin` varchar(50) NOT NULL,
  `jenjang_pendidikan` varchar(50) DEFAULT NULL,
  `tempat_lahir` varchar(100) NOT NULL,
  `tanggal_lahir` date DEFAULT NULL,
  `tanggal_dimulai` date NOT NULL,
  `tanggal_berakhir` date NOT NULL,
  `nama_pembimbing_lapangan` varchar(32) DEFAULT NULL,
  `nama_pembimbing` varchar(100) DEFAULT NULL,
  `nohp_pembimbing` varchar(20) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `pic_wawancara` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `data_peserta`
--

INSERT INTO `data_peserta` (`id`, `id_user`, `nama`, `nohp`, `semester`, `asal_kampus`, `jenis_kelamin`, `jenjang_pendidikan`, `tempat_lahir`, `tanggal_lahir`, `tanggal_dimulai`, `tanggal_berakhir`, `nama_pembimbing_lapangan`, `nama_pembimbing`, `nohp_pembimbing`, `created_at`, `updated_at`, `pic_wawancara`) VALUES
(3, 10, 'Peserta Z', '123123', 4, 'Universitas Dummy', 'Perempuan', 'S1', 'Bandung', '2002-07-07', '2025-01-07', '2025-01-24', NULL, 'Pembimbing AAA', '089274123123', '2025-07-05 16:50:24', '2025-07-07 10:32:28', NULL),
(4, 3, 'Peserta AA', '089878756', 7, 'Universitas Dummy', 'Laki-Laki', 'S1', 'Bandung', '2002-07-07', '2025-01-06', '2025-01-22', NULL, 'Pebimbing Dummy ABD', '08888881', '2025-07-05 16:50:24', '2025-07-05 16:50:24', NULL),
(5, 5, 'Peserta AB', '08123456705', 4, 'Universitas E', 'Perempuan', 'S1', 'Bandung', '2002-07-07', '2025-01-18', '2025-03-18', NULL, 'Pembimbing AB', '08134567895', '2025-07-05 16:50:24', '2025-07-05 16:50:24', NULL),
(6, 6, 'Peserta AC', '08123456706', 8, 'Universitas F', 'Laki-laki', 'S1', 'Jakarta', '2002-07-07', '2025-01-20', '2025-03-20', NULL, 'Pembimbing 6', '08134567896', '2025-07-05 16:50:24', '2025-07-05 16:50:24', NULL),
(7, 7, 'Peserta AD', '08123456707', 5, 'Universitas G', 'Perempuan', 'S1', 'Malang', '2002-07-07', '2025-01-25', '2025-03-25', NULL, 'Pembimbing 7', '08134567897', '2025-07-05 16:50:24', '2025-07-05 16:50:24', NULL),
(9, 9, 'Peserta AF', '08123456709', 6, 'Universitas I', 'Perempuan', 'S1', 'Jogja', '2002-09-09', '2025-01-30', '2025-03-30', NULL, 'Pembimbing 9', '08134567899', '2025-07-05 16:50:24', '2025-07-05 16:50:24', NULL),
(11, 11, 'Peserta AG', '08123456711', 5, 'Universitas K', 'Laki-laki', 'S1', 'Aceh', '2001-11-11', '2025-02-01', '2025-04-01', NULL, 'Pembimbing 11', '08134567911', '2025-07-05 16:50:24', '2025-07-05 16:50:24', NULL),
(12, 12, 'Peserta AH', '08123456712', 4, 'Universitas L', 'Perempuan', 'S1', 'Medan', '2000-12-12', '2025-02-05', '2025-04-05', NULL, 'Pembimbing 12', '08134567912', '2025-07-05 16:50:24', '2025-07-05 16:50:24', NULL),
(13, 13, 'Peserta AI', '08123456713', 7, 'Universitas M', 'Laki-laki', 'S1', 'Bali', '2001-03-13', '2025-02-10', '2025-04-10', NULL, 'Pembimbing 13', '08134567913', '2025-07-05 16:50:24', '2025-07-07 00:08:42', 'Toni'),
(14, 14, 'Peserta AJ', '08123456714', 6, 'Universitas N', 'Perempuan', 'D3', 'Makassar', '2002-04-14', '2025-02-12', '2025-04-12', 'Mickey', 'NAMA PEMBIMBING R', '08888881', '2025-07-05 16:50:24', '2025-12-12 22:55:58', NULL),
(15, 15, 'Peserta AK', '08123456715', 8, 'Universitas O', 'Laki-laki', 'D3', 'Palembang', '2000-05-15', '2025-02-15', '2025-04-15', NULL, 'Pembimbing 15', '08134567915', '2025-07-05 16:50:24', '2025-07-05 16:50:24', NULL),
(16, 16, 'Peserta AL', '08123456716', 4, 'Universitas P', 'Perempuan', 'D3', 'Surabaya', '2001-06-16', '2025-02-20', '2025-04-20', NULL, 'Pembimbing 16', '08134567916', '2025-07-05 16:50:24', '2025-07-05 16:50:24', NULL),
(17, 17, 'Peserta AM', '08123456717', 6, 'Universitas Q', 'Laki-laki', 'D3', 'Jakarta', '2002-07-17', '2025-02-22', '2025-04-22', NULL, 'Pembimbing 17', '08134567917', '2025-07-05 16:50:24', '2025-07-05 16:50:24', NULL),
(18, 18, 'Peserta AN', '08123456718', 5, 'Universitas R', 'Perempuan', 'D3', 'Bandung', '2000-08-18', '2025-02-25', '2025-04-25', NULL, 'Pembimbing 18', '08134567918', '2025-07-05 16:50:24', '2025-07-05 16:50:24', NULL),
(19, 19, 'Peserta AO', '08123456719', 4, 'Universitas S', 'Laki-laki', 'D3', 'Jogja', '2001-09-19', '2025-03-01', '2025-05-01', NULL, 'Pembimbing 19', '08134567919', '2025-07-05 16:50:24', '2025-07-05 16:50:24', NULL),
(20, 20, 'Peserta AP', '08123456720', 7, 'Universitas T', 'Perempuan', 'D3', 'Medan', '2002-10-20', '2025-03-05', '2025-05-05', NULL, 'Pembimbing 20', '08134567920', '2025-07-05 16:50:24', '2025-07-05 16:50:24', NULL),
(21, 21, 'Aulia Syifa', '082215155709', 7, 'Universitas Telkom', 'Perempuan', 'D3', 'Bandung', '2003-06-15', '2025-01-09', '2025-01-31', NULL, 'Pak Dudung', '0987664533', '2025-07-05 16:50:24', '2025-07-05 16:50:24', NULL),
(22, 22, 'Aulia Halima', '12135677987', 7, 'Telkom', 'Perempuan', 'S1', 'Bandung', '1995-05-10', '2025-01-08', '2025-01-30', NULL, 'Fandi Achmad', '08965343613', '2025-07-05 16:50:24', '2025-07-06 13:46:11', 'NAMA PIC WAWANCARA'),
(23, 23, 'Peserta R', '08987654321', 6, 'UNIVERSITAS R', 'Laki-Laki', 'S1', 'KOTA R', '2020-06-10', '2025-06-01', '2025-07-01', NULL, 'NAMA PEMBIMBING R', '08987654321', '2025-07-05 16:50:24', '2025-07-05 16:50:24', NULL),
(24, 25, 'Aulia Halima', '08976543214', 5, 'Universitas Telkom', 'Perempuan', 'S1', 'Bandung', '2003-06-17', '2025-06-01', '2025-08-31', NULL, 'Lorem ipsum', '0876543215', '2025-07-05 16:50:24', '2025-07-05 16:50:24', NULL),
(25, 27, 'Peserta S', '08987654321', 6, 'UNIVERSITAS S', 'Laki-Laki', 'S1', 'KOTA S', '1995-06-21', '2025-06-02', '2025-06-27', NULL, NULL, NULL, '2025-07-05 16:50:24', '2025-07-05 16:50:24', NULL),
(26, 29, 'Syifa Aulia', '0832187965', 7, 'Universitas Telkom', 'Perempuan', 'S1', 'Cirebon', '2003-05-05', '2025-06-09', '2025-07-25', NULL, 'Sri', '0876547897', '2025-07-05 16:50:24', '2025-07-05 16:50:24', NULL),
(27, 30, 'Halima Syifa', '0895436728', 8, 'Universitas Telkom', 'Perempuan', 'S1', 'Cirebon', '2025-06-03', '2025-06-04', '2025-06-30', NULL, 'Sri', '097754232653', '2025-07-05 16:50:24', '2025-07-05 16:50:24', NULL),
(28, 32, 'Aulia Syifa Halima', '0997654324', 7, 'Telkom', 'Perempuan', 'S1', 'CIREBON', '2005-07-06', '2025-07-01', '2025-07-31', NULL, 'Anton', '0876547897', '2025-07-05 16:50:24', '2025-07-05 16:50:24', NULL),
(31, 33, 'Bogota Jota', '089726481231', 7, 'Telkom University', 'Laki-Laki', 'S1', 'Liverpool', '2001-07-12', '2025-07-15', '2025-09-12', 'NAMA PEMBIMBING H', 'DOSEN H', '08871273812', '2025-07-05 16:50:24', '2025-07-05 16:50:24', NULL),
(32, 35, 'Denver R', '086448172412', 7, 'UNIVERSITAS KEIST', 'Laki-Laki', 'S1', 'MEDAN', '2002-08-17', '2025-08-11', '2025-09-06', 'NAMA PL D', 'NAMA PK D', '08972371241', '2025-07-06 11:41:07', '2025-07-06 13:03:54', NULL),
(34, 37, 'Moscow', '089726412345', 7, 'NUS', 'Perempuan', 'S1', 'Moscow', '2010-06-06', '2025-08-06', '2025-10-16', 'PEMBIMBING MOSCOW', 'MOSCOVA', '0898123912', '2025-07-06 23:32:07', '2025-07-07 00:03:05', 'DREYKOV'),
(35, 40, 'canberra', '08971237123', 7, 'University of Melbourne', 'Laki-Laki', 'S1', 'Sydney', '2012-12-12', '2025-09-01', '2025-10-01', 'Mickey', 'DONALD', '0897274124', '2025-07-07 01:27:32', '2025-07-07 01:36:42', NULL),
(36, 41, 'Alaysa Nur', '08762341546', 7, 'Telkom', 'Perempuan', 'S1', 'Jakarta', '2008-01-07', '2025-07-14', '2025-08-25', 'Priyo', NULL, NULL, '2025-07-07 13:08:10', '2025-07-07 13:09:51', NULL),
(37, 42, 'Azzahra', '0876543243', 7, 'Telkom', 'Perempuan', 'S1', 'Jakarta', '2025-07-07', '2025-07-14', '2025-08-26', 'Priyo', 'Anton', '08765425163', '2025-07-07 13:25:13', '2025-07-07 13:30:32', 'Priyo');

-- --------------------------------------------------------

--
-- Struktur dari tabel `logbook`
--

CREATE TABLE `logbook` (
  `id` int(11) NOT NULL,
  `id_peserta` int(11) NOT NULL,
  `minggu_ke_logbook` int(11) DEFAULT NULL,
  `tanggal_logbook` date NOT NULL,
  `tanggal_sampai` date DEFAULT NULL,
  `catatan` text DEFAULT NULL,
  `file_logbook` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `logbook`
--

INSERT INTO `logbook` (`id`, `id_peserta`, `minggu_ke_logbook`, `tanggal_logbook`, `tanggal_sampai`, `catatan`, `file_logbook`, `created_at`, `updated_at`) VALUES
(1, 23, 1, '2025-05-20', '2025-05-23', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'uploads/contoh_logbook.pdf', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(4, 23, 2, '2025-05-26', '2025-05-30', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'uploads/contoh_logbook.pdf', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(6, 23, 3, '2025-06-02', '2025-06-06', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'uploads/contoh_logbook.pdf', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(8, 23, 4, '2025-06-09', '2025-06-13', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'uploads/template_logbook.pdf', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(9, 24, 1, '2025-05-05', '2025-05-09', 'Mencatat rapat', 'uploads/Laporan_Peserta_Prakerin_3.pdf', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(10, 26, 1, '2025-06-16', '2025-06-20', 'Mencatat laporan', 'uploads/Contoh_Surat.pdf', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(11, 26, 2, '2025-06-23', '2025-06-27', 'Membuat presentasi', 'uploads/Contoh_Surat.pdf', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(12, 26, 3, '2025-06-30', '2025-07-04', 'Presentasi laporan', 'uploads/Contoh_Surat.pdf', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(13, 27, 1, '2025-06-03', '2025-06-06', 'asfgdhjf', 'uploads/Contoh_Surat.pdf', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(14, 28, 1, '2025-07-01', '2025-07-07', 'asdfghjgfdsdfghhvc', 'uploads/Contoh_Surat.pdf', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(15, 31, 1, '2025-07-07', '2025-07-11', 'Test Logbook W-1', 'uploads/contoh_logbook.pdf', '2025-07-05 22:52:21', '2025-07-05 22:52:21'),
(16, 31, 2, '2025-07-14', '2025-07-18', 'Logbook W-2', 'uploads/contoh_logbook.pdf', '2025-07-05 22:53:09', '2025-07-05 22:53:09'),
(17, 31, 3, '2025-07-21', '2025-07-25', 'Logbook minggu ke - 3', 'uploads/contoh_logbook.pdf', '2025-07-05 22:57:43', '2025-07-05 22:57:43'),
(18, 31, 4, '2025-07-28', '2025-08-01', 'minggu terakhir logbook', 'uploads/contoh_logbook.pdf', '2025-07-06 00:29:30', '2025-07-06 00:29:30'),
(19, 28, 2, '2025-07-14', '2025-07-18', 'asddfghjkllmnvf', 'uploads/Contoh_Surat.pdf', '2025-07-06 00:59:26', '2025-07-06 00:59:26'),
(20, 28, 3, '2025-07-21', '2025-07-26', 'astdvdjacsg', 'uploads/Contoh_Surat.pdf', '2025-07-06 01:00:21', '2025-07-06 01:00:21'),
(21, 28, 4, '2025-07-27', '2025-07-31', 'mencatat', 'uploads/Contoh_Surat.pdf', '2025-07-06 01:00:48', '2025-07-06 01:00:48'),
(22, 34, 1, '2025-07-14', '2025-07-18', 'logbook catatan minggu ke 1:', 'uploads/contoh_logbook.pdf', '2025-07-07 00:09:36', '2025-07-07 00:09:36'),
(23, 34, 2, '2025-07-21', '2025-07-25', 'minggu ke 2', 'uploads/contoh_logbook.pdf', '2025-07-07 00:10:12', '2025-07-07 00:10:12'),
(24, 34, 3, '2025-07-28', '2025-08-01', 'minggu ke 3', 'uploads/contoh_logbook.pdf', '2025-07-07 00:10:28', '2025-07-07 00:10:28'),
(25, 34, 4, '2025-08-04', '2025-08-08', 'minggu terakhir', 'uploads/contoh_logbook.pdf', '2025-07-07 00:10:49', '2025-07-07 00:10:49');

-- --------------------------------------------------------

--
-- Struktur dari tabel `log_aktivitas`
--

CREATE TABLE `log_aktivitas` (
  `id` int(11) NOT NULL,
  `actor_id` int(11) NOT NULL,
  `target_user_id` int(11) DEFAULT NULL,
  `role_actor` varchar(20) NOT NULL,
  `aktivitas` varchar(100) NOT NULL,
  `deskripsi` text DEFAULT NULL,
  `timestamp` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `log_aktivitas`
--

INSERT INTO `log_aktivitas` (`id`, `actor_id`, `target_user_id`, `role_actor`, `aktivitas`, `deskripsi`, `timestamp`) VALUES
(3, 39, 39, 'Peserta', 'Registrasi Akun', 'User Test Log melakukan registrasi akun', '2025-07-06 22:44:36'),
(4, 37, 37, 'Peserta', 'Pendaftaran Magang', 'Moscow mendaftar program magang dengan asal kampus NUS', '2025-07-06 23:32:07'),
(5, 1, 37, 'HC Admin', 'Update Status Administrasi Pendaftaran', 'HC memperbarui status peserta Moscow (ID 34) menjadi: Kel. Berkas | Status Berkas: Sesuai', '2025-07-06 23:55:34'),
(6, 37, 37, 'Peserta', 'Upload Kelengkapan Berkas', 'Peserta mengunggah kelengkapan tambahan', '2025-07-06 23:57:42'),
(7, 1, 37, 'HC Admin', 'Update Status Kelengkapan Berkas Peserta', 'HC meninjau kelengkapan berkas milik peserta Moscow (ID 34) dengan hasil: Status Pendaftaran = \'Wawancara\', Status Berkas = \'Sesuai\'', '2025-07-06 23:58:47'),
(11, 2, 13, 'PAM Admin', 'Penjadwalan Wawancara', 'PAM menetapkan tanggal wawancara untuk peserta ID 13', '2025-07-07 00:07:54'),
(12, 2, 13, 'PAM Admin', 'Pembatalan Jadwal Wawancara', 'PAM membatalkan jadwal wawancara peserta ID 13', '2025-07-07 00:08:09'),
(13, 2, 13, 'PAM Admin', 'Penjadwalan Wawancara', 'PAM menetapkan tanggal wawancara untuk peserta ID 13', '2025-07-07 00:08:29'),
(14, 2, 13, 'PAM Admin', 'Wawancara Selesai', 'PAM menyelesaikan proses wawancara peserta ID 13', '2025-07-07 00:08:42'),
(15, 37, 37, 'Peserta', 'Tambah Logbook Mingguan', 'Menambahkan logbook minggu ke-1', '2025-07-07 00:09:36'),
(16, 37, 37, 'Peserta', 'Tambah Logbook Mingguan', 'Menambahkan logbook minggu ke-2', '2025-07-07 00:10:12'),
(17, 37, 37, 'Peserta', 'Tambah Logbook Mingguan', 'Menambahkan logbook minggu ke-3', '2025-07-07 00:10:28'),
(18, 37, 37, 'Peserta', 'Tambah Logbook Mingguan', 'Menambahkan logbook minggu ke-4', '2025-07-07 00:10:49'),
(19, 37, 37, 'Peserta', 'Upload Laporan Magang', 'Peserta mengunggah laporan akhir.', '2025-07-07 00:11:41'),
(20, 1, 37, 'HC Admin', 'Review Laporan Magang – Revisi', 'HC meminta revisi laporan peserta Moscow (ID 34).', '2025-07-07 00:18:16'),
(21, 37, 37, 'Peserta', 'Upload Revisi Laporan', 'Peserta mengunggah revisi laporan hasil evaluasi HC', '2025-07-07 00:18:55'),
(22, 1, 37, 'HC Admin', 'Review Laporan Magang – Diterima', 'HC menyatakan laporan peserta Moscow (ID 34) SUDAH SESUAI dan melanjutkan ke tahap presentasi.', '2025-07-07 00:19:36'),
(23, 2, 37, 'PAM Admin', 'Penjadwalan Presentasi', 'PAM menjadwalkan presentasi peserta ID 34', '2025-07-07 00:20:29'),
(24, 2, 37, 'PAM Admin', 'Jadwal Presentasi Dibatalkan', 'PAM membatalkan jadwal presentasi peserta ID 34', '2025-07-07 00:22:03'),
(25, 2, 37, 'PAM Admin', 'Penjadwalan Presentasi', 'PAM menjadwalkan presentasi peserta ID 34', '2025-07-07 00:22:34'),
(26, 2, 37, 'PAM Admin', 'Presentasi Selesai', 'PAM menyelesaikan presentasi peserta ID 34', '2025-07-07 00:22:42'),
(28, 1, 37, 'HC Admin', 'Upload Sertifikat Magang', 'HC mengunggah sertifikat magang untuk peserta ID 34', '2025-07-07 00:27:00'),
(29, 40, 40, 'Peserta', 'Registrasi Akun', 'User canberra melakukan registrasi akun', '2025-07-07 01:26:00'),
(30, 40, 40, 'Peserta', 'Pendaftaran Magang', 'canberra mendaftar program magang dengan asal kampus University of Melbourne', '2025-07-07 01:27:32'),
(31, 1, 10, 'HC Admin', 'Update Status Kelengkapan Berkas Peserta', 'HC meninjau kelengkapan berkas milik peserta AAA (ID 3) dengan hasil: Status Pendaftaran = \'Kel. Berkas\', Status Berkas = \'Sedang Diproses\'', '2025-07-07 01:34:44'),
(32, 1, 40, 'HC Admin', 'Update Status Administrasi Pendaftaran', 'HC memperbarui status peserta canberra (ID 35) menjadi: Kel. Berkas | Status Berkas: Sesuai', '2025-07-07 01:35:25'),
(33, 40, 40, 'Peserta', 'Upload Kelengkapan Berkas', 'Peserta mengunggah kelengkapan tambahan', '2025-07-07 01:36:42'),
(34, 1, 40, 'HC Admin', 'Update Status Kelengkapan Berkas Peserta', 'HC meninjau kelengkapan berkas milik peserta canberra (ID 35) dengan hasil: Status Pendaftaran = \'Kel. Berkas\', Status Berkas = \'Revisi\'', '2025-07-07 01:37:12'),
(35, 40, 40, 'Peserta', 'Upload Revisi Berkas', 'Peserta mengunggah revisi kelengkapan berkas sesuai catatan HC', '2025-07-07 01:37:47'),
(36, 1, 40, 'HC Admin', 'Update Status Kelengkapan Berkas Peserta', 'HC meninjau kelengkapan berkas milik peserta canberra (ID 35) dengan hasil: Status Pendaftaran = \'Wawancara\', Status Berkas = \'Sesuai\'', '2025-07-07 01:43:14'),
(37, 2, 9, 'PAM Admin', 'Penjadwalan Presentasi', 'PAM menjadwalkan presentasi peserta ID 9', '2025-07-07 07:33:41'),
(38, 2, 9, 'PAM Admin', 'Presentasi Selesai', 'PAM menyelesaikan presentasi peserta ID 9', '2025-07-07 07:33:54'),
(39, 1, 10, 'HC Admin', 'Update Status Kelengkapan Berkas Peserta', 'HC meninjau kelengkapan berkas milik peserta Peserta Z (ID 3) dengan hasil: Status Pendaftaran = \'Kel. Berkas\', Status Berkas = \'Revisi\'', '2025-07-07 10:33:55'),
(40, 41, 41, 'Peserta', 'Registrasi Akun', 'User Alaysa Nur melakukan registrasi akun', '2025-07-07 13:05:33'),
(41, 41, 41, 'Peserta', 'Pendaftaran Magang', 'Alaysa Nur mendaftar program magang dengan asal kampus Telkom', '2025-07-07 13:08:11'),
(42, 1, 41, 'HC Admin', 'Update Status Administrasi Pendaftaran', 'HC memperbarui status peserta Alaysa Nur (ID 36) menjadi: Kel. Berkas | Status Berkas: Sesuai', '2025-07-07 13:09:51'),
(43, 42, 42, 'Peserta', 'Registrasi Akun', 'User Azzahra melakukan registrasi akun', '2025-07-07 13:23:35'),
(44, 42, 42, 'Peserta', 'Pendaftaran Magang', 'Azzahra mendaftar program magang dengan asal kampus Telkom', '2025-07-07 13:25:13'),
(45, 1, 42, 'HC Admin', 'Update Status Administrasi Pendaftaran', 'HC memperbarui status peserta Azzahra (ID 37) menjadi: Kel. Berkas | Status Berkas: Sesuai', '2025-07-07 13:26:31'),
(46, 42, 42, 'Peserta', 'Upload Kelengkapan Berkas', 'Peserta mengunggah kelengkapan tambahan', '2025-07-07 13:28:02'),
(47, 1, 42, 'HC Admin', 'Update Status Kelengkapan Berkas Peserta', 'HC meninjau kelengkapan berkas milik peserta Azzahra (ID 37) dengan hasil: Status Pendaftaran = \'Wawancara\', Status Berkas = \'Sesuai\'', '2025-07-07 13:29:13'),
(48, 2, 37, 'PAM Admin', 'Penjadwalan Wawancara', 'PAM menetapkan tanggal wawancara untuk peserta ID 37', '2025-07-07 13:29:41'),
(49, 2, 37, 'PAM Admin', 'Wawancara Selesai', 'PAM menyelesaikan proses wawancara peserta ID 37', '2025-07-07 13:30:32'),
(50, 2, 35, 'PAM Admin', 'Penjadwalan Wawancara', 'PAM menetapkan tanggal wawancara untuk peserta ID 35', '2025-07-10 23:06:04'),
(51, 43, 43, 'Peserta', 'Registrasi Akun', 'User newyork melakukan registrasi akun', '2025-07-16 17:22:28'),
(52, 1, 14, 'HC Admin', 'Update Status Administrasi Pendaftaran', 'HC memperbarui status peserta Peserta AJ (ID 14) menjadi: Kel. Berkas | Status Berkas: Sesuai', '2025-12-12 22:53:20'),
(53, 14, 14, 'Peserta', 'Upload Kelengkapan Berkas', 'Peserta mengunggah kelengkapan tambahan', '2025-12-12 22:55:58');

-- --------------------------------------------------------

--
-- Struktur dari tabel `sertifikatmagang`
--

CREATE TABLE `sertifikatmagang` (
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `laporan_magang` varchar(255) DEFAULT NULL,
  `surat_orisinalitas` varchar(255) DEFAULT NULL,
  `status_laporan_magang` varchar(50) DEFAULT NULL,
  `catatan_revisi_laporan` text DEFAULT NULL,
  `judul_laporan_magang` varchar(255) DEFAULT NULL,
  `presentasi_magang` varchar(255) DEFAULT NULL,
  `tanggal_presentasi` date DEFAULT NULL,
  `waktu_presentasi` time DEFAULT NULL,
  `sertifikat_magang` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `pic_presentasi` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `sertifikatmagang`
--

INSERT INTO `sertifikatmagang` (`id`, `id_user`, `laporan_magang`, `surat_orisinalitas`, `status_laporan_magang`, `catatan_revisi_laporan`, `judul_laporan_magang`, `presentasi_magang`, `tanggal_presentasi`, `waktu_presentasi`, `sertifikat_magang`, `created_at`, `updated_at`, `pic_presentasi`) VALUES
(1, 23, 'uploads/contoh_logbook.pdf', 'uploads/File_Testing_Template_Surat__Orisinalitas.pdf', NULL, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 'JUDUL LAPORAN ', 'uploads/TEMPLATE_PRESENTASI.pdf', '2025-05-26', '15:25:00', 'uploads/CONTOH_SERTIFIKAT.pdf', '2025-07-05 16:50:24', '2025-07-10 23:19:09', NULL),
(2, 6, 'uploads/contoh_logbook.pdf', 'uploads/File_Testing_Template_Surat__Orisinalitas.pdf', 'Tentukan Tanggal Presentasi', '', 'JUDUL LAPORAN ', 'uploads/TEMPLATE_PRESENTASI.pdf', NULL, NULL, NULL, '2025-07-05 16:50:24', '2025-07-05 16:50:24', NULL),
(3, 29, 'uploads/Contoh_Surat.pdf', 'uploads/Contoh_Surat.pdf', 'Sertifikat Tercetak', '', NULL, NULL, '2025-07-09', '13:15:00', 'uploads/Contoh_Surat.pdf', '2025-07-05 16:50:24', '2025-07-05 16:50:24', NULL),
(4, 30, 'uploads/Contoh_Surat.pdf', 'uploads/Contoh_Surat.pdf', 'Sertifikat Tercetak', 'asddff', NULL, NULL, '2025-06-03', '13:04:00', 'uploads/Contoh_Surat.pdf', '2025-07-05 16:50:24', '2025-07-05 16:50:24', NULL),
(5, 9, 'uploads/FILE_TESTING_LAPORAN_MAGANG.pdf', 'uploads/File_Testing_Template_Surat__Orisinalitas.pdf', 'Menunggu Sertifikat', '', NULL, NULL, '2025-07-07', '07:33:00', NULL, '2025-07-05 21:48:51', '2025-07-07 07:33:54', 'isi'),
(6, 33, 'uploads/Laporan_Peserta_Prakerin_3.pdf', 'uploads/File_Testing_Template_Surat__Orisinalitas.pdf', 'Sertifikat Tercetak', 'revisi dulu yaa', NULL, 'uploads/TEMPLATE_PRESENTASI.pdf', '2025-07-17', '06:42:00', 'uploads/CONTOH_SERTIFIKAT.pdf', '2025-07-06 00:29:54', '2025-07-06 08:25:36', NULL),
(7, 32, 'uploads/Contoh_Surat.pdf', 'uploads/Contoh_Surat.pdf', 'Menunggu Sertifikat', '', NULL, 'uploads/Contoh_Surat.pdf', '2025-07-29', '09:00:00', NULL, '2025-07-06 01:01:30', '2025-07-06 14:18:58', 'NAMA PIC PRESENTASI'),
(8, 37, 'uploads/file_laporan_revisi_dari_HC.pdf', 'uploads/File_Testing_Template_Surat__Orisinalitas.pdf', 'Sertifikat Tercetak', 'revisi laporan', NULL, 'uploads/TEMPLATE_PRESENTASI.pdf', '2025-09-01', '07:30:00', 'uploads/CONTOH_SERTIFIKAT.pdf', '2025-07-07 00:11:41', '2025-07-07 00:27:00', 'Jennah');

-- --------------------------------------------------------

--
-- Struktur dari tabel `status_pendaftaran`
--

CREATE TABLE `status_pendaftaran` (
  `id` int(11) NOT NULL,
  `id_peserta` int(11) NOT NULL,
  `status_daftar` varchar(50) NOT NULL,
  `nama_divisi` varchar(50) DEFAULT NULL,
  `status_berkas` varchar(50) DEFAULT NULL,
  `catatan` text DEFAULT NULL,
  `tanggal_wawancara` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `revisi_berkas` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `status_pendaftaran`
--

INSERT INTO `status_pendaftaran` (`id`, `id_peserta`, `status_daftar`, `nama_divisi`, `status_berkas`, `catatan`, `tanggal_wawancara`, `revisi_berkas`, `created_at`, `updated_at`) VALUES
(3, 3, 'Kel. Berkas', 'Kendaraan Khusus', 'Revisi', 'STNK revisi', '2025-07-07 03:33:54', '[\"STNK\"]', '2025-07-05 16:50:24', '2025-07-07 10:33:54'),
(4, 4, 'Ditolak', NULL, 'Tidak Sesuai', NULL, '2025-05-09 18:15:31', NULL, '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(42, 5, 'Ditolak', NULL, 'Tidak Sesuai', 'Berkas kurang lengkap.', '2025-07-07 03:40:13', NULL, '2025-07-05 16:50:24', '2025-07-07 10:40:13'),
(43, 6, 'Diterima', 'Divisi Alat Berat', 'Sesuai', 'Menunggu hasil wawancara.', '2025-07-07 03:37:10', NULL, '2025-07-05 16:50:24', '2025-07-07 10:37:10'),
(44, 7, 'Kel. Berkas', 'Divisi Alat Berat', 'Revisi', 'Harus melakukan revisi.', '2025-07-07 03:37:13', '[\"Surat Keterangan Sehat\", \"Kartu Tanda Mahasiswa\"]', '2025-07-05 16:50:24', '2025-07-07 10:37:13'),
(46, 9, 'Diterima', 'Divisi Alat Berat', 'Sesuai', 'Berkas telah diperiksa dan lengkap.', '2025-07-07 03:37:17', NULL, '2025-07-05 16:50:24', '2025-07-07 10:37:17'),
(47, 11, 'Ditolak', NULL, 'Tidak Sesuai', 'Berkas foto kurang jelas.', '2025-07-07 03:39:56', NULL, '2025-07-05 16:50:24', '2025-07-07 10:39:56'),
(48, 12, 'Wawancara', 'Divisi Kendaraan Khusus', 'Menentukan Tanggal', NULL, '2025-07-07 03:37:25', '[]', '2025-07-05 16:50:24', '2025-07-07 10:37:25'),
(49, 13, 'Diterima', 'Divisi Kendaraan Khusus', 'Sesuai', 'Menunggu hasil wawancara.', '2025-07-07 03:37:27', NULL, '2025-07-05 16:50:24', '2025-07-07 10:37:27'),
(50, 14, 'Kel. Berkas', 'Divisi Kendaraan Khusus', 'Sedang Diproses', 'Menunggu persetujuan seleksi.', '2025-12-12 15:55:58', NULL, '2025-07-05 16:50:24', '2025-12-12 22:55:58'),
(51, 15, 'Diterima', 'Divisi Infrastruktur Perhubungan', 'Sesuai', 'Semua berkas sudah sesuai.', '2025-07-07 03:37:39', NULL, '2025-07-05 16:50:24', '2025-07-07 10:37:39'),
(52, 16, 'Ditolak', NULL, 'Tidak Sesuai', 'Proposal kurang lengkap.', '2025-07-07 03:40:00', NULL, '2025-07-05 16:50:24', '2025-07-07 10:40:00'),
(53, 17, 'Kel. Berkas', 'Divisi Infrastruktur Perhubungan', 'Revisi', 'Revisi pada CV diperlukan.', '2025-07-07 03:37:44', NULL, '2025-07-05 16:50:24', '2025-07-07 10:37:44'),
(54, 18, 'Diterima', 'Divisi Infrastruktur Perhubungan', 'Sesuai', 'Menunggu jadwal wawancara.', '2025-07-07 03:37:47', NULL, '2025-07-05 16:50:24', '2025-07-07 10:37:47'),
(55, 19, 'Diterima', 'Divisi Manajerial Pengelolaan', 'Sesuai', 'Semua berkas telah memenuhi syarat.', '2025-07-07 03:37:53', NULL, '2025-07-05 16:50:24', '2025-07-07 10:37:53'),
(56, 20, 'Perlu Diseleksi', 'Divisi Manajerial Pengelolaan', 'Sedang Diproses', 'Dalam proses seleksi awal.', '2025-07-07 03:37:56', NULL, '2025-07-05 16:50:24', '2025-07-07 10:37:56'),
(57, 21, 'Diterima', 'Divisi Alat Berat', 'Sesuai', NULL, '2025-07-07 03:38:04', NULL, '2025-07-05 16:50:24', '2025-07-07 10:38:04'),
(58, 22, 'Diterima', 'Divisi Kendaraan Khusus', 'Sesuai', NULL, '2025-07-07 03:38:11', '[]', '2025-07-05 16:50:24', '2025-07-07 10:38:11'),
(59, 23, 'Diterima', 'Divisi Manajerial Pengelolaan', 'Sesuai', NULL, '2025-07-07 03:38:15', '[]', '2025-07-05 16:50:24', '2025-07-07 10:38:15'),
(60, 24, 'Diterima', 'Divisi Alat Berat', 'Sesuai', NULL, '2025-07-07 03:38:22', '[]', '2025-07-05 16:50:24', '2025-07-07 10:38:22'),
(61, 25, 'Kel. Berkas', 'Divisi Kendaraan Khusus', 'Menunggu Peserta', NULL, '2025-07-07 03:38:27', NULL, '2025-07-05 16:50:24', '2025-07-07 10:38:27'),
(62, 26, 'Diterima', 'Divisi Infrastruktur Perhubungan', 'Sesuai', NULL, '2025-07-07 03:38:34', '[]', '2025-07-05 16:50:24', '2025-07-07 10:38:34'),
(63, 27, 'Diterima', 'Divisi Manajerial Pengelolaan', 'Sesuai', NULL, '2025-07-07 03:38:36', '[]', '2025-07-05 16:50:24', '2025-07-07 10:38:36'),
(64, 28, 'Diterima', 'Divisi Alat Berat', 'Sesuai', NULL, '2025-07-07 03:38:42', '[]', '2025-07-05 16:50:24', '2025-07-07 10:38:42'),
(67, 31, 'Diterima', 'Divisi Kendaraan Khusus', 'Sesuai', NULL, '2025-07-07 03:38:47', '[]', '2025-07-05 16:50:24', '2025-07-07 10:38:47'),
(68, 32, 'Kel. Berkas', 'Divisi Kendaraan Khusus', 'Sedang Diproses', NULL, '2025-07-06 06:15:20', '[]', '2025-07-06 11:41:07', '2025-07-06 13:15:20'),
(70, 34, 'Diterima', 'Divisi Alat Berat', 'Sesuai', NULL, '2025-07-06 17:03:05', '[]', '2025-07-06 23:32:07', '2025-07-07 00:03:05'),
(71, 35, 'Wawancara', 'Divisi Alat Berat', 'Tanggal Sudah Ditentukan', NULL, '2025-07-10 16:06:00', '[]', '2025-07-07 01:27:32', '2025-07-10 23:06:04'),
(72, 36, 'Kel. Berkas', 'Divisi Kendaraan Khusus', 'Menunggu Peserta', NULL, '2025-07-07 06:09:51', NULL, '2025-07-07 13:08:11', '2025-07-07 13:09:51'),
(73, 37, 'Diterima', 'Divisi Kendaraan Khusus', 'Sesuai', NULL, '2025-07-07 06:30:32', '[]', '2025-07-07 13:25:13', '2025-07-07 13:30:32');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `roles` varchar(50) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `nohp` varchar(20) NOT NULL,
  `nik` varchar(20) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`id`, `email`, `password`, `roles`, `nama`, `nohp`, `nik`, `created_at`, `updated_at`) VALUES
(1, 'adminhc@gmail.com', '12345', 'HC Admin', 'HC Admin', '0', '1', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(2, 'adminpam@gmail.com', '12345', 'PAM Admin', 'PAM Admin', '0', '2', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(3, 'peserta@gmail.com', '12345', 'Peserta', 'Peserta A', '089878756', '3209123456789876', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(4, 'user4@mail.com', '12345', 'Peserta', 'Peserta B', '08123456704', '3209123456789875', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(5, 'user5@mail.com', '12345', 'Peserta', 'Peserta C', '08123456705', '3209123456789874', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(6, 'user6@mail.com', '12345', 'Peserta', 'Peserta D', '08123456706', '3209123456789873', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(7, 'user7@mail.com', '12345', 'Peserta', 'Peserta E', '08123456707', '3209123456789872', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(8, 'user8@mail.com', '12345', 'Peserta', 'Peserta F', '08123456708', '3209123456789871', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(9, 'user9@mail.com', '12345', 'Peserta', 'Peserta G', '08123456709', '3209123456789870', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(10, 'pesertaz@mail.com', '12345', 'Peserta', 'Peserta Z', '08123456708', '3209123456789866', '2025-07-05 16:50:24', '2025-07-07 10:33:06'),
(11, 'user11@mail.com', '12345', 'Peserta', 'Peserta H', '08123456711', '3209123456789856', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(12, 'user12@mail.com', '12345', 'Peserta', 'Peserta I', '08123456712', '3209123456789846', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(13, 'user13@mail.com', '12345', 'Peserta', 'Peserta J', '08123456713', '3209123456789836', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(14, 'user14@mail.com', '12345', 'Peserta', 'Peserta K', '08123456714', '3209123456789826', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(15, 'user15@mail.com', '12345', 'Peserta', 'Peserta L', '08123456715', '3209123456789816', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(16, 'user16@mail.com', '12345', 'Peserta', 'Peserta M', '08123456716', '3209123456789806', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(17, 'user17@mail.com', '12345', 'Peserta', 'Peserta N', '08123456717', '3209123456789776', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(18, 'user18@mail.com', '12345', 'Peserta', 'Peserta O', '08123456718', '3209123456789676', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(19, 'user19@mail.com', '12345', 'Peserta', 'Peserta P', '08123456719', '3209123456789576', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(20, 'user20@mail.com', '12345', 'Peserta', 'Peserta Q', '08123456720', '3209123456789476', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(21, 'auliasyifa@gmail.com', '1234', 'Peserta', 'Aulia Syifa', '082215155709', '3209123456789376', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(22, 'aulia5@gmail.com', '12345', 'Peserta', 'Aulia Halima', '12135677987', '3209123456789276', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(23, 'user21@mail.com', '12345', 'Peserta', 'Peserta R', '08987654321', '3209123456789176', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(25, 'aulia8@gmail.com', '12345678', 'Peserta', 'Aulia Halima', '08976543214', '3209123456789076', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(27, 'user22@mail.com', '12345678', 'Peserta', 'Peserta S', '08987654321', '3209123456788876', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(29, 'syifaaulia@gmail.com', '12345678', 'Peserta', 'Syifa Aulia', '0832187965', NULL, '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(30, 'halimasyifa@gmail.com', '12345678', 'Peserta', 'Halima Syifa', '0895436728', NULL, '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(32, 'aulia1@gmail.com', '12345678', 'Peserta', 'Aulia Syifa Halima', '0997654324', NULL, '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(33, 'bogotajota@gmail.com', 'Password123', 'Peserta', 'Bogota Jota', '089726481231', '3209358912348', '2025-07-05 16:50:24', '2025-07-05 16:50:24'),
(35, 'denver@gmail.com', 'Password1', 'Peserta', 'Denver R', '086448172412', '32091849102491', '2025-07-06 08:36:38', '2025-07-06 08:36:38'),
(37, 'moscow@gmail.com', 'Password123', 'Peserta', 'Moscow', '089726412345', '32098173948124', '2025-07-06 22:16:51', '2025-07-06 22:16:51'),
(39, 'testlog@gmail.com', 'Password1', 'Peserta', 'Test Log', '08912371231', '120319231023', '2025-07-06 22:44:36', '2025-07-06 22:44:36'),
(40, 'canbera@gmail.com', 'Password1', 'Peserta', 'canberra', '08971237123', '320901283123', '2025-07-07 01:26:00', '2025-07-07 01:26:00'),
(41, 'alaysanur@gmail.com', '12345678', 'Peserta', 'Alaysa Nur', '08762341546', '32098156253123', '2025-07-07 13:05:33', '2025-07-07 13:05:33'),
(42, 'azzahra@gmail.com', '12345678', 'Peserta', 'Azzahra', '0876543243', '3201234567896', '2025-07-07 13:23:35', '2025-07-07 13:23:35'),
(43, 'newyork@gmail.com', 'password123', 'Peserta', 'newyork', '08971237128', '32091927412', '2025-07-16 17:22:28', '2025-07-16 17:22:28');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `berkas_peserta`
--
ALTER TABLE `berkas_peserta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_peserta` (`id_peserta`);

--
-- Indeks untuk tabel `data_berkas_hc`
--
ALTER TABLE `data_berkas_hc`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `data_peserta`
--
ALTER TABLE `data_peserta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`);

--
-- Indeks untuk tabel `logbook`
--
ALTER TABLE `logbook`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_peserta` (`id_peserta`);

--
-- Indeks untuk tabel `log_aktivitas`
--
ALTER TABLE `log_aktivitas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `actor_id` (`actor_id`),
  ADD KEY `target_user_id` (`target_user_id`);

--
-- Indeks untuk tabel `sertifikatmagang`
--
ALTER TABLE `sertifikatmagang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`);

--
-- Indeks untuk tabel `status_pendaftaran`
--
ALTER TABLE `status_pendaftaran`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_peserta` (`id_peserta`);

--
-- Indeks untuk tabel `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `nik` (`nik`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `berkas_peserta`
--
ALTER TABLE `berkas_peserta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT untuk tabel `data_berkas_hc`
--
ALTER TABLE `data_berkas_hc`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `data_peserta`
--
ALTER TABLE `data_peserta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT untuk tabel `logbook`
--
ALTER TABLE `logbook`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT untuk tabel `log_aktivitas`
--
ALTER TABLE `log_aktivitas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT untuk tabel `sertifikatmagang`
--
ALTER TABLE `sertifikatmagang`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `status_pendaftaran`
--
ALTER TABLE `status_pendaftaran`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT untuk tabel `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `berkas_peserta`
--
ALTER TABLE `berkas_peserta`
  ADD CONSTRAINT `berkas_peserta_ibfk_1` FOREIGN KEY (`id_peserta`) REFERENCES `data_peserta` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `data_peserta`
--
ALTER TABLE `data_peserta`
  ADD CONSTRAINT `data_peserta_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `logbook`
--
ALTER TABLE `logbook`
  ADD CONSTRAINT `logbook_ibfk_1` FOREIGN KEY (`id_peserta`) REFERENCES `data_peserta` (`id`);

--
-- Ketidakleluasaan untuk tabel `log_aktivitas`
--
ALTER TABLE `log_aktivitas`
  ADD CONSTRAINT `log_aktivitas_ibfk_1` FOREIGN KEY (`actor_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `log_aktivitas_ibfk_2` FOREIGN KEY (`target_user_id`) REFERENCES `user` (`id`);

--
-- Ketidakleluasaan untuk tabel `sertifikatmagang`
--
ALTER TABLE `sertifikatmagang`
  ADD CONSTRAINT `sertifikatmagang_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`);

--
-- Ketidakleluasaan untuk tabel `status_pendaftaran`
--
ALTER TABLE `status_pendaftaran`
  ADD CONSTRAINT `status_pendaftaran_ibfk_1` FOREIGN KEY (`id_peserta`) REFERENCES `data_peserta` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
