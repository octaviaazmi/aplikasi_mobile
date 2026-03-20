import 'dart:io';

void main() {
  // Data awal
  List<String> datalist = ['a', 'b', 'c', 'd', 'e'];
  print('Data saat ini: $datalist');

  // 1. Tampil berdasarkan index tertentu
  stdout.write('\nMasukkan index yang ingin ditampilkan (0-4): ');
  int indexTampil = int.parse(stdin.readLineSync()!);
  print('Data pada index $indexTampil adalah: ${datalist[indexTampil]}');

  // 2. Ubah berdasarkan index tertentu
  stdout.write('\nMasukkan index yang ingin diubah: ');
  int indexUbah = int.parse(stdin.readLineSync()!);
  stdout.write('Masukkan data baru: ');
  String dataBaru = stdin.readLineSync()!;
  datalist[indexUbah] = dataBaru;
  print('Berhasil diubah! Data saat ini: $datalist');

  // 3. Hapus berdasarkan index tertentu
  stdout.write('\nMasukkan index yang ingin dihapus: ');
  int indexHapus = int.parse(stdin.readLineSync()!);
  datalist.removeAt(indexHapus); // removeAt digunakan untuk menghapus berdasarkan urutan/index
  print('Berhasil dihapus! Data saat ini: $datalist');

  // 4. Tampilkan hasil akhir
  print('\n=== SEMUA DATA ===');
  for (int i = 0; i < datalist.length; i++) {
    print('Index $i: ${datalist[i]}');
  }
}