import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../models/dosen_model.dart';

class DosenRepository {
  final DioClient _dioClient;

  // Sambungkan dengan DioClient
  DosenRepository({DioClient? dioClient}) : _dioClient = dioClient ?? DioClient();

  /// get data daftar dosen
  Future<List<DosenModel>> getDosenList() async {
    try {
      // Tinggal panggil '/users' karena baseUrl-nya udah diatur di DioClient
      final Response response = await _dioClient.dio.get('/users');
      final List<dynamic> data = response.data;
      return data.map((json) => DosenModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception('Gagal memuat data dosen: ${e.response?.statusCode} ${e.message}');
    }
  }
}