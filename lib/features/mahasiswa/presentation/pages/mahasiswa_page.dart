import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../providers/mahasiswa_provider.dart';

class MahasiswaPage extends ConsumerWidget {
  const MahasiswaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mahasiswaNotifierProvider);
    final savedMhs = ref.watch(savedMahasiswaProvider); // Watch data memori HP

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Data Mahasiswa'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => ref.invalidate(mahasiswaNotifierProvider),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- BAGIAN ATAS: Data dari Local Storage ---
          SavedMahasiswaSection(savedMhs: savedMhs, ref: ref),

          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text(
              'Daftar Mahasiswa (Dari API)',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),

          // --- BAGIAN BAWAH: Data dari Internet (API) ---
          Expanded(
            child: state.when(
              loading: () => const LoadingWidget(),
              error: (error, stack) => CustomErrorWidget(
                message: 'Gagal memuat data: $error',
                onRetry: () => ref.read(mahasiswaNotifierProvider.notifier).refresh(),
              ),
              data: (listData) {
                return RefreshIndicator(
                  onRefresh: () async => ref.invalidate(mahasiswaNotifierProvider),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: listData.length,
                    itemBuilder: (context, index) {
                      final mhs = listData[index];
                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.only(bottom: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(color: AppTheme.primaryColor.withOpacity(0.2), width: 1),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading: CircleAvatar(
                            backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                            child: Text(
                              mhs.name.isNotEmpty ? mhs.name.substring(0, 1).toUpperCase() : '?',
                              style: const TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold),
                            ),
                          ),
                          title: Text(mhs.name, maxLines: 1, overflow: TextOverflow.ellipsis),
                          subtitle: Text(mhs.email, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                          trailing: IconButton(
                            icon: const Icon(Icons.save, color: Colors.blue),
                            tooltip: 'Simpan Mahasiswa',
                            onPressed: () async {
                              // Eksekusi fungsi save ke Local Storage
                              await ref.read(mahasiswaNotifierProvider.notifier).saveSelectedMahasiswa(mhs);
                              ref.invalidate(savedMahasiswaProvider); // Refresh bagian atas
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('${mhs.name} berhasil disimpan!')),
                                );
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ========================================================
// WIDGET BANTUAN: Menampilkan List Mahasiswa Tersimpan
// ========================================================
class SavedMahasiswaSection extends StatelessWidget {
  final AsyncValue<List<Map<String, String>>> savedMhs;
  final WidgetRef ref;

  const SavedMahasiswaSection({super.key, required this.savedMhs, required this.ref});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.storage_rounded, size: 16),
              const SizedBox(width: 6),
              const Text('Tersimpan di Local Storage', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              const Spacer(),
              savedMhs.maybeWhen(
                data: (users) => users.isNotEmpty
                    ? TextButton.icon(
                        onPressed: () async {
                          await ref.read(mahasiswaNotifierProvider.notifier).clearSavedMahasiswa();
                          ref.invalidate(savedMahasiswaProvider);
                        },
                        icon: const Icon(Icons.delete_sweep_outlined, size: 14, color: Colors.red),
                        label: const Text('Hapus Semua', style: TextStyle(fontSize: 12, color: Colors.red)),
                      )
                    : const SizedBox.shrink(),
                orElse: () => const SizedBox.shrink(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          savedMhs.when(
            loading: () => const LinearProgressIndicator(),
            error: (err, stack) => const Text('Gagal membaca data', style: TextStyle(color: Colors.red)),
            data: (users) {
              if (users.isEmpty) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
                  child: const Text('Belum ada data mahasiswa yang disimpan.', style: TextStyle(fontSize: 12)),
                );
              }
              return Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: users.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return ListTile(
                      dense: true,
                      leading: const CircleAvatar(radius: 14, child: Icon(Icons.person, size: 16)),
                      title: Text(user['name'] ?? '-', maxLines: 1, overflow: TextOverflow.ellipsis),
                      subtitle: Text('ID: ${user['id']}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.close, size: 16, color: Colors.red),
                        onPressed: () async {
                          await ref.read(mahasiswaNotifierProvider.notifier).removeSavedMahasiswa(user['id'] ?? '');
                          ref.invalidate(savedMahasiswaProvider);
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}