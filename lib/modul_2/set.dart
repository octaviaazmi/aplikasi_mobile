import 'dart:io';

void main() {
  Set<String> burung = {'Merpati', 'Elang', 'Kakatua'};
  print('Burung: $burung'); 

  // 1. Tambah data [cite: 103]
  burung.add('Jalak');
  print('Setelah ditambah Jalak: $burung');

  // 2. Tambah data duplicate [cite: 104]
  // Kita coba masukin 'Elang' lagi padahal udah ada
  burung.add('Elang'); 
  print('Setelah ditambah Elang lagi (duplikat): $burung');

  // 3. Hapus data [cite: 105]
  burung.remove('Merpati');
  print('Setelah Merpati dihapus: $burung');

  // 4. Cek data tertentu apakah ada [cite: 106]
  // Kita pakai fungsi .contains() untuk mengecek
  bool cekKakatua = burung.contains('Kakatua');
  print('Apakah Kakatua ada di Set? $cekKakatua');

  // 5. Hitung jumlah data [cite: 107]
  print('Jumlah data burung sekarang: ${burung.length}');
}