CREATE TABLE `Pelanggan` (
  `NIK` varchar(255) PRIMARY KEY,
  `Nama` varchar(255),
  `Alamat` varchar(255),
  `Nomor_Telepon` varchar(255),
  `Email` varchar(255),
  `Tanggal_Lahir` date,
  `Jenis_Kelamin` varchar(255),
  `Status_Keanggotaan` varchar(255),
  `Total_Penyewaan` int
);

CREATE TABLE `Kendaraan` (
  `Nomor_Polisi` varchar(255) PRIMARY KEY,
  `Nomor_Identitas` varchar(255),
  `Warna` varchar(255),
  `Merek` varchar(255),
  `Kapasitas` int,
  `Transmisi` varchar(255),
  `Pola` varchar(255),
  `Keadaan` varchar(255),
  `Harga_Sewa` int,
  `Bahan_Bakar` varchar(255)
);

CREATE TABLE `Penyewaan` (
  `ID_Penyewaan` int PRIMARY KEY,
  `ID_Pelanggan` int,
  `ID_Kendaraan` varchar(255),
  `Tanggal_Mulai` date,
  `Tanggal_Akhir` date,
  `Kondisi_Sebelum` varchar(255),
  `Kondisi_Sesudah` varchar(255),
  `Status_Pengembalian` varchar(255)
);

CREATE TABLE `Pembayaran` (
  `ID_Pembayaran` int PRIMARY KEY,
  `Metode_Pembayaran` varchar(255),
  `Tanggal_Pembayaran` date,
  `Status_Pembayaran` varchar(255)
);

CREATE TABLE `Pegawai` (
  `NIK` varchar(255) PRIMARY KEY,
  `Nama` varchar(255),
  `Alamat` varchar(255),
  `Nomor_Telepon` varchar(255),
  `Email` varchar(255),
  `Tanggal_Lahir` date,
  `Jenis_Kelamin` varchar(255),
  `Jabatan` varchar(255),
  `ID_Cabang` int,
  `ID_Pelacakan` int
);

CREATE TABLE `Cabang` (
  `ID_Cabang` int PRIMARY KEY,
  `Nama_Cabang` varchar(255),
  `Alamat` varchar(255),
  `Nomor_Telepon` varchar(255),
  `Jumlah_Pegawai` int
);

CREATE TABLE `Pelacakan_GPS` (
  `ID_Pelacakan` int PRIMARY KEY,
  `Garis_Lintang` varchar(255)
);

CREATE TABLE `Denda` (
  `ID_Denda` int PRIMARY KEY,
  `Jumlah_Denda` int,
  `Status_Pembayaran` varchar(255)
);

ALTER TABLE `Penyewaan` ADD FOREIGN KEY (`ID_Pelanggan`) REFERENCES `Pelanggan` (`NIK`);

ALTER TABLE `Penyewaan` ADD FOREIGN KEY (`ID_Kendaraan`) REFERENCES `Kendaraan` (`Nomor_Polisi`);

ALTER TABLE `Pembayaran` ADD FOREIGN KEY (`ID_Pembayaran`) REFERENCES `Penyewaan` (`ID_Penyewaan`);

ALTER TABLE `Pegawai` ADD FOREIGN KEY (`ID_Cabang`) REFERENCES `Cabang` (`ID_Cabang`);

ALTER TABLE `Pegawai` ADD FOREIGN KEY (`ID_Pelacakan`) REFERENCES `Pelacakan_GPS` (`ID_Pelacakan`);

ALTER TABLE `Denda` ADD FOREIGN KEY (`ID_Denda`) REFERENCES `Pembayaran` (`ID_Pembayaran`);
