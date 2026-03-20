import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../providers/profile_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileNotifierProvider);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: profileState.when(
        loading: () => const LoadingWidget(),
        error: (error, stack) => CustomErrorWidget(
          message: 'Gagal memuat profil: $error',
          onRetry: () => ref.read(profileNotifierProvider.notifier).refresh(),
        ),
        data: (profile) {
          return CustomScrollView(
            slivers: [
              // 1. Header dengan tombol Back transparan
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                backgroundColor: AppTheme.primaryColor,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: AppConstants.dashboardGradients[0], // Pakai gradasi ungu
                      ),
                    ),
                  ),
                ),
              ),
              
              // 2. Isi Profil yang melayang ke atas menimpa header
              SliverToBoxAdapter(
                child: Transform.translate(
                  offset: const Offset(0, -60), // Menarik konten ke atas
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      children: [
                        // Foto Profil Bulat dengan Border
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: AppTheme.primaryColor.withOpacity(0.2),
                            child: const Icon(Icons.person, size: 60, color: AppTheme.primaryColor),
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        // Nama dan NIM
                        Text(
                          profile.nama,
                          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: -0.5),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'NIM: ${profile.nim}',
                          style: TextStyle(fontSize: 16, color: Colors.grey[600], fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 24),
                        
                        // Kartu Informasi Pendidikan
                        _buildInfoCard(
                          title: 'Pendidikan',
                          icon: Icons.school_rounded,
                          children: [
                            _buildListTile(Icons.account_balance_rounded, profile.universitas),
                            _buildListTile(Icons.menu_book_rounded, profile.jurusan),
                            _buildListTile(Icons.timeline_rounded, 'Semester ${profile.semester}'),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Kartu Keahlian & Hobi
                        _buildInfoCard(
                          title: 'Keahlian & Minat',
                          icon: Icons.star_rounded,
                          children: [
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: profile.skills.map((skill) {
                                return Chip(
                                  label: Text(skill),
                                  backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                                  labelStyle: const TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.w600),
                                  side: BorderSide.none,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                );
                              }).toList(),
                            ),
                            const Divider(height: 32),
                            _buildListTile(Icons.sports_esports_rounded, profile.hobi),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Widget bantuan untuk bikin kotak kartu putih
  Widget _buildInfoCard({required String title, required IconData icon, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppTheme.primaryColor, size: 24),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  // Widget bantuan untuk baris informasi
  Widget _buildListTile(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[500]),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 15, color: Colors.grey[800]),
            ),
          ),
        ],
      ),
    );
  }
}