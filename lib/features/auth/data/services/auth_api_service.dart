import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_constants.dart';

class AuthApiService {
  final ApiClient apiClient;

  AuthApiService(this.apiClient);

  Future<Map<String, dynamic>> login({
    required String phone,
    required String password,
  }) {
    return apiClient.post(
      ApiConstants.login,
      body: {
        'phone': phone,
        'password': password,
      },
    );
  }

  Future<Map<String, dynamic>> register({
    required String name,
    required String phone,
    required String password,
  }) {
    return apiClient.post(
      ApiConstants.register,
      body: {
        'name': name,
        'phone': phone,
        'password': password,
      },
    );
  }

  Future<Map<String, dynamic>> verifyOtp({
    required String phone,
    required String otp,
  }) {
    return apiClient.post(
      ApiConstants.verifyOtp,
      body: {
        'phone': phone,
        'otp': otp,
      },
    );
  }
}