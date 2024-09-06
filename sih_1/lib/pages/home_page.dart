// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:sih_1/components/bottom_nav_bar.dart';
import 'package:sih_1/pages/contact/contact_page.dart';
import 'package:sih_1/pages/dashboard/dashboard_page.dart';
import 'package:sih_1/pages/help/help_page.dart';
import 'package:sih_1/pages/login_register/models/auth_provider.dart';
import 'package:sih_1/pages/maps/map_page.dart';
import 'package:sih_1/pages/settings/settings_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 2; // Set to 1 for Home to be selected by default

  final List<Widget> _pages = [
    //help page
    const HelpPage(),

    //maps page
    const MapPage(),

    //dashboard page
    DashboardPage(),

    //contact page
    ContactPage(),

    //settings
    const SettingsPage(),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Display the current page based on selected index
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          padding: EdgeInsets.all(8),
          child: GNav(
            selectedIndex: _selectedIndex, // Highlight the selected button
            onTabChange: _onItemTapped, // Handle button tap
            color: Theme.of(context).colorScheme.primary,
            activeColor: Theme.of(context).colorScheme.inversePrimary,
            tabActiveBorder: Border.all(color: Theme.of(context).colorScheme.secondary),
            tabBackgroundColor: Theme.of(context).colorScheme.tertiary,
            tabBorderRadius: 5,
            mainAxisAlignment: MainAxisAlignment.center,
            tabs: [
              
                //help
                GButton(
                  icon: Icons.help_outline_rounded,
                  // text: 'Help',
                ),
          
                //maps
                GButton(
                  icon: Icons.location_pin,
                  // text: 'Map',
                ),
                
          
                //home
                GButton(
                  icon: Icons.home,
                  // text: 'Home',
                ),
          
                //contact
                GButton( 
                icon: Icons.person_2_outlined,
                // text: 'Contacts',
                ),
          
                //settings
                GButton(
                  icon: Icons.settings,
                  // text: 'Settings',
                )
            ],
          ),
        ),
      ),
    );
  }
}