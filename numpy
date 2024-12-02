import numpy as np
import mysql.connector

# Koneksi ke database MySQL
db_connection = mysql.connector.connect(
    host="localhost",
    user="root",          # Sesuaikan dengan username MySQL Anda
    password="12345678",          # Sesuaikan dengan password MySQL Anda
    database="numpy"
)

cursor = db_connection.cursor()

# Ambil data dari tabel
cursor.execute("SELECT value FROM numbers")
rows = cursor.fetchall()

# Konversi data ke array NumPy dan ubah tipe data menjadi float
data = np.array([float(row[0]) for row in rows])

if data.size == 0:
    print("Tidak ada data di database.")
else:
    # Operasi Matematika dan Statistik
    print("Data dari Database:", data)
    print("Mean (Rata-rata):", np.mean(data))
    print("Median:", np.median(data))
    print("Standard Deviation (Standar Deviasi):", np.std(data))
    print("Max Value:", np.max(data))
    print("Min Value:", np.min(data))

# Menambahkan data baru ke database
new_value = float(input("Masukkan angka baru: "))
cursor.execute("INSERT INTO numbers (value) VALUES (%s)", (new_value,))
db_connection.commit()
print("Data baru berhasil ditambahkan!")

# Tutup koneksi database
cursor.close()
db_connection.close()
