import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

class BagikanPage extends StatefulWidget {
  const BagikanPage({super.key});

  @override
  State<BagikanPage> createState() => _BagikanPageState();
}

class _BagikanPageState extends State<BagikanPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  bool _isCodeCopied = false;

  // Sample data - in a real app, this would come from user's account
  final int _totalPoints = 1200;
  final int _totalRecycled = 25; // in kg
  final int _totalTrees = 3; // trees saved
  final int _totalCO2 = 15; // kg of CO2 reduced
  final String _referralCode = "ZERO4EARTH";
  final int _referralBonus = 200; // points per referral
  
  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );
    
    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(_animationController);
    
    _animationController.repeat();
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _copyReferralCode() {
    Clipboard.setData(ClipboardData(text: _referralCode));
    setState(() {
      _isCodeCopied = true;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Kode referral disalin ke clipboard'),
        backgroundColor: const Color(0xFF1B7748),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
    
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isCodeCopied = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Bagikan ZeroCycle'),
        backgroundColor: const Color(0xFF1B7748),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Background patterns
          Positioned(
            top: -100,
            right: -100,
            child: AnimatedBuilder(
              animation: _rotationAnimation,
              builder: (_, child) {
                return Transform.rotate(
                  angle: _rotationAnimation.value,
                  child: child,
                );
              },
              child: Opacity(
                opacity: 0.05,
                child: Image.asset(
                  'assets/images/pattern.png',
                  width: 300,
                  height: 300,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            left: -100,
            child: AnimatedBuilder(
              animation: _rotationAnimation,
              builder: (_, child) {
                return Transform.rotate(
                  angle: -_rotationAnimation.value,
                  child: child,
                );
              },
              child: Opacity(
                opacity: 0.05,
                child: Image.asset(
                  'assets/images/pattern.png',
                  width: 300,
                  height: 300,
                ),
              ),
            ),
          ),
          
          // Main content
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Impact Card
                  _buildImpactCard(),
                  const SizedBox(height: 24),
                  
                  // Sharing options
                  const Text(
                    'Bagikan Pencapaianmu',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSharingOptions(),
                  const SizedBox(height: 30),
                  
                  // Referral section
                  const Text(
                    'Ajak Teman, Dapatkan Poin',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildReferralCard(),
                  const SizedBox(height: 30),
                  
                  // Recycling facts
                  const Text(
                    'Tahukah Kamu?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildFactsSection(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildImpactCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1B7748), Color(0xFF0D723F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1B7748).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Dampak Positif Daur Ulang Anda',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildImpactStat(
                icon: Icons.recycling,
                value: '$_totalRecycled kg',
                label: 'Sampah Didaur Ulang',
              ),
              _buildImpactStat(
                icon: Icons.eco,
                value: '$_totalTrees',
                label: 'Pohon Diselamatkan',
              ),
              _buildImpactStat(
                icon: Icons.cloud_outlined,
                value: '$_totalCO2 kg',
                label: 'CO₂ Dikurangi',
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Bagikan dampak positif Anda untuk menginspirasi orang lain!',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: IconButton(
                  icon: const Icon(Icons.share, color: Colors.white),
                  onPressed: () {
                    // Implement share functionality
                    _showShareDialog();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildImpactStat({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
  
  Widget _buildSharingOptions() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSocialShareButton(
                icon: Icons.facebook,
                color: const Color(0xFF3b5998),
                label: 'Facebook',
                onTap: () {
                  // Implement Facebook sharing
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Membagikan ke Facebook')),
                  );
                },
              ),
              _buildSocialShareButton(
                icon: Icons.chat_bubble,
                color: const Color(0xFF25D366),
                label: 'WhatsApp',
                onTap: () {
                  // Implement WhatsApp sharing
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Membagikan ke WhatsApp')),
                  );
                },
              ),
              _buildSocialShareButton(
                icon: Icons.link,
                color: const Color(0xFF1B7748),
                label: 'Salin Link',
                onTap: () {
                  // Implement copy link
                  Clipboard.setData(const ClipboardData(
                    text: 'https://zerocycle.id/u/johndoe',
                  ));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Link disalin ke clipboard')),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Bagikan kisah daur ulang Anda dan ajak teman untuk bergabung dengan ZeroCycle. Bersama kita bisa membuat perbedaan untuk bumi!',
            style: TextStyle(
              color: Color(0xFF666666),
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  
  Widget _buildSocialShareButton({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildReferralCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFEBEE),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.card_giftcard, color: Color(0xFFE53935)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Program Referral',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Ajak teman dan dapatkan $_referralBonus poin per referral!',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF666666),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Kode Referral Anda',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF666666),
            ),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: _copyReferralCode,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE0E0E0)),
              ),
              child: Row(
                children: [
                  Text(
                    _referralCode,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  const Spacer(),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      color: _isCodeCopied 
                          ? const Color(0xFF1B7748)
                          : const Color(0xFFE0E0E0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Row(
                      children: [
                        Icon(
                          _isCodeCopied ? Icons.check : Icons.copy,
                          size: 16,
                          color: _isCodeCopied ? Colors.white : Colors.black54,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _isCodeCopied ? 'Disalin' : 'Salin',
                          style: TextStyle(
                            fontSize: 12,
                            color: _isCodeCopied ? Colors.white : Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Implement invite friends functionality
                    _showInviteFriendsDialog();
                  },
                  icon: const Icon(Icons.people),
                  label: const Text('Undang Teman'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B7748),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildFactsSection() {
    return Column(
      children: [
        _buildFactCard(
          title: 'Plastik membutuhkan waktu 450 tahun untuk terurai',
          description: 'Dengan mendaur ulang 1 kg plastik, Anda menghemat 1,5 kg emisi CO₂ ke atmosfer.',
          icon: Icons.timeline,
        ),
        const SizedBox(height: 16),
        _buildFactCard(
          title: '1 ton kertas daur ulang menyelamatkan 17 pohon',
          description: 'Mendaur ulang kertas menghemat 65% energi dibanding membuat kertas baru.',
          icon: Icons.forest,
        ),
        const SizedBox(height: 16),
        _buildFactCard(
          title: 'Kaleng aluminium dapat didaur ulang tanpa batas',
          description: 'Mendaur ulang aluminium menghemat 95% energi dibanding membuatnya dari bahan baku.',
          icon: Icons.loop,
        ),
      ],
    );
  }
  
  Widget _buildFactCard({
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFDEF5E7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF1B7748)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  void _showShareDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Bagikan Pencapaian',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Text(
                    '🌱 Pencapaian ZeroCycle Saya 🌱',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Saya telah mendaur ulang $_totalRecycled kg sampah, menyelamatkan $_totalTrees pohon, dan mengurangi $_totalCO2 kg emisi CO₂. Mari bergabung dengan #ZeroCycle dan bantu selamatkan bumi kita!',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Download ZeroCycle sekarang: zerocycle.id/download',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Color(0xFF1B7748),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildShareDialogOption(
                  icon: Icons.facebook,
                  color: const Color(0xFF3b5998),
                  label: 'Facebook',
                ),
                _buildShareDialogOption(
                  icon: Icons.chat_bubble,
                  color: const Color(0xFF25D366),
                  label: 'WhatsApp',
                ),
                _buildShareDialogOption(
                  icon: Icons.alternate_email,
                  color: const Color(0xFF1DA1F2),
                  label: 'Twitter',
                ),
                _buildShareDialogOption(
                  icon: Icons.link,
                  color: const Color(0xFF333333),
                  label: 'Salin',
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
  
  Widget _buildShareDialogOption({
    required IconData icon,
    required Color color,
    required String label,
  }) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Membagikan ke $label')),
        );
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
  
  void _showInviteFriendsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Undang Teman'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Pilih metode untuk mengundang teman ke ZeroCycle',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF25D366).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.chat_bubble, color: Color(0xFF25D366)),
              ),
              title: const Text('WhatsApp'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Mengundang via WhatsApp')),
                );
              },
            ),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.email, color: Colors.blue),
              ),
              title: const Text('Email'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Mengundang via Email')),
                );
              },
            ),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.message, color: Colors.orange),
              ),
              title: const Text('SMS'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Mengundang via SMS')),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
        ],
      ),
    );
  }
}
