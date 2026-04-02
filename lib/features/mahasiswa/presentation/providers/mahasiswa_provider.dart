import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../data/models/mahasiswa_model.dart';
import '../../data/repositories/mahasiswa_repository.dart';

final mahasiswaRepoProvider = Provider<MahasiswaRepository>((ref) {
  return MahasiswaRepository();
});

// Panggil alat Local Storage
final mahasiswaStorageProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});

// Provider untuk membaca data mahasiswa yang tersimpan
final savedMahasiswaProvider = FutureProvider<List<Map<String, String>>>((ref) async {
  final storage = ref.watch(mahasiswaStorageProvider);
  return storage.getSavedMahasiswa();
});

class MahasiswaNotifier extends StateNotifier<AsyncValue<List<MahasiswaModel>>> {
  final MahasiswaRepository _repository;
  final LocalStorageService _storage;

  MahasiswaNotifier(this._repository, this._storage) : super(const AsyncValue.loading()) {
    loadData();
  }

  Future<void> loadData() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.getMahasiswaList();
      state = AsyncValue.data(data);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async => await loadData();

  // --- Fungsi Tambahan Local Storage ---
  Future<void> saveSelectedMahasiswa(MahasiswaModel mhs) async {
    await _storage.addMahasiswaToSavedList(
      id: mhs.id.toString(),
      name: mhs.name,
    );
  }

  Future<void> removeSavedMahasiswa(String id) async {
    await _storage.removeSavedMahasiswa(id);
  }

  Future<void> clearSavedMahasiswa() async {
    await _storage.clearSavedMahasiswa();
  }
}

final mahasiswaNotifierProvider = StateNotifierProvider.autoDispose<MahasiswaNotifier, AsyncValue<List<MahasiswaModel>>>((ref) {
  final repository = ref.watch(mahasiswaRepoProvider);
  final storage = ref.watch(mahasiswaStorageProvider);
  return MahasiswaNotifier(repository, storage);
});