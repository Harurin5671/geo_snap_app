import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:geo_snap/config/route_constants.dart';
import 'package:geo_snap/domain/entities/entities.dart';
import 'package:geo_snap/core/services/navigation_service.dart';
import 'package:geo_snap/presentation/blocs/photo/photo_bloc.dart';
import 'package:geo_snap/presentation/models/photo_preview_data.dart';

class PhotoPreviewPage extends StatelessWidget {
  final PhotoPreviewData data;

  const PhotoPreviewPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PhotoBloc, PhotoState>(
      listener: (context, state) {
        if (state is PhotoSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('¡Foto guardada correctamente! ✅')),
          );
          Future.delayed(const Duration(milliseconds: 600), () {
            NavigationService().goNamed(RouteNames.home);
          });
        }

        if (state is PhotoError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al guardar: ${state.error} ❌')),
          );
          Future.delayed(const Duration(milliseconds: 900), () {
            NavigationService().goNamed(RouteNames.home);
          });
        }
      },
      child: Scaffold(body: _PhotoPreviewBody(data: data)),
    );
  }
}

class _PhotoPreviewBody extends StatelessWidget {
  final PhotoPreviewData data;

  const _PhotoPreviewBody({required this.data});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotoBloc, PhotoState>(
      builder: (context, state) {
        final isLoading = state is PhotoLoading;
        return Stack(
          children: [
            Column(
              children: [
                Expanded(child: Image.file(File(data.photo.path))),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'Ubicación: ${data.position.latitude}, ${data.position.longitude}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: isLoading
                          ? null
                          : () {
                              NavigationService().goBack();
                            },
                      icon: const Icon(Icons.close, color: Colors.white),
                      label: const Text('Cancelar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14,
                        ),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: isLoading
                          ? null
                          : () {
                              final newPhoto = PhotoEntity.newEntry(
                                path: data.photo.path,
                                latitude: data.position.latitude,
                                longitude: data.position.longitude,
                              );
                              context.read<PhotoBloc>().add(
                                SavePhotoEvent(newPhoto),
                              );
                            },
                      icon: isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.check, color: Colors.white),
                      label: const Text('Aceptar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14,
                        ),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
            // Loader flotante (opcional)
            if (isLoading)
              Container(
                color: Colors.black45,
                child: const Center(child: CircularProgressIndicator()),
              ),
          ],
        );
      },
    );
  }
}
