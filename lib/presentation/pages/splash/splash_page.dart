import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:geo_snap/config/route_constants.dart';
import 'package:geo_snap/core/services/services.dart';
import 'package:geo_snap/application/app_init/bloc/app_init_bloc.dart';
import 'package:geo_snap/presentation/widgets/offline_dialog.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AppInitBloc, AppInitState>(
        listener: (context, state) {
          if (state is AppInitSuccess) {
            context.goNamed(RouteNames.home);
          }
          if (state is AppInitOffline) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => OfflineDialog(
                onRetry: () {
                  NavigationService().pop();
                  context.read<AppInitBloc>().add(AppInitStartedEvent());
                },
                onContinueOffline: () {
                  NavigationService().pop();
                  context.goNamed(RouteNames.home);
                },
              ),
            );
          }
        },
        builder: (context, state) {
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
