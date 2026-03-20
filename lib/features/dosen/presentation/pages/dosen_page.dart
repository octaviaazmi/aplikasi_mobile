import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../providers/dosen_provider.dart';
import '../widgets/dosen_widget.dart';

class DosenPage extends ConsumerWidget {
  const DosenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dosenState = ref.watch(dosenNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Dosen'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Refresh',
            onPressed: () {
              ref.invalidate(dosenNotifierProvider);
            },
          ),
        ],
      ),
      body: dosenState.when(
        // State: Loading
        loading: () => const LoadingWidget(),
        
        // State: Error
        error: (error, stack) => CustomErrorWidget(
          message: 'Gagal memuat data dosen: ${error.toString()}',
          onRetry: () {
            ref.read(dosenNotifierProvider.notifier).refresh();
          },
        ),
        
        // State: Data
        data: (dosenList) {
          // Memanggil DosenListView yang ada di dosen_widget.dart
          return DosenListView(
            dosenList: dosenList,
            onRefresh: () {
              ref.invalidate(dosenNotifierProvider);
            },
            useModernCard: true, 
          );
        },
      ),
    );
  }
}