import 'package:flutter/material.dart';
import 'package:zerocycle/features/notification/empty_notif.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Ganti dengan kondisi dynamic dari API jika tersedia
    final bool hasNotification = false;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifikasi',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: hasNotification ? NotifCard() : const EmptyNotif(),
    );
  }

  Widget NotifCard() {
    // Ganti dengan widget yang menampilkan daftar notifikasi
    // Misalnya, menggunakan ListView.builder untuk menampilkan notifikasi
    // Ini hanya contoh, sesuaikan dengan data notifikasi yang sebenarnya
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.notifications),
          title: Text('Notifikasi ${index + 1}'),
          subtitle: Text('Detail notifikasi ${index + 1}'),
        );
      },
    );
  }
}
