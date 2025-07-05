import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _feedbackController = TextEditingController();
  int _selectedRating = 0;

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B7748),
        title: const Text(
          'Umpan Balik',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Nilai pengalaman Anda dengan ZeroCycle',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(5, (index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                _selectedRating = index + 1;
                              });
                            },
                            child: Icon(
                              _selectedRating > index
                                  ? Icons.star
                                  : Icons.star_border,
                              color: _selectedRating > index
                                  ? Colors.amber
                                  : Colors.grey,
                              size: 40,
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _selectedRating == 0
                            ? 'Tap bintang untuk memberi nilai'
                            : _getRatingDescription(_selectedRating),
                        style: TextStyle(
                          color: _selectedRating == 0
                              ? Colors.grey
                              : const Color(0xFF1B7748),
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Bagikan pengalaman Anda',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _feedbackController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Tulis umpan balik Anda di sini...',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
                validator: (value) {
                  if (_selectedRating == 0) {
                    return 'Harap berikan penilaian bintang';
                  }
                  if (value == null || value.isEmpty) {
                    return 'Harap berikan umpan balik';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Kategori Umpan Balik',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildCategoryChip('Aplikasi'),
                  _buildCategoryChip('Pengantaran'),
                  _buildCategoryChip('Poin & Rewards'),
                  _buildCategoryChip('UI/UX'),
                  _buildCategoryChip('Lainnya'),
                ],
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B7748),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Submit feedback
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Terima kasih atas umpan balik Anda!'),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    'Kirim Umpan Balik',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label) {
    return Chip(
      label: Text(label),
      backgroundColor: const Color(0xFFDEF5E7),
      labelStyle: const TextStyle(color: Color(0xFF1B7748)),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    );
  }

  String _getRatingDescription(int rating) {
    switch (rating) {
      case 1:
        return 'Sangat Buruk';
      case 2:
        return 'Buruk';
      case 3:
        return 'Cukup';
      case 4:
        return 'Baik';
      case 5:
        return 'Sangat Baik';
      default:
        return '';
    }
  }
}
