import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:geo_snap/config/route_constants.dart';
import 'package:geo_snap/core/services/navigation_service.dart';
import 'package:geo_snap/presentation/blocs/photo/photo_bloc.dart';

class GalleryListPage extends StatelessWidget {
  const GalleryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Photo Gallery')),
      body: BlocBuilder<PhotoBloc, PhotoState>(
        builder: (context, state) {
          if (state is PhotoLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PhotoLoaded) {
            return ListView.builder(
              itemCount: state.photos.length,
              itemBuilder: (context, index) {
                final photo = state.photos[index];
                return ListTile(
                  title: Text(photo.id),
                  subtitle: Text(
                    '${photo.latitude.toString()}, ${photo.longitude.toString()}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.navigate_next_rounded),
                    onPressed: () {
                      NavigationService().pushNamed(
                        RouteNames.photoDetail,
                        parameters: { 'id': photo.id},
                      );
                    },
                  ),
                );
              },
            );
          }

          if (state is PhotoEmpty) {
            return const Center(child: Text('No hay fotos, por favor toma una foto'));
          }

          if (state is PhotoError) {
            return Center(child: Text(state.error));
          }

          return const Center(child: Text('Photo Gallery'));
        },
      ),
    );
  }
}
