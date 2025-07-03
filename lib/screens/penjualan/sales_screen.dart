import 'package:flutter/material.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  final List<Map<String, dynamic>> wasteItems = [
    {
      'image': 'assets/images/botol.png',
      'name': 'Plastik Botol',
      'weight': 2.5,
      'price': 1500,
    },
    {
      'image': 'assets/images/kertas.png',
      'name': 'Kertas',
      'weight': 1.0,
      'price': 1000,
    },
    {
      'image': 'assets/images/elektronik.png',
      'name': 'Logam',
      'weight': 0.7,
      'price': 3000,
    },
  ];

  String? selectedPayment = 'Tunai';

  double getTotalPrice() {
    return wasteItems.fold(0.0, (sum, item) {
      return sum + (item['weight'] * item['price']);
    });
  }

  void _choosePaymentMethod() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Pilih Metode Pembayaran',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          ListTile(
            title: const Text('Tunai'),
            leading: const Icon(Icons.money),
            onTap: () {
              setState(() => selectedPayment = 'Tunai');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Transfer Bank'),
            leading: const Icon(Icons.account_balance),
            onTap: () {
              setState(() => selectedPayment = 'Transfer Bank');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('E-Wallet'),
            leading: const Icon(Icons.wallet),
            onTap: () {
              setState(() => selectedPayment = 'E-Wallet');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _confirmSale() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Penjualan'),
        content: Text(
            'Kamu akan menjual ${wasteItems.length} jenis sampah dengan total ${getTotalPrice().toStringAsFixed(0)} IDR melalui metode $selectedPayment.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Penjualan berhasil!')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0D723F),
            ),
            child: const Text('Konfirmasi'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Penjualan Sampah',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: wasteItems.length,
        itemBuilder: (context, index) {
          final item = wasteItems[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: Image.asset(
                item['image'],
                width: 40,
                height: 40,
              ),
              title: Text(item['name']),
              subtitle: Text(
                  '${item['weight']} kg x ${item['price']} IDR = ${(item['weight'] * item['price']).toStringAsFixed(0)} IDR'),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  setState(() {
                    wasteItems.removeAt(index);
                  });
                },
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey, width: 0.1)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(width: 8),
                Text(
                  '${getTotalPrice().toStringAsFixed(0)} IDR',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Metode:'),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    selectedPayment ?? 'Pilih metode',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                TextButton(
                  onPressed: _choosePaymentMethod,
                  child: const Text('Ubah'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: wasteItems.isNotEmpty ? _confirmSale : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D723F),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Konfirmasi Penjualan',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
