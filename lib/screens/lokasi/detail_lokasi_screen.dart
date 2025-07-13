// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// class DetailScreen extends StatelessWidget {
//   final String name;
//   final String address;
//   final double rating;
//   final String imageUrl;

//   const DetailScreen({
//     super.key,
//     required this.name,
//     required this.address,
//     required this.rating,
//     required this.imageUrl,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF147B3C),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.arrow_back, color: Colors.white),
//                     onPressed: () => Navigator.pop(context),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(16),
//                 child: Image.asset(imageUrl, width: 120, height: 120, fit: BoxFit.cover),
//               ),
//               const SizedBox(height: 12),
//               Text(name, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 4),
//               Text("Robert Fhendy", style: TextStyle(color: Colors.grey[300])),
//               const SizedBox(height: 8),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Icon(Icons.star, color: Colors.amber, size: 16),
//                   const SizedBox(width: 4),
//                   Text(rating.toString(), style: const TextStyle(color: Colors.white)),
//                 ],
//               ),
//               const SizedBox(height: 8),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Icon(Icons.location_pin, color: Colors.white, size: 16),
//                   const SizedBox(width: 4),
//                   Flexible(
//                     child: Text(
//                       address,
//                       style: const TextStyle(color: Colors.white),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 8),
//               const Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.access_time, color: Colors.white, size: 16),
//                   SizedBox(width: 4),
//                   Text("Buka 08.00 - 17.00", style: TextStyle(color: Colors.white)),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text("Activities Review", style: TextStyle(color: Colors.white, fontSize: 16)),
//               ),
//               const SizedBox(height: 8),
//               _buildReview("An excellent Garbage Bank with services and facilities similar to a 5 - stars hotel."),
//               _buildReview("Good service, friendly, fast and very helpful."),
//               _buildReview("An alternative when your pocket is empty. Just donate recyclable waste."),
//               const SizedBox(height: 10),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: Text("Another Review ➜", style: TextStyle(color: Colors.white)),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 children: [
//                   const CircleAvatar(child: Text("M")),
//                   const SizedBox(width: 8),
//                   RatingBar.builder(
//                     initialRating: 5,
//                     minRating: 1,
//                     allowHalfRating: false,
//                     itemCount: 5,
//                     itemSize: 28,
//                     unratedColor: Colors.grey,
//                     itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
//                     itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
//                     onRatingUpdate: (rating) {},
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 12),
//               Container(
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF34A853),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                 child: Row(
//                   children: [
//                     const Expanded(
//                       child: TextField(
//                         decoration: InputDecoration.collapsed(hintText: "Add Review", hintStyle: TextStyle(color: Colors.white)),
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.send, color: Colors.white),
//                       onPressed: () {},
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildReview(String text) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 4),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: const Color(0xFF34A853),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Text(text, style: const TextStyle(color: Colors.white)),
//     );
//   }
// }
