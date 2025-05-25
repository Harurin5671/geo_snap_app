import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:geo_snap/presentation/blocs/photo/photo_bloc.dart';

class PhotoGalleryDetail extends StatelessWidget {
  final String photoId;

  const PhotoGalleryDetail({super.key, required this.photoId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Photo Detail')),
      body: BlocBuilder<PhotoBloc, PhotoState>(
        builder: (context, state) {
          if (state is PhotoLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PhotoDetailLoaded) {
            final photo = state.photo;
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.file(
                    File(photo.path),
                    // height: 300,
                    width: double.infinity,
                    frameBuilder:
                        (context, child, frame, wasSynchronouslyLoaded) {
                          if (wasSynchronouslyLoaded || frame != null) {
                            return child;
                          }
                          return const SizedBox(
                            height: 250,
                            child: Center(child: CircularProgressIndicator()),
                          );
                        },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 250,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(
                            Icons.broken_image,
                            size: 48,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    },
                  ),
                  Text(
                    'Latitude: ${photo.latitude}\nLongitude: ${photo.longitude}',
                  ),
                ],
              ),
            );
          }

          if (state is PhotoError) {
            return Center(child: Text(state.error));
          }

          return const Center(child: Text('Esperando datos...'));
        },
      ),
    );
  }
}
