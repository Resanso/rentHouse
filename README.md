Here’s the entire content structured in a **README.md** format:

````markdown
# MySQL Live Coding Test: Rental System

This document contains the MySQL schema, advanced queries, and examples for a rental system involving **Pelanggan (Customers)**, **Kendaraan (Vehicles)**, **Penyewaan (Rentals)**, and **Pembayaran (Payments)**. It includes **table creation**, **insert**, **select**, **update**, and **transaction** queries.

## 1. Table Creation with Foreign Keys

```sql
-- Table for Pelanggan (Customers)
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

-- Table for Kendaraan (Vehicles)
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

-- Table for Penyewaan (Rentals)
CREATE TABLE `Penyewaan` (
  `ID_Penyewaan` int AUTO_INCREMENT PRIMARY KEY,
  `ID_Pelanggan` varchar(255),
  `ID_Kendaraan` varchar(255),
  `Tanggal_Mulai` date,
  `Tanggal_Akhir` date,
  `Kondisi_Sebelum` varchar(255),
  `Kondisi_Sesudah` varchar(255),
  `Status_Pengembalian` varchar(255),
  FOREIGN KEY (`ID_Pelanggan`) REFERENCES `Pelanggan`(`NIK`),
  FOREIGN KEY (`ID_Kendaraan`) REFERENCES `Kendaraan`(`Nomor_Polisi`)
);

-- Table for Pembayaran (Payments)
CREATE TABLE `Pembayaran` (
  `ID_Pembayaran` int AUTO_INCREMENT PRIMARY KEY,
  `ID_Penyewaan` int,
  `Metode_Pembayaran` varchar(255),
  `Tanggal_Pembayaran` date,
  `Status_Pembayaran` varchar(255),
  FOREIGN KEY (`ID_Penyewaan`) REFERENCES `Penyewaan`(`ID_Penyewaan`)
);
````

## 2. Inserting Data

### 2.1 Inserting Multiple Customers into `Pelanggan`

```sql
INSERT INTO `Pelanggan` (`NIK`, `Nama`, `Alamat`, `Nomor_Telepon`, `Email`, `Tanggal_Lahir`, `Jenis_Kelamin`, `Status_Keanggotaan`, `Total_Penyewaan`)
VALUES
  ('1234567890', 'John Doe', 'Jl. Merdeka No. 1', '081234567890', 'john@example.com', '1990-01-01', 'Laki-laki', 'Aktif', 5),
  ('0987654321', 'Jane Smith', 'Jl. Raya No. 2', '082345678901', 'jane@example.com', '1985-06-15', 'Perempuan', 'Tidak Aktif', 3);
```

### 2.2 Inserting Multiple Vehicles into `Kendaraan`

```sql
INSERT INTO `Kendaraan` (`Nomor_Polisi`, `Nomor_Identitas`, `Warna`, `Merek`, `Kapasitas`, `Transmisi`, `Pola`, `Keadaan`, `Harga_Sewa`, `Bahan_Bakar`)
VALUES
  ('AB123CD', '12345', 'Merah', 'Toyota', 5, 'Manual', 'Sedan', 'Baik', 300000, 'Bensin'),
  ('EF456GH', '67890', 'Hitam', 'Honda', 4, 'Automatic', 'SUV', 'Rusak', 250000, 'Diesel');
```

### 2.3 Inserting a Rental Transaction into `Penyewaan`

```sql
INSERT INTO `Penyewaan` (`ID_Pelanggan`, `ID_Kendaraan`, `Tanggal_Mulai`, `Tanggal_Akhir`, `Kondisi_Sebelum`, `Kondisi_Sesudah`, `Status_Pengembalian`)
VALUES
  ('1234567890', 'AB123CD', '2025-05-01', '2025-05-07', 'Baik', 'Baik', 'Sudah Dikembalikan');
```

### 2.4 Inserting Payment Details into `Pembayaran`

```sql
INSERT INTO `Pembayaran` (`ID_Penyewaan`, `Metode_Pembayaran`, `Tanggal_Pembayaran`, `Status_Pembayaran`)
VALUES
  (1, 'Transfer', '2025-05-05', 'Lunas');
