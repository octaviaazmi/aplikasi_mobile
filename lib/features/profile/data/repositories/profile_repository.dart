import '../models/profile_model.dart';

class ProfileRepository {
  Future<ProfileModel> getProfile() async {
    // Pura-puranya loading dari internet 1 detik
    await Future.delayed(const Duration(seconds: 1));
    
    return ProfileModel(
      nama: 'Octavia Nuzulul Azmi',
      nim: '434241040', 
      universitas: 'Universitas Airlangga',
      jurusan: 'Teknik Informatika',
      semester: 4,
      skills: ['Flutter', 'Laravel', 'Python', 'CSS'],
      hobi: 'Main Honkai: Star Rail',
    );
  }
}