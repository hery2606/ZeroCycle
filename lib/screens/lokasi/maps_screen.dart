import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  GoogleMapController? mapController;
  LatLng _initialPosition = const LatLng(-7.797068, 110.370529); // Default: Jogja
  Set<Marker> _markers = {};
  BitmapDescriptor? customIcon;
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }
  
  Future<void> _initializeMap() async {
    try {
      await _loadCustomIcon();
      await _checkLocationPermission();
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to initialize map: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  Future<void> _loadCustomIcon() async {
    try {
      customIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(48, 48)),
        'assets/images/location2.png',
      );
    } catch (e) {
      print('Error loading custom marker icon: $e');
      // Continue with default marker if custom icon fails to load
    }
    _loadDummyMarkers();
  }

  Future<void> _checkLocationPermission() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled;
      try {
        serviceEnabled = await Geolocator.isLocationServiceEnabled();
      } catch (e) {
        print('Error checking location service: $e');
        // In web, this might fail, so we'll assume it's enabled
        serviceEnabled = true;
      }
      
      if (!serviceEnabled) {
        setState(() {
          _errorMessage = 'Location services are disabled.';
          _isLoading = false;
        });
        return;
      }

      LocationPermission permission;
      try {
        // Check permission
        permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            setState(() {
              _errorMessage = 'Location permissions are denied.';
              _isLoading = false;
            });
            return;
          }
        }
        
        if (permission == LocationPermission.deniedForever) {
          setState(() {
            _errorMessage = 'Location permissions are permanently denied.';
            _isLoading = false;
          });
          return;
        }
      } catch (e) {
        print('Error checking location permission: $e');
        // Continue with default location if permission check fails
      }
      
      await _getCurrentLocation();
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
  
  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 5),
      );
      
      if (mounted) {
        setState(() {
          _initialPosition = LatLng(position.latitude, position.longitude);
        });
        
        // Add a marker for current location
        _addCurrentLocationMarker();
      }
    } catch (e) {
      print('Error getting current location: $e');
      // Fallback to default location
    }
  }
  
  void _addCurrentLocationMarker() {
    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId('currentLocation'),
          position: _initialPosition,
          infoWindow: const InfoWindow(title: 'Your Location'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        ),
      );
    });
  }

  void _loadDummyMarkers() {
    List<Map<String, dynamic>> locations = [
      {
        'id': '1',
        'position': const LatLng(-7.797068, 110.370529),
        'title': 'Bank Sampah Sejahtera'
      },
      {
        'id': '2',
        'position': const LatLng(-7.798068, 110.372529),
        'title': 'TPS 3R Mandiri'
      },
      {
        'id': '3',
        'position': const LatLng(-7.796068, 110.368529),
        'title': 'Recycle Center UGM'
      },
      {
        'id': '4',
        'position': const LatLng(-7.795068, 110.369000),
        'title': 'Drop Point Hijau'
      },
      {
        'id': '5',
        'position': const LatLng(-7.794500, 110.371000),
        'title': 'Waste Collection Point'
      },
    ];

    setState(() {
      for (var location in locations) {
        _markers.add(
          Marker(
            markerId: MarkerId(location['id']),
            position: location['position'],
            infoWindow: InfoWindow(title: location['title']),
            icon: customIcon ?? BitmapDescriptor.defaultMarker,
          ),
        );
      }
    });
  }

  void _searchLocation(String query) async {
    if (query.isEmpty) return;
    
    setState(() {
      _isLoading = true;
    });
    
    try {
      List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty && mounted) {
        final loc = locations.first;
        final target = LatLng(loc.latitude, loc.longitude);
        
        setState(() {
          // Remove previous search marker if exists
          _markers.removeWhere((marker) => marker.markerId.value == 'search');
          
          // Add new search marker
          _markers.add(Marker(
            markerId: const MarkerId('search'),
            position: target,
            infoWindow: InfoWindow(title: query),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
          ));
        });
        
        // Move camera to the searched location
        mapController?.animateCamera(CameraUpdate.newLatLngZoom(target, 15));
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Lokasi tidak ditemukan')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error searching location: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 15,
            ),
            onMapCreated: (controller) {
              setState(() {
                mapController = controller;
              });
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            markers: _markers,
            mapToolbarEnabled: false,
            zoomControlsEnabled: false,
          ),
          
          // Search bar
          Positioned(
            top: 50,
            left: 16,
            right: 16,
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(12),
              child: TextField(
                controller: _searchController,
                onSubmitted: _searchLocation,
                decoration: InputDecoration(
                  hintText: 'Cari lokasi...',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () => _searchLocation(_searchController.text),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
          ),
          
          // Current location button
          Positioned(
            bottom: 30,
            right: 16,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF1B7748),
              onPressed: () async {
                try {
                  await _getCurrentLocation();
                  mapController?.animateCamera(
                    CameraUpdate.newLatLngZoom(_initialPosition, 15),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Cannot get current location: ${e.toString()}')),
                  );
                }
              },
              child: const Icon(Icons.my_location),
            ),
          ),
          
          // Loading indicator
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            
          // Error message
          if (_errorMessage.isNotEmpty)
            Center(
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _errorMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _errorMessage = '';
                          _isLoading = true;
                        });
                        _initializeMap();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