```

## 3. Advanced Select Queries with Joins

### 3.1 Joining `Pelanggan` and `Penyewaan`

```sql
SELECT p.`Nama`, p.`Nomor_Telepon`, s.`Tanggal_Mulai`, s.`Tanggal_Akhir`, s.`Kondisi_Sebelum`, s.`Kondisi_Sesudah`
FROM `Pelanggan` p
JOIN `Penyewaan` s ON p.`NIK` = s.`ID_Pelanggan`
WHERE s.`Status_Pengembalian` = 'Sudah Dikembalikan';
```

### 3.2 Joining `Penyewaan` and `Pembayaran`

```sql
SELECT p.`Nama`, k.`Merek`, s.`Tanggal_Mulai`, s.`Tanggal_Akhir`, s.`Kondisi_Sebelum`, s.`Kondisi_Sesudah`, pay.`Metode_Pembayaran`, pay.`Status_Pembayaran`
FROM `Penyewaan` s
JOIN `Pelanggan` p ON s.`ID_Pelanggan` = p.`NIK`
JOIN `Kendaraan` k ON s.`ID_Kendaraan` = k.`Nomor_Polisi`
JOIN `Pembayaran` pay ON s.`ID_Penyewaan` = pay.`ID_Penyewaan`;
```

### 3.3 Aggregated Queries for Total Rentals and Payments

```sql
SELECT p.`Nama`, COUNT(s.`ID_Penyewaan`) AS `Total_Penyewaan`, SUM(k.`Harga_Sewa`) AS `Total_Pembayaran`
FROM `Pelanggan` p
JOIN `Penyewaan` s ON p.`NIK` = s.`ID_Pelanggan`
JOIN `Kendaraan` k ON s.`ID_Kendaraan` = k.`Nomor_Polisi`
GROUP BY p.`NIK`;
```

### 3.4 Subqueries to Find Customers with More Than 3 Rentals

```sql
SELECT `Nama`
FROM `Pelanggan`
WHERE `NIK` IN (
  SELECT `ID_Pelanggan`
  FROM `Penyewaan`
  GROUP BY `ID_Pelanggan`
  HAVING COUNT(`ID_Penyewaan`) > 3
);
```

## 4. Update Queries with Conditions

### 4.1 Update Customer Status Based on Rental Count

```sql
UPDATE `Pelanggan`
SET `Status_Keanggotaan` = 'VIP'
WHERE `NIK` IN (
  SELECT `ID_Pelanggan`
  FROM `Penyewaan`
  GROUP BY `ID_Pelanggan`
  HAVING COUNT(`ID_Penyewaan`) > 5
);
```

## 5. Deleting Records with Foreign Key Constraints

### 5.1 Deleting a Customer and Related Rental Records

```sql
DELETE FROM `Pelanggan` WHERE `NIK` = '1234567890';
-- This will also delete all related entries in `Penyewaan` and `Pembayaran` due to the foreign key cascade (if set)
```

## 6. Handling Transactions for Consistency

```sql
START TRANSACTION;

-- Insert customer
INSERT INTO `Pelanggan` (`NIK`, `Nama`, `Alamat`, `Nomor_Telepon`, `Email`, `Tanggal_Lahir`, `Jenis_Kelamin`, `Status_Keanggotaan`, `Total_Penyewaan`)
VALUES ('1122334455', 'Alice Green', 'Jl. Mangga No. 1', '085678912345', 'alice@example.com', '1989-02-28', 'Perempuan', 'Aktif', 1);

-- Insert rental
INSERT INTO `Penyewaan` (`ID_Pelanggan`, `ID_Kendaraan`, `Tanggal_Mulai`, `Tanggal_Akhir`, `Kondisi_Sebelum`, `Kondisi_Sesudah`, `Status_Pengembalian`)
VALUES ('1122334455', 'AB123CD', '2025-05-10', '2025-05-20', 'Baik', 'Baik', 'Belum Dikembalikan');

-- Commit the transaction
COMMIT;
```

---

## Conclusion

This document contains advanced **MySQL queries** for the **rental system** including:

* **Creating tables** with foreign keys.
* **Inserting multiple records**.
* **Complex SELECT queries** with JOINs, aggregations, and subqueries.
* **Update queries** with conditions.
* **Handling foreign key constraints**.
* **Managing transactions** to ensure data consistency.

For additional help or more complex queries, feel free to ask!

```

This `README.md` provides a structured overview of the **MySQL queries** used for the rental system database. It covers all essential SQL operations, such as **table creation**, **inserts**, **updates**, **selects**, **joins**, and **transactions**, which are common tasks in a live coding test.
```
