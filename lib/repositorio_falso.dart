import 'reserva.dart';

class RepositorioFalso {
  int _llamadas = 0;

  Future<List<Reserva>> obtener() async {
    await Future.delayed(const Duration(seconds: 2));
    _llamadas++;
    if (_llamadas == 1) {
      throw Exception('Sin conexión');
    }
    return const [
      Reserva(parada: 'UTEZ, Emiliano Zapata', salida: '07:10'),
      Reserva(parada: 'Casasano', salida: '07:40'),
      Reserva(parada: 'Centro de Cuautla', salida: '08:05'),
      Reserva(
        parada: 'Tres de Mayo',
        salida: '13:20',
        recordatorioActivo: false,
      ),
      Reserva(parada: 'Civac', salida: '14:00'),
      Reserva(
        parada: 'Centro de Cuernavaca',
        salida: '18:15',
        recordatorioActivo: false,
      ),
    ];
  }
}
