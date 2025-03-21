import 'package:vidres_app/features/user_settings/user_rights/models/user_access_dm.dart';
import 'package:vidres_app/services/api_services.dart';
import 'package:vidres_app/utils/helpers/secure_storage_helper.dart';

class HomeRepo {
  static Future<UserAccessDm> getUserAccess({
    required int userId,
  }) async {
    String? token = await SecureStorageHelper.read('token');

    try {
      final response = await ApiService.getRequest(
        endpoint: '/User/userAccess',
        queryParams: {
          'userId': userId.toString(),
        },
        token: token,
      );

      if (response == null) {
        return UserAccessDm(
          menuAccess: [],
          ledgerDate: LedgerDateDm(
            ledgerStart: '',
            ledgerEnd: '',
          ),
        );
      }

      return UserAccessDm.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
