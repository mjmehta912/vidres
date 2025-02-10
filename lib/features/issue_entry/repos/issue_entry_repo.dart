import 'package:vidres_app/services/api_services.dart';
import 'package:vidres_app/utils/helpers/secure_storage_helper.dart';

class IssueEntryRepo {
  static Future<Map<String, dynamic>> validateIssue({
    required String cardNo,
    required String gdCode,
  }) async {
    String? token = await SecureStorageHelper.read('token');

    try {
      final response = await ApiService.getRequest(
        endpoint: '/MobileEntry/issue',
        queryParams: {
          'CardNo': cardNo,
          'FROMGDCODE': gdCode,
        },
        token: token,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
