import 'package:vidres_app/features/godown_transfer/models/godown_dm.dart';
import 'package:vidres_app/services/api_services.dart';
import 'package:vidres_app/utils/helpers/secure_storage_helper.dart';

class IssueGodownRepo {
  static Future<List<GodownDm>> getToGodowns() async {
    String? token = await SecureStorageHelper.read(
      'token',
    );

    try {
      final response = await ApiService.getRequest(
        endpoint: '/Master/ToGodown',
        token: token,
      );
      if (response == null) {
        return [];
      }

      if (response['data'] != null) {
        return (response['data'] as List<dynamic>)
            .map(
              (item) => GodownDm.fromJson(item),
            )
            .toList();
      }

      return [];
    } catch (e) {
      rethrow;
    }
  }
}
