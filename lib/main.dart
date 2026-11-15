import 'package:flutter/material.dart';

import 'pantalla_reservas.dart';

void main() {
  runApp(const AppReservas());
}

class AppReservas extends StatelessWidget {
  const AppReservas({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reservas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0B6E4F)),
      ),
      home: const PantallaReservas(),
    );
  }
}
