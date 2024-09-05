import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sih_1/pages/contact/contact_provider.dart';
import 'package:sih_1/pages/dashboard/model/sos_model.dart';
import 'package:sih_1/pages/login_register/models/auth_provider.dart';
import 'package:sih_1/pages/login_register/login_page.dart';
import 'package:sih_1/theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => SOSProvider()),
        ChangeNotifierProvider(create: (context) => ContactProvider() ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: LoginPage(),
    );
  }
}
