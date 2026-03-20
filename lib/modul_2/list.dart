import 'dart:io';

void main() {
  List<String> names = ['Alfa', 'beta', 'Charlie'];
  print('Names: $names');

  names.add('Delta');
  print('Names setelah ditambahkan: $names');

  print('Elemen pertama: ${names[0]}');
  print('Elemen kedua: ${names[1]}');

  names[1] = 'Bravo';
  print('Names setelah diubah: $names');

  names.remove('Charlie');
  print('Names setelah dihapus: $names');

  print('Jumlah data: ${names.length}');

  print('Menampilkan setiap elemen:');
  for (String name in names) {
    print(name);
  }
}