import 'package:flutter/material.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  // Sample transaction data
  final List<Map<String, dynamic>> _transactions = [
    {
      'id': 'TX001',
      'date': '12 Mei 2023',
      'type': 'Drop Off',
      'amount': '+120 Points',
      'description': 'Pengantaran sampah plastik 2.5kg',
      'isCredit': true,
    },
    {
      'id': 'TX002',
      'date': '5 Mei 2023',
      'type': 'Redeem',
      'amount': '-50 Points',
      'description': 'Tukar poin dengan voucher F&B',
      'isCredit': false,
    },
    {
      'id': 'TX003',
      'date': '28 April 2023',
      'type': 'Drop Off',
      'amount': '+85 Points',
      'description': 'Pengantaran sampah kertas 1.8kg',
      'isCredit': true,
    },
    {
      'id': 'TX004',
      'date': '15 April 2023',
      'type': 'Referral',
      'amount': '+25 Points',
      'description': 'Bonus referral pengguna baru',
      'isCredit': true,
    },
    {
      'id': 'TX005',
      'date': '10 April 2023',
      'type': 'Redeem',
      'amount': '-100 Points',
      'description': 'Tukar poin dengan e-wallet',
      'isCredit': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B7748),
        title: const Text(
          'Riwayat Transaksi',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: const Color(0xFF1B7748),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Poin:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '1,200 Poin',
                    style: TextStyle(
                      color: Color(0xFF1B7748),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _transactions.length,
              itemBuilder: (context, index) {
                final transaction = _transactions[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundColor: transaction['isCredit']
                          ? const Color(0xFFDEF5E7)
                          : const Color(0xFFFFF4E3),
                      child: Icon(
                        transaction['isCredit']
                            ? Icons.arrow_downward
                            : Icons.arrow_upward,
                        color: transaction['isCredit']
                            ? const Color(0xFF1B7748)
                            : Colors.orange,
                      ),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          transaction['type'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          transaction['amount'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: transaction['isCredit']
                                ? const Color(0xFF1B7748)
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          transaction['description'],
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'ID: ${transaction['id']} • ${transaction['date']}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
