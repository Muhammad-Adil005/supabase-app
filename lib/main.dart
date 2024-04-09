import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'Signup_screen/signup_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://jshvkyxmknrzeqtlvkgg.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpzaHZreXhta25yemVxdGx2a2dnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTI1NTcyMTEsImV4cCI6MjAyODEzMzIxMX0.Nn0NmAghm7Zti0x_OzKg8TyxsD4wG1_BofCWOTlC00k',
  );
  runApp(const SupabaseApp());
}

final supabase = Supabase.instance.client;

class SupabaseApp extends StatelessWidget {
  const SupabaseApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Supabase App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SignUpScreen(),
    );
  }
}
