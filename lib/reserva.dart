class Reserva {
  const Reserva({
    required this.parada,
    required this.salida,
    this.recordatorioActivo = true,
  });

  final String parada;
  final String salida;

  // En Ajustes se puede apagar el recordatorio de la salida, por eso tiene valor por defecto
  final bool recordatorioActivo;
}
