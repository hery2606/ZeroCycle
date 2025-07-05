import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DropOffLocationScreen extends StatefulWidget {
  const DropOffLocationScreen({super.key});

  @override
  State<DropOffLocationScreen> createState() => _DropOffLocationScreenState();
}

class _DropOffLocationScreenState extends State<DropOffLocationScreen> with SingleTickerProviderStateMixin {
  GoogleMapController? mapController;
  late AnimationController _buttonAnimationController;
  late Animation<double> _buttonScaleAnimation;

  final LatLng _initialLocation = const LatLng(-7.797068, 110.370529); // Contoh: Yogyakarta
  bool _isInfoCardExpanded = false;

  @override
  void initState() {
    super.initState();
    
    // Initialize animation controller for button effects
    _buttonAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    
    _buttonScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _buttonAnimationController,
      curve: Curves.easeInOut,
    ));
    
    // Auto-start the animation in a loop
    _buttonAnimationController.repeat(reverse: true);
  }
  
  @override
  void dispose() {
    _buttonAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
          tooltip: 'Kembali', // Added tooltip
        ),
        centerTitle: true,
        title: const Text(
          'Drop Off',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        actions: [
          Tooltip(
            message: 'Segarkan peta', // Added tooltip
            child: IconButton(
              icon: const Icon(Icons.refresh, color: Colors.black),
              onPressed: () {
                mapController?.animateCamera(
                  CameraUpdate.newLatLng(_initialLocation),
                );
                
                // Show a snackbar to indicate the refresh action
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Peta disegarkan'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _initialLocation,
                    zoom: 15,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
                  },
                  myLocationEnabled: true,
                  markers: {
                    Marker(
                      markerId: const MarkerId('dropoff'),
                      position: _initialLocation,
                      infoWindow: const InfoWindow(title: 'Bank Sampah Pelita'),
                      onTap: () {
                        setState(() {
                          _isInfoCardExpanded = true;
                        });
                        // Add a visual hint when marker is tapped
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Lokasi dipilih: Bank Sampah Pelita'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                    )
                  },
                ),

                // Icon lokasi besar di tengah dengan hint animation
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Animated location icon
                      TweenAnimationBuilder<double>(
                        duration: const Duration(seconds: 1),
                        tween: Tween<double>(begin: 0, end: 20),
                        curve: Curves.easeInOut,
                        builder: (context, value, child) {
                          return Transform.translate(
                            offset: Offset(0, -value), // Bouncing effect
                            child: const Icon(
                              Icons.location_on,
                              size: 72,
                              color: Color(0xFF0D723F),
                            ),
                          );
                        },
                      ),
                      
                      // Tap hint text
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Text(
                          'Tekan untuk memilih lokasi',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Info card di bawah
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: _isInfoCardExpanded ? 200 : 160,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isInfoCardExpanded = !_isInfoCardExpanded;
                      });
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, -2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Pull indicator
                          Center(
                            child: Container(
                              width: 40,
                              height: 4,
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0D723F),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.pin_drop, color: Colors.white),
                                    SizedBox(width: 8),
                                    Text(
                                      'Jarak tempuh',
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFB2DDBF),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text(
                                    '7 Menit',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),

                          Row(
                            children: [
                              // Interactive container with ripple effect
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Info tempat daur ulang'),
                                        duration: Duration(seconds: 1),
                                      ),
                                    );
                                  },
                                  borderRadius: BorderRadius.circular(12),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF0D723F).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Icon(Icons.recycling, color: Color(0xFF0D723F)),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Bank Sampah Pelita',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFB2DDBF),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: const Text(
                                            'Green Zone',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        const Text('Imanuel Chaesar'),
                                        const SizedBox(width: 6),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Row(
                                            children: const [
                                              Icon(Icons.star, color: Colors.amber, size: 14),
                                              SizedBox(width: 2),
                                              Text('4.5', style: TextStyle(fontSize: 12)),
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Info pengelola'),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                },
                                borderRadius: BorderRadius.circular(20),
                                child: Tooltip(
                                  message: 'Info pengelola',
                                  child: ClipOval(
                                    child: Image.asset(
                                      'assets/images/avatar.png',
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Animated button for better visibility
                          AnimatedBuilder(
                            animation: _buttonAnimationController,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _buttonScaleAnimation.value,
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Aksi setelah klik Drop Sampah
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Proses drop sampah dimulai...'),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF0D723F),
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      elevation: 4,
                                      shadowColor: const Color(0xFF0D723F).withOpacity(0.5),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.touch_app, color: Colors.white, size: 18),
                                        SizedBox(width: 8),
                                        Text(
                                          'Drop Sampah',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
