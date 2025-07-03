import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zerocycle/features/home/withdraw-page/success_page.dart';
// import 'package:zerocycle/features/home/withdraw-page/failed_page.dart';

class ConfirmWithdrawPage extends StatelessWidget {
  final String account;
  final double amount;
  final double fee;

  const ConfirmWithdrawPage({
    super.key,
    required this.account,
    required this.amount,
    required this.fee,
  });



  @override
  Widget build(BuildContext context) {
    final formatCurrency =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 2);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cycle Points',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Transfer ke',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text('DANA'),
            Text(account, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 24),

            const Text(
              'Jumlah penarikan komisi',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(formatCurrency.format(amount)),
            const SizedBox(height: 24),

            const Text(
              'Biaya layanan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(formatCurrency.format(fee)),
            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'Memasukkan informasi yang salah, akan menyebabkan penolakan transaksi dan akan bertanggung jawab untuk setiap biaya yang berkaitan dengan pemrosesan permintaan Anda.',
                style: TextStyle(fontSize: 14),
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: implement navigation to success page & failed page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WithdrawSuccessPage(
                        account: account,
                        amount: amount,
                        fee: fee,
                      ),
                    ),
                  );
                  Navigator.pop(context); // sementara kembali ke halaman sebelumnya
                },


                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D723F),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Konfirmasi untuk mencairkan komisi',
                  style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
