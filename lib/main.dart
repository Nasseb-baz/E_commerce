import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/api/api_client.dart';
import 'core/routes/app_routes.dart';
import 'core/storage/token_storage.dart';
import 'features/auth/data/repositories/auth_repository.dart';
import 'features/auth/data/services/auth_api_service.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => AuthRepository(
        apiService: AuthApiService(ApiClient()),
        tokenStorage: TokenStorage(),
      ),
      child: BlocProvider(
        create: (context) => AuthBloc(
          context.read<AuthRepository>(),
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'E-Commerce App',
          theme: ThemeData(
            fontFamily: 'Arial',
            scaffoldBackgroundColor: Colors.white,
          ),
          initialRoute: AppRoutes.onboarding,
          routes: AppRoutes.routes,
        ),
      ),
    );
  }
}