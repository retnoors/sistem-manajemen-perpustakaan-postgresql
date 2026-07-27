# sistem-manajemen-perpustakaan-postgresql
Perancangan Database RDBMS Sistem Manajemen Perpustakaan Menggunakan PostgreSQL.

---

## Fitur Utama Database

* **Custom Schema Isolation:** Seluruh objek database diisolasi di dalam skema khusus (`production`) untuk menjaga struktur basis data tetap teratur.
* **Automated Data Security (`pgcrypto`):** Menggunakan ekstensi `pgcrypto` dan *Trigger Function* (`fnc_add_cred_login`) untuk mengenkripsi *password* pengguna secara otomatis menggunakan algoritma **Blowfish** saat data dimasukkan.
* **Automated Business Logic:** Penerapan *Triggers* dan *Functions* untuk menangani validasi dan otomatisasi alur transaksi secara real-time pada database.
* **Data Integrity & Normalization:** Penerapan *Primary Key*, *Foreign Key*, dan *Constraints* yang ketat guna menjamin konsistensi data transaksi perpustakaan.

---

## Struktur Repositori

```text
.
├── 01_schema.sql              # Script DDL (CREATE SCHEMA, Tables, PK/FK, Constraints)
├── 02_functions_triggers.sql   # Script Trigger Functions (pgcrypto & logika bisnis)
├── 03_sample_data.sql         # Script DML (Data dummy/sampel untuk pengujian)
├── erd_diagram.png            # Diagram Visual ERD (Entity Relationship Diagram)
└── README.md                 # Dokumentasi utama proyek
