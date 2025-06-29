import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DropOffLocationScreen extends StatefulWidget {
  const DropOffLocationScreen({super.key});

  @override
  State<DropOffLocationScreen> createState() => _DropOffLocationScreenState();
}

class _DropOffLocationScreenState extends State<DropOffLocationScreen> {
  GoogleMapController? mapController;

  final LatLng _initialLocation = const LatLng(-7.797068, 110.370529); // Contoh: Yogyakarta

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
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.black),
            onPressed: () {
              mapController?.animateCamera(
                CameraUpdate.newLatLng(_initialLocation),
              );
            },
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
                    )
                  },
                ),

                // Icon lokasi besar di tengah
                const Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.location_on,
                    size: 72,
                    color: Color(0xFF0D723F),
                  ),
                ),

                // Info card di bawah
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
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
                                  color: Color(0xFFB2DDBF),
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
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                width: 48,
                                height: 48,
                                color: const Color(0xFF0D723F).withOpacity(0.1),
                                child: const Icon(Icons.recycling, color: Color(0xFF0D723F)),
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
                            ClipOval(
                              child: Image.asset(
                                'assets/images/avatar.png',
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 24),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // Aksi setelah klik Drop Sampah
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0D723F),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text(
                              'Drop Sampah',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
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
