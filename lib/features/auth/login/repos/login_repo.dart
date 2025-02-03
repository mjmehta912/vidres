import 'package:vidres_app/features/auth/login/models/company_dm.dart';
import 'package:vidres_app/services/api_services.dart';

class LoginRepo {
  static Future<List<CompanyDm>> loginUser({
    required String mobileNo,
    required String password,
    required String fcmToken,
    required String deviceId,
  }) async {
    final Map<String, dynamic> requestBody = {
      'mobileNo': mobileNo,
      'password': password,
      'FCMToken': fcmToken,
      'DeviceID': deviceId,
    };

    try {
      var response = await ApiService.postRequest(
        endpoint: '/Auth/login',
        requestBody: requestBody,
      );

      if (response != null && response['company'] != null) {
        return (response['company'] as List<dynamic>)
            .map(
              (companyJson) => CompanyDm.fromJson(companyJson),
            )
            .toList();
      }

      return [];
    } catch (e) {
      rethrow;
    }
  }
}
