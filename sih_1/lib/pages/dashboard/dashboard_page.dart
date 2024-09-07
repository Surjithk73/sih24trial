// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sih_1/components/report_button.dart';
// import 'package:sih_1/models/contact.dart';
import 'package:sih_1/pages/contact/contact_provider.dart';
import 'package:sih_1/pages/dashboard/provider/sos_provider.dart';
// import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:telephony/telephony.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with SingleTickerProviderStateMixin {
  late SOSProvider _sosProvider;

  @override
  void initState() {
    super.initState();
    // Initialization that doesn't depend on context goes here
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ContactProvider>(context, listen: false).fetchContacts();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Obtain the provider instance safely after dependencies have changed
    _sosProvider = Provider.of<SOSProvider>(context, listen: false);
    _sosProvider.initializeController(this);
  }

  @override
  void dispose() {
    // Dispose the AnimationController safely
    _sosProvider.disposeController();
    super.dispose();
  }

  // Future<List<Contact>> fetchContactsFromDatabase() async {
  //   // Open the database
  //   final database = await openDatabase('contacts.db');
    
  //   // Query the database to get the contacts
  //   final List<Map<String, dynamic>> maps = await database.query('contacts');
    
  //   // Convert the list of maps to a list of Contact objects
  //   return List.generate(maps.length, (i) {
  //     return Contact.fromMap(maps[i]);
  //   });
  // }

    Future<String> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      return 'Lat: ${position.latitude}, Long: ${position.longitude}';
    } catch (error) {
      print("Error getting location: $error");
      return 'Location unavailable';
    }
  }
Future<void> requestSmsPermission() async {
  final status = await Permission.sms.request();
  if (!status.isGranted) {
    // Handle the case where the permission is not granted
    print("SMS permission not granted");
  }
}

Future<void> sendSOSMessage(List<String> recipients, String message) async {
  final Telephony telephony = Telephony.instance;

  // Check if permissions are granted
  bool? permissionsGranted = await telephony.requestPhonePermissions;
  if (permissionsGranted != null && permissionsGranted) {
    try {
      for (String recipient in recipients) {
        await telephony.sendSms(
          to: recipient,
          message: message,
        );
      }
    } catch (error) {
      print("Error sending SMS: $error");
    }
  } else {
    print("SMS permissions not granted.");
  }
}

  // Future<void> playTTSMessage(String message) async {
  //   FlutterTts flutterTts = FlutterTts();
  //   await flutterTts.setLanguage('en-US');
  //   await flutterTts.setSpeechRate(0.5);
  //   await flutterTts.setVolume(100);
  //   await flutterTts.speak(message);
  // }

  Future<void> makeCall(String phoneNumber) async {
    try {
      await FlutterPhoneDirectCaller.callNumber(phoneNumber);
    } catch (error) {
      print("Error making call: $error");
    }
  }

  Future<void> handleSOS() async {
    // Check and request permissions
    var locationPermission = await Permission.location.request();
    // var smsPermission = await Permission.sms.request();
    var callPermission = await Permission.phone.request();
// && smsPermission.isGranted
    if (locationPermission.isGranted  && callPermission.isGranted) {
      // Fetch contacts from the database
      final provider = Provider.of<ContactProvider>(context, listen: false);
      final contacts = provider.contacts;
      final contactNumbers = contacts.map((c) => c.phoneNumber).toList();
      
      // Example: Indian police station number
      String policeStationNumber = '8015031073';

      // Get current location
      String location = await getCurrentLocation();
      String sosMessage = 'SOS! I need help. My location is: $location';

      // Send SOS message to contacts and police station
      await sendSOSMessage(contactNumbers, sosMessage);
      await sendSOSMessage([policeStationNumber], sosMessage);

      // Make a call to the police station
      await makeCall(policeStationNumber);

      // Play TTS message
      // await playTTSMessage('I need help! My location is: $location');

      // Show a confirmation message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('SOS alert sent and call made.')),
      );
    } else {
      // Handle permission denial
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Permissions denied. SOS cannot be sent.')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Dashboard Page'),
          actions: [
            IconButton(
              icon: const Icon(Icons.message_outlined), // Add the icon you want
              onPressed: handleSOS
            ),
          ],
        ),
        body: Column(
          children: [
            const SizedBox(height: 100,),
            Center(
              child: AnimatedBuilder(
                animation: _sosProvider.animation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _sosProvider.animation.value, // Adjust opacity to create blinking effect
                    child: SizedBox(
                      width: 150, // Set finite width for the button
                      height: 100, // Set finite height for the button
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.sos, size: 40), // Set icon size
                        label: const Text('', style: TextStyle(fontSize: 18)), // Set text size
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                        onPressed: handleSOS,
                      ),
                    ),
                  );
                },
              ),
            ),

            ReportButton(),
          ],
        ),
      ),
    );
  }
}
