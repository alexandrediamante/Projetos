import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtenha o textTheme do tema padrão do Material
    TextTheme textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.dmSansTextTheme(textTheme).copyWith(
          bodyMedium: GoogleFonts.aDLaMDisplay(textStyle: textTheme.bodyMedium),
        ),
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(
        users: [],
      ),
    );
  }
}
