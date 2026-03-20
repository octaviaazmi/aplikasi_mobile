import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../providers/mahasiswa_provider.dart';

class MahasiswaPage extends ConsumerWidget {
  const MahasiswaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mahasiswaState = ref.watch(mahasiswaNotifierProvider);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Data Mahasiswa (Comments API)'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => ref.read(mahasiswaNotifierProvider.notifier).refresh(),
          ),
        ],
      ),
      body: mahasiswaState.when(
        loading: () => const LoadingWidget(),
        error: (error, stack) => CustomErrorWidget(
          message: 'Gagal memuat data: $error',
          onRetry: () => ref.read(mahasiswaNotifierProvider.notifier).refresh(),
        ),
        data: (mahasiswaList) {
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(mahasiswaNotifierProvider),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: mahasiswaList.length,
              itemBuilder: (context, index) {
                final mhs = mahasiswaList[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: AppTheme.primaryColor.withOpacity(0.2), width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                              child: Text(
                                mhs.name.substring(0, 1).toUpperCase(),
                                style: const TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    mhs.name,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                    maxLines: 1, overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    mhs.email,
                                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Text('#${mhs.id}', style: TextStyle(color: Colors.grey[400], fontSize: 12)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          mhs.body,
                          style: TextStyle(color: Colors.grey[800], fontSize: 13),
                          maxLines: 2, overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}