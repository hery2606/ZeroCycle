// import 'package:flutter/material.dart';

// class PesanScreen extends StatelessWidget {
//   const PesanScreen({super.key});

//   // Contoh data pesan (bisa diganti dari API atau provider)
//   final List<Map<String, dynamic>> pesanList = const [
//     {
//       "tanggal": "2025-07-01",
//       "judul": "Pencairan Komisi Berhasil",
//       "detail": {
//         "Tanggal": "1 Jul 2025",
//         "Waktu": "23:08:24 WIB",
//         "Jumlah Penarikan": "Rp. 216.000,00",
//         "No Transaksi": "********************",
//         "Terminal ID": "A01",
//         "Layanan": "DANA"
//       },
//     },
//     {
//       "tanggal": "2025-06-23",
//       "pesan":
//           "“Udah lama niih gak nabung sampah. Yuuk nabung sampah lagi buat menjaga lingkungan agar tetap bersih, dan dapatkan cuan dari hasil penukaran sampah. ..”"
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF097740),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF097740),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//         centerTitle: true,
//         title: const Text(
//           'Pesan',
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         elevation: 0,
//       ),
//       body: pesanList.isEmpty
//           ? const Center(
//               child: Text(
//                 'Belum ada pesan',
//                 style: TextStyle(color: Colors.white70, fontSize: 16),
//               ),
//             )
//           : ListView.builder(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//               itemCount: pesanList.length,
//               itemBuilder: (context, index) {
//                 final item = pesanList[index];
//                 return _buildPesanCard(item);
//               },
//             ),
//     );
//   }

//   Widget _buildPesanCard(Map<String, dynamic> item) {
//     final isDetail = item.containsKey('detail');
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.fromLTRB(12, 16, 12, 12),
//       decoration: BoxDecoration(
//         color: const Color(0xFF50B97B),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Date tag
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFC9F6DE),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Text(
//                   item["tanggal"],
//                   style: const TextStyle(
//                     fontSize: 11,
//                     color: Colors.black87,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ],
//           ),
          
//           const SizedBox(height: 8),
          
//           // Message content
//           isDetail 
//               ? Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       item["judul"],
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         fontSize: 14,
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 2,
//                     ),
//                     const SizedBox(height: 10),
//                     ...item['detail'].entries.map((entry) => Padding(
//                           padding: const EdgeInsets.only(bottom: 3.0),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(
//                                 width: 110,
//                                 child: Text(
//                                   entry.key,
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 13,
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Text(
//                                   entry.value,
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 13,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                   overflow: TextOverflow.ellipsis,
//                                   maxLines: 2,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )),
//                   ],
//                 )
//               : Text(
//                   item['pesan'],
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 13,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 6,
//                 ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

class PesanScreen extends StatelessWidget {
  const PesanScreen({super.key});

  final List<Map<String, dynamic>> pesanList = const [
    {
      "tanggal": "2025-07-01",
      "judul": "Pencairan Komisi Berhasil",
      "detail": {
        "Tanggal": "1 Jul 2025",
        "Waktu": "23:08:24 WIB",
        "Jumlah Penarikan": "Rp. 216.000,00",
        "No Transaksi": "********************",
        "Terminal ID": "A01",
        "Layanan": "DANA"
      },
    },
    {
      "tanggal": "2025-06-23",
      "pesan":
          "“Udah lama niih gak nabung sampah. Yuuk nabung sampah lagi buat menjaga lingkungan agar tetap bersih, dan dapatkan cuan dari hasil penukaran sampah. ..”"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF097740),
      appBar: AppBar(
        backgroundColor: const Color(0xFF097740),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Pesan',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: pesanList.isEmpty
          ? const Center(
              child: Text(
                'Belum ada pesan',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: pesanList.length,
              itemBuilder: (context, index) {
                final item = pesanList[index];
                return _buildPesanCard(item);
              },
            ),
    );
  }

  Widget _buildPesanCard(Map<String, dynamic> item) {
    final isDetail = item.containsKey('detail');

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 12, bottom: 20),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF50B97B),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: isDetail
                ? [
                    Text(
                      item["judul"],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...item['detail'].entries.map(
                      (entry) => Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 120,
                              child: Text(
                                entry.key,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                entry.value,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]
                : [
                    Text(
                      item['pesan'],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFFC9F6DE),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Text(
              item["tanggal"],
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
