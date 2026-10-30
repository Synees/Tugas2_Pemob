import 'dart:ui' show FontFeature;

import 'package:flutter/material.dart';

void main() => runApp(const StatelessDemoApp());

// ---------------------------------------------------------------------------
// Palet: netral dingin + satu warna per prodi
// ---------------------------------------------------------------------------
class Palet {
  static const kertas = Color(0xFFF4F5F7);
  static const tinta = Color(0xFF1B2A41);
  static const tintaPudar = Color(0xFF5C6B80);
  static const garis = Color(0xFFE1E5EB);

  static const informatika = Color(0xFF2F5D8A);
  static const sistemInformasi = Color(0xFF2E7D6B);
  static const teknikElektro = Color(0xFF7A4E9C);
}

class StatelessDemoApp extends StatelessWidget {
  const StatelessDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo Stateless',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Palet.kertas,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Palet.tinta,
          surface: Palet.kertas,
        ),
      ),
      home: const DemoShell(),
    );
  }
}

/// Dua halaman dalam satu app, dipisah TabBar (tanpa state buatan sendiri).
class DemoShell extends StatelessWidget {
  const DemoShell({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Palet.kertas,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          bottom: const TabBar(
            labelColor: Palet.tinta,
            unselectedLabelColor: Palet.tintaPudar,
            indicatorColor: Palet.tinta,
            dividerColor: Palet.garis,
            tabs: [
              Tab(text: 'Daftar Mahasiswa'),
              Tab(text: 'Profil'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            DaftarMahasiswaPage(),
            ProfilPage(),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 1. KartuMahasiswa — 3 kartu dalam Column
// ---------------------------------------------------------------------------
class KartuMahasiswa extends StatelessWidget {
  final String nama;
  final String nim;
  final String prodi;
  final Color warna;

  const KartuMahasiswa({
    super.key,
    required this.nama,
    required this.nim,
    required this.prodi,
    required this.warna,
  });

  String get _inisial {
    final kata = nama.trim().split(RegExp(r'\s+'));
    final a = kata.first[0];
    final b = kata.length > 1 ? kata[1][0] : '';
    return (a + b).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Palet.garis),
      ),
      // ClipRRect supaya pita warna di kiri ikut melengkung.
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(width: 6, color: warna),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color.alphaBlend(
                            warna.withAlpha(30),
                            Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          _inisial,
                          style: TextStyle(
                            color: warna,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              nama,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Palet.tinta,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              nim,
                              style: const TextStyle(
                                color: Palet.tintaPudar,
                                fontSize: 13.5,
                                fontFeatures: [FontFeature.tabularFigures()],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              prodi,
                              style: TextStyle(
                                color: warna,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DaftarMahasiswaPage extends StatelessWidget {
  const DaftarMahasiswaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Kelas Bahasa Jerman',
            style: TextStyle(
              color: Palet.tinta,
              fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Tiga mahasiswa terdaftar',
            style: TextStyle(color: Palet.tintaPudar, fontSize: 14),
          ),
          SizedBox(height: 20),
          KartuMahasiswa(
            nama: 'Muhammad Faaza',
            nim: '3012410038',
            prodi: 'Informatika',
            warna: Palet.informatika,
          ),
          SizedBox(height: 12),
          KartuMahasiswa(
            nama: 'Bayu Purnomo',
            nim: '2012310020',
            prodi: 'Sistem Informasi',
            warna: Palet.sistemInformasi,
          ),
          SizedBox(height: 12),
          KartuMahasiswa(
            nama: 'Bagas Wicaksono',
            nim: '4012310025',
            prodi: 'Teknik Elektro',
            warna: Palet.teknikElektro,
          ),
        ],
      ),
    );
  }
}

// Halaman Profil
class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    const tinggiBanner = 140.0;
    const radiusAvatar = 52.0;

    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Container(
                height: tinggiBanner,
                width: double.infinity,
                color: Palet.tinta,
              ),
              Positioned(
                top: tinggiBanner - radiusAvatar,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Palet.kertas,
                    shape: BoxShape.circle,
                  ),
                  child: const CircleAvatar(
                    radius: radiusAvatar,
                    backgroundColor: Color(0xFFD5DEEA),
                    backgroundImage: AssetImage('asset/profile.jpeg'),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: radiusAvatar + 16),
          const Text(
            'Muhammad Faaza',
            style: TextStyle(
              color: Palet.tinta,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Informatika · Semester 5',
            style: TextStyle(color: Palet.tintaPudar, fontSize: 14),
          ),
          const SizedBox(height: 24),
          // Satu baris ikon kontak.
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IkonKontak(icon: Icons.mail_outline, label: 'Email'),
              SizedBox(width: 12),
              IkonKontak(icon: Icons.phone_outlined, label: 'Telepon'),
              SizedBox(width: 12),
              IkonKontak(icon: Icons.code, label: 'GitHub'),
              SizedBox(width: 12),
              IkonKontak(icon: Icons.location_on_outlined, label: 'Lokasi'),
            ],
          ),
        ],
      ),
    );
  }
}

class IkonKontak extends StatelessWidget {
  final IconData icon;
  final String label;

  const IkonKontak({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Palet.garis),
        ),
        child: Icon(icon, color: Palet.tinta, size: 22),
      ),
    );
  }
}