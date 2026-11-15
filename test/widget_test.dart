import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lista_tres_estados/main.dart';

void main() {
  testWidgets('muestra carga, error y la lista al reintentar', (tester) async {
    await tester.pumpWidget(const AppReservas());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Cargando reservas...'), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    await tester.pump();

    expect(
      find.text('No hay conexión. Revisa tu red e intenta de nuevo.'),
      findsOneWidget,
    );
    expect(find.text('Reintentar'), findsOneWidget);

    await tester.tap(find.text('Reintentar'));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    await tester.pump();

    expect(find.byType(Card), findsWidgets);
    expect(find.text('UTEZ, Emiliano Zapata'), findsOneWidget);
    expect(find.text('Sale a las 07:10'), findsOneWidget);
    expect(find.text('Casasano'), findsOneWidget);
    expect(find.text('Sin recordatorio'), findsWidgets);
  });
}
