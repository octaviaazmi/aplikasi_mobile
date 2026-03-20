import 'dart:io';

class MahasiswaDasar {
  String nama;
  MahasiswaDasar(this.nama);
  
  void info() {
    print("Nama: $nama");
  }
}

class MahasiswaAktif extends MahasiswaDasar {
  int semester;
  
  MahasiswaAktif(String nama, this.semester) : super(nama);
  
  void status() {
    print("$nama adalah Mahasiswa Aktif semester $semester.");
  }
}

class MahasiswaAlumni extends MahasiswaDasar {
  int tahunLulus;
  
  MahasiswaAlumni(String nama, this.tahunLulus) : super(nama);
  
  void status() {
    print("$nama adalah Alumni, lulus pada tahun $tahunLulus.");
  }
}

mixin Penelitian {
  void meneliti() => print("--> Skill: Sedang melakukan riset dan penelitian.");
}

mixin Pengabdian {
  void mengabdi() => print("--> Skill: Sedang melakukan pengabdian masyarakat.");
}

mixin Organisasi {
  void rapat() => print("--> Skill: Aktif rapat dan organisasi kampus.");
}

class Dosen extends MahasiswaDasar with Penelitian, Pengabdian, Organisasi {
  Dosen(String nama) : super(nama);
}

class Fakultas extends MahasiswaDasar with Organisasi {
  Fakultas(String nama) : super(nama);
}

void main() {
  print("=== HASIL C: EXTENDS MAHASISWA ===");
  var mhsAktif = MahasiswaAktif("Via", 4); 
  mhsAktif.info(); 
  mhsAktif.status(); 

  var mhsAlumni = MahasiswaAlumni("Budi", 2023);
  mhsAlumni.status();

  print("\n=== HASIL D: MIXIN DOSEN & FAKULTAS ===");
  var dosen = Dosen("Pak Anang");
  dosen.info();
  dosen.meneliti(); 
  dosen.mengabdi(); 
  dosen.rapat();  
}