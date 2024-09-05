import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sih_1/pages/dashboard/model/sos_model.dart';
 // Import the SOSProvider class

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
    // Obtain the provider instance safely
    _sosProvider = Provider.of<SOSProvider>(context, listen: false);
    _sosProvider.initializeController(this);
  }

  @override
  void dispose() {
    // Dispose the AnimationController safely
    if (mounted) {
      _sosProvider.disposeController();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.message_outlined), // Add the icon you want
            onPressed: () {
              // Define the action on icon press
              
            },
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
                      onPressed: () {
                        // You can add SOS functionality here
                        const AlertDialog(
                          content: Text("CONNECT TO BACKEND TO SOS"),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

    );
  }
}