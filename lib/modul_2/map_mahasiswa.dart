import 'dart:io';

void main() {
  print('INPUT DATA MAHASISWA'); 
  stdout.write('Masukkan NIM: '); 
  String nim = stdin.readLineSync()!;
  stdout.write('Masukkan Nama: ');
  String nama = stdin.readLineSync()!;
  stdout.write('Masukkan Jurusan: '); 
  String jurusan = stdin.readLineSync()!;
  stdout.write('Masukkan IPK: '); 
  String ipk = stdin.readLineSync()!;

  Map<String, String> mahasiswa = {
    'nim': nim,
    'nama': nama,
    'jurusan': jurusan,
    'ipk': ipk
  };
  print('Data Mahasiswa: $mahasiswa\n'); 

  print('INPUT MULTIPLE MAHASISWA'); 
  stdout.write('Masukkan jumlah mahasiswa: '); 
  int jumlah = int.parse(stdin.readLineSync()!);

  List<Map<String, String>> listMahasiswa = [];

  for (int i = 1; i <= jumlah; i++) {
    print('Mahasiswa ke-$i'); 
    stdout.write('Masukkan NIM: '); 
    String n = stdin.readLineSync()!;
    stdout.write('Masukkan Nama: '); 
    String nm = stdin.readLineSync()!;
    stdout.write('Masukkan Jurusan: '); 
    String j = stdin.readLineSync()!;
    stdout.write('Masukkan IPK: ');
    String i_pk = stdin.readLineSync()!;

    listMahasiswa.add({
      'nim': n,
      'nama': nm,
      'jurusan': j,
      'ipk': i_pk
    });
  }
  
  print('\n=== HASIL DATA MULTIPLE MAHASISWA ===');
  print(listMahasiswa);
}