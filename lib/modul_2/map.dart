import 'dart:io'; 

void main() { 
  Map<String, String> data = { 
    'Anang': '081234567890', 
    'Arman': '082345678901', 
    'Doni': '083456789012', 
  };
  print('data awal: $data'); 

  data['Rio'] = '084567890123'; 
  print('data setelah ditambahkan: $data'); 

  print('Nomor Anang: ${data['Anang']}'); 
}