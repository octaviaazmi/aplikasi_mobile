import 'package:dio/dio.dart';
import '../models/dosen_model.dart';

class DosenRepository {
  // Bikin alat penarik data pakai Dio
  final Dio _dio = Dio();

  /// Mendapatkan daftar dosen
  Future<List<DosenModel>> getDosenList() async {
    try {
      // Dio otomatis mengurus header dan format JSON, jadi lebih simpel!
      final response = await _dio.get('https://jsonplaceholder.typicode.com/users');
      
      if (response.statusCode == 200) {
        // Dio otomatis mengubah response body jadi format List/Map, tidak perlu jsonDecode lagi
        final List<dynamic> data = response.data;
        print(data); // Debug: Tampilkan data di console
        return data.map((json) => DosenModel.fromJson(json)).toList();
      } else {
        throw Exception('Gagal memuat data dosen: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Gagal memuat data dosen: $e');
    }
  }
}