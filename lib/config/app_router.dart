import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:geo_snap/di/injection.dart';
import 'package:geo_snap/presentation/pages/home_page.dart';
import 'package:geo_snap/presentation/blocs/photo/photo_bloc.dart';
import 'package:geo_snap/presentation/blocs/camera/camera_bloc.dart';
import 'package:geo_snap/presentation/models/photo_preview_data.dart';
import 'package:geo_snap/presentation/pages/gallery/gallery_list_page.dart';
import 'package:geo_snap/presentation/pages/cameras/photo_preview_page.dart';
import 'package:geo_snap/presentation/pages/cameras/camera_preview_page.dart';
import 'package:geo_snap/presentation/pages/gallery/photo_gallery_detail.dart';

import 'route_constants.dart';

final appRouter = GoRouter(
  initialLocation: RoutePaths.home,
  routes: [
    GoRoute(
      path: RoutePaths.home,
      name: RouteNames.home,
      builder: (context, state) {
        return const HomePage();
      },
    ),
    GoRoute(
      path: RoutePaths.camera,
      name: RouteNames.camera,
      builder: (context, state) => BlocProvider(
        create: (_) => sl<CameraBloc>(),
        child: CameraPreviewPage(),
      ),
      routes: [
        GoRoute(
          path: RoutePaths.cameraPreview,
          name: RouteNames.cameraPreview,
          builder: (context, state) {
            final extra = state.extra as PhotoPreviewData;
            return BlocProvider(
              create: (_) => sl<PhotoBloc>(),
              child: PhotoPreviewPage(data: extra),
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: RoutePaths.gallery,
      name: RouteNames.gallery,
      builder: (context, state) => BlocProvider(
        create: (_) => sl<PhotoBloc>()..add(LoadPhotosEvent()),
        child: GalleryListPage(),
      ),
      routes: [
        GoRoute(
          path: RoutePaths.photoDetail,
          name: RouteNames.photoDetail,
          builder: (context, state) {
            final photoId = state.pathParameters['id']!;
            return BlocProvider(
              create: (_) => sl<PhotoBloc>()..add(LoadPhotoByIdEvent(photoId)),
              child: PhotoGalleryDetail(photoId: photoId),
            );
          },
        ),
      ],
    ),
  ],
);
