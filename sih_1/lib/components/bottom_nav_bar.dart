// // ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

// import 'package:flutter/material.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';

// // ignore: must_be_immutable
// class BottomNavBar  extends StatelessWidget {
//   void Function(int)? onTabChange;
//   BottomNavBar ({
//     super.key,
//     required this.onTabChange,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Container(
//         width: 100,
//         padding: const EdgeInsets.symmetric(vertical: 20),
//         child: GNav(
//           color: Theme.of(context).colorScheme.primary,
//           activeColor: Theme.of(context).colorScheme.inversePrimary,
//           tabActiveBorder: Border.all(color: Theme.of(context).colorScheme.secondary),
//           tabBackgroundColor: Theme.of(context).colorScheme.tertiary,
//           tabBorderRadius: 8,
//           mainAxisAlignment: MainAxisAlignment.center,
//           onTabChange: (value) => onTabChange!(value),
//           textSize: 6,
          
//           tabs: [
      
//             //help
//             GButton(
//               icon: Icons.help_outline_rounded,
//               // text: 'Help',
//             ),
      
//             //maps
//             GButton(
//               icon: Icons.location_pin,
//               // text: 'Map',
//             ),
            
      
//             //home
//             GButton(
//               icon: Icons.home,
//               // text: 'Home',
//             ),
      
//             //contact
//             GButton( 
//             icon: Icons.person_2_outlined,
//             // text: 'Contacts',
//             ),
      
//             //settings
//             GButton(
//               icon: Icons.settings,
//               // text: 'Settings',
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }