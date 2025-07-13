import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:zerocycle/features/home/withdraw-page/ConfirmWithdrawPage.dart';

class WithdrawPage extends StatefulWidget {
  const WithdrawPage({super.key});

  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  final TextEditingController _amountController = TextEditingController();
  String? selectedAccount;

  double availableBalance = 216000;
  double adminFee = 907;

  bool get isFormValid {
    final amount = double.tryParse(_amountController.text.replaceAll('.', '').replaceAll(',', ''));
    return selectedAccount != null && amount != null && amount > 0 && amount <= availableBalance;
  }

  double get amountEntered => double.tryParse(_amountController.text.replaceAll('.', '').replaceAll(',', '')) ?? 0;
  double get estimatedReceive => (amountEntered - adminFee).clamp(0, availableBalance);

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cycle Points',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Rekening Penarikan Komisi',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                setState(() {
                  selectedAccount = 'DANA (62-******1221)';
                });
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: selectedAccount == null
                    ? Row(
                        children: [
                          const Icon(Icons.add, size: 18),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Text(
                              'Tambahkan metode penarikan komisi yang baru',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/images/DANA_1.png', height: 20),
                              const SizedBox(width: 8),
                              Text(
                                selectedAccount!,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text('Jumlah penarikan minimum: 3.000 IDR'),
                          const Text('Jumlah penarikan maksimum: 10.000.000 IDR'),
                          const Text('Dana akan tiba dalam 1 hari kerja'),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Jumlah', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'Rp.',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    onChanged: (_) => setState(() {}),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: const InputDecoration(
                      hintText: '0',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Komisi yang tersedia ${formatCurrency.format(availableBalance)}',
              style: const TextStyle(fontSize: 14),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  _amountController.text = availableBalance.toInt().toString();
                  setState(() {});
                },
                child: const Text('Tarik Komisi'),
              ),
            ),
            const SizedBox(height: 12),
            const Divider(),
            const Text(
              'Perkiraan jumlah penerimaan',
              style: TextStyle(fontSize: 14),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatCurrency.format(estimatedReceive),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  formatCurrency.format(adminFee),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                )
              ],
            ),
            const Text(
              'Biaya layanan',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isFormValid
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ConfirmWithdrawPage(
                              account: selectedAccount!,
                              amount: amountEntered,
                              fee: adminFee,
                            ),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isFormValid ? const Color(0xFF0D723F) : Colors.grey.shade300,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Pencairan Komisi',
                  style: TextStyle(
                    color: isFormValid ? Colors.white : Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}


