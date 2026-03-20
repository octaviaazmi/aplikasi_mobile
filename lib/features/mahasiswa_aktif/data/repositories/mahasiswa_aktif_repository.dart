import 'package:dio/dio.dart';
import '../models/mahasiswa_aktif_model.dart';

class MahasiswaAktifRepository {
  final Dio _dio = Dio();

  Future<List<MahasiswaAktifModel>> getMahasiswaAktifList() async {
    try {
      final response = await _dio.get('https://jsonplaceholder.typicode.com/posts');
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => MahasiswaAktifModel.fromJson(json)).toList();
      } else {
        throw Exception('Gagal memuat data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Gagal memuat data: $e');
    }
  }
}