import 'package:flutter/material.dart';

typedef RetryCallback = void Function();
typedef ContinueOfflineCallback = void Function();

class OfflineDialog extends StatelessWidget {
  final RetryCallback onRetry;
  final ContinueOfflineCallback onContinueOffline;

  const OfflineDialog({
    super.key,
    required this.onRetry,
    required this.onContinueOffline,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Sin conexión'),
      content: const Text(
        'No detectamos conexión a internet.\n'
        '¿Deseas reintentar la conexión o continuar sin conexión?',
      ),
      actions: [
        TextButton(
          onPressed: onRetry,
          child: const Text('Reintentar'),
        ),
        TextButton(
          onPressed: onContinueOffline,
          child: const Text('Continuar sin conexión'),
        ),
      ],
    );
  }
}
