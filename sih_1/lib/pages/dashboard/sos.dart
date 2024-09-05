// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sih_1/pages/dashboard/model/sos_model.dart';

// class SOS extends StatefulWidget {
//   @override
//   _SOSState createState() => _SOSState();
// }

// class _SOSState extends State<SOS> with SingleTickerProviderStateMixin {
//   @override
//   void initState() {
//     super.initState();
//     // Initialize the AnimationController using the Provider
//     Provider.of<SOSProvider>(context, listen: false).initializeController(this);
//   }

//   @override
//   void dispose() {
//     // Dispose the AnimationController using the Provider
//     Provider.of<SOSProvider>(context, listen: false).disposeController();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final sosProvider = Provider.of<SOSProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('SOS Blinking Animation'),
//       ),
//       body: Center(
//         child: AnimatedBuilder(
//           animation: sosProvider.animation,
//           builder: (context, child) {
//             return Opacity(
//               opacity: sosProvider.animation.value, // Adjust opacity to create blinking effect
//               child: SizedBox(
//                 width: 150, // Limit the width of the button
//                 height: 100, // Limit the height of the button
//                 child: ElevatedButton.icon(
//                   icon: Icon(Icons.sos, size: 40), // Smaller icon size
//                   label: Text('SOS', style: TextStyle(fontSize: 18)), // Smaller text size
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.red,
//                     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   ),
//                   onPressed: () {
//                     // You can add SOS functionality here
//                   },
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }