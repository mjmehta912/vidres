import 'package:vidres_app/services/api_services.dart';

class ResetPasswordRepo {
  static Future<dynamic> resetPassword({
    required String mobileNo,
    required String password,
  }) async {
    final Map<String, dynamic> requestBody = {
      'mobileNo': mobileNo,
      'password': password,
    };

    try {
      var response = await ApiService.postRequest(
        endpoint: '/Auth/reset',
        requestBody: requestBody,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
