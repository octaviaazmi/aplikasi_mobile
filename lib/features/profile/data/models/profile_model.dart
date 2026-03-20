class ProfileModel {
  final String nama;
  final String nim;
  final String universitas;
  final String jurusan;
  final int semester;
  final List<String> skills;
  final String hobi;

  ProfileModel({
    required this.nama,
    required this.nim,
    required this.universitas,
    required this.jurusan,
    required this.semester,
    required this.skills,
    required this.hobi,
  });
}