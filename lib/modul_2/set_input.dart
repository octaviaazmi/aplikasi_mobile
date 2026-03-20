import 'dart:io';

void main() {
  Set<String> data = {'a', 'b', 'c', 'd', 'e'};

  print('=== SEMUA DATA ===');
  int nomor = 1;
  for (String item in data) {
    print('$nomor. $item');
    nomor++;
  }
  
  print('Total data: ${data.length}');

  stdout.write('Masukkan data baru: ');
  String dataBaru = stdin.readLineSync()!;
  data.add(dataBaru);
  print('Data "$dataBaru" berhasil ditambahkan!');

  stdout.write('Masukkan data yang ingin dihapus: ');
  String dataHapus = stdin.readLineSync()!;
  data.remove(dataHapus);
  print('Data "$dataHapus" berhasil dihapus!');

  stdout.write('Masukkan data yang ingin dicek: ');
  String dataCek = stdin.readLineSync()!;
  
  if (data.contains(dataCek)) {
    print('Data "$dataCek" ada di Set!');
  } else {
    print('Data "$dataCek" tidak ada di Set!');
  }
}