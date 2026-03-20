import 'package:dio/dio.dart';
import '../models/mahasiswa_model.dart';

class MahasiswaRepository {
  final Dio _dio = Dio();

  Future<List<MahasiswaModel>> getMahasiswaList() async {
    try {
      final response = await _dio.get('https://jsonplaceholder.typicode.com/comments');
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => MahasiswaModel.fromJson(json)).toList();
      } else {
        throw Exception('Gagal memuat data mahasiswa: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Gagal memuat data mahasiswa: $e');
    }
  }
}