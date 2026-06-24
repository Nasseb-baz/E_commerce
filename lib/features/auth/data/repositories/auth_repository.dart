import '../../../../core/storage/token_storage.dart';
import '../services/auth_api_service.dart';

class AuthRepository {
  final AuthApiService apiService;
  final TokenStorage tokenStorage;

  AuthRepository({
    required this.apiService,
    required this.tokenStorage,
  });

  Future<Map<String, dynamic>> login({
    required String phone,
    required String password,
  }) async {
    final data = await apiService.login(
      phone: phone,
      password: password,
    );

    final token = data['token'];

    if (token != null) {
      await tokenStorage.saveToken(token.toString());
    }

    return data;
  }

  Future<void> register({
    required String name,
    required String phone,
    required String password,
  }) async {
    await apiService.register(
      name: name,
      phone: phone,
      password: password,
    );
  }

  Future<Map<String, dynamic>> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    final data = await apiService.verifyOtp(
      phone: phone,
      otp: otp,
    );

    final token = data['token'];

    if (token != null) {
      await tokenStorage.saveToken(token.toString());
    }

    return data;
  }
}