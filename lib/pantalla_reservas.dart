import 'dart:core' hide Error;

import 'package:flutter/material.dart';

import 'repositorio_falso.dart';
import 'reserva.dart';
import 'resultado.dart';

class PantallaReservas extends StatefulWidget {
  const PantallaReservas({super.key});

  @override
  State<PantallaReservas> createState() => _PantallaReservasState();
}

class _PantallaReservasState extends State<PantallaReservas> {
  final RepositorioFalso _repositorio = RepositorioFalso();
  Resultado<List<Reserva>> _estado = const Cargando();

  @override
  void initState() {
    super.initState();
    _cargar();
  }

  Future<void> _cargar() async {
    if (_estado is! Cargando) {
      setState(() => _estado = const Cargando());
    }

    try {
      final reservas = await _repositorio.obtener();
      if (!mounted) return;
      setState(() => _estado = Exito(reservas));
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _estado = const Error(
          'No hay conexión. Revisa tu red e intenta de nuevo.',
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reservas del día')),
      body: switch (_estado) {
        Cargando() => const _Cargando(),
        Exito(:final datos) => _Lista(datos),
        Error(:final mensaje) => _Fallo(
          mensaje: mensaje,
          alReintentar: _cargar,
        ),
      },
    );
  }
}

class _Cargando extends StatelessWidget {
  const _Cargando();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Cargando reservas...'),
        ],
      ),
    );
  }
}

class _Lista extends StatelessWidget {
  const _Lista(this.reservas);

  final List<Reserva> reservas;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: reservas.length,
      itemBuilder: (context, indice) {
        return _TarjetaReserva(reservas[indice]);
      },
    );
  }
}

class _TarjetaReserva extends StatelessWidget {
  const _TarjetaReserva(this.reserva);

  final Reserva reserva;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final recordatorio = reserva.recordatorioActivo
        ? 'Recordatorio activo'
        : 'Sin recordatorio';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.directions_bus_outlined,
                  color: tema.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    reserva.parada,
                    style: tema.textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Sale a las ${reserva.salida}'),
            const SizedBox(height: 4),
            Text(recordatorio, style: tema.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class _Fallo extends StatelessWidget {
  const _Fallo({required this.mensaje, required this.alReintentar});

  final String mensaje;
  final Future<void> Function() alReintentar;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.wifi_off, size: 48, color: tema.colorScheme.error),
            const SizedBox(height: 16),
            Text(
              mensaje,
              textAlign: TextAlign.center,
              style: tema.textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: alReintentar,
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }
}
