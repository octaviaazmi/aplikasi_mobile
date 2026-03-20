import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/dashboard_model.dart';
import '../../data/repositories/dashboard_repository.dart';

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  return DashboardRepository();
});

/// Menggunakan FutureProvider.autoDispose untuk selalu fetch data terbaru
final dashboardDataProvider = FutureProvider.autoDispose<DashboardData>((ref, {async}) async {
  final repository = ref.watch(dashboardRepositoryProvider);
  return repository.getDashboardData();
});

class DashboardNotifier extends StateNotifier<AsyncValue<DashboardData>> {
  final DashboardRepository _repository;

  DashboardNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadDashboard();
  }

  Future<void> loadDashboard() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.getDashboardData();
      state = AsyncValue.data(data);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.refreshDashboard();
      state = AsyncValue.data(data);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  void updateUserName(String newName) {
    state.whenData((data) {
      state = AsyncValue.data(data.copyWith(userName: newName));
    });
  }
}

/// Dashboard Notifier Provider dengan autoDispose
final dashboardNotifierProvider = StateNotifierProvider.autoDispose<DashboardNotifier, AsyncValue<DashboardData>>((ref) {
  final repository = ref.watch(dashboardRepositoryProvider);
  return DashboardNotifier(repository);
});

final selectedStatIndexProvider = StateProvider<int>((ref) => 0);
final themeModeProvider = StateProvider<bool>((ref) => false);