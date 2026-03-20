import 'dart:io';

void main() {
  List<String> datalist = [];
  print('Data list kosong: $datalist'); 

  int count = 0;
  
  while (count <= 0) {
    stdout.write('Masukkan jumlah list: ');
    String? input = stdin.readLineSync(); 
    
    try { 
      count = int.parse(input!);
      if (count <= 0) { 
        print('Masukkan angka lebih dari 0'); 
      }
    } catch (e) { 
      print('Input tidak valid! Masukkan angka yang benar.');
    }
  }

  for (int i = 0; i < count; i++) { 
    stdout.write('data ke-${i + 1}: '); 
    String? x = stdin.readLineSync(); 
    if (x != null) {
      datalist.add(x); 
    }
  }

  print('Data List: ');
  print(datalist); 
}