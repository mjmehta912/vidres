import 'package:vidres_app/features/wip_entry/models/item_silo_wise_dm.dart';
import 'package:vidres_app/features/wip_entry/models/loading_point_dm.dart';
import 'package:vidres_app/features/wip_entry/models/silo_dm.dart';
import 'package:vidres_app/features/wip_entry/models/silo_type_dm.dart';
import 'package:vidres_app/services/api_services.dart';
import 'package:vidres_app/utils/helpers/secure_storage_helper.dart';

class WipEntryRepo {
  static Future<List<LoadingPointDm>> getLoadingPoints() async {
    String? token = await SecureStorageHelper.read(
      'token',
    );

    try {
      final response = await ApiService.getRequest(
        endpoint: '/Master/loadingPoint',
        token: token,
      );
      if (response == null) {
        return [];
      }

      if (response['data'] != null) {
        return (response['data'] as List<dynamic>)
            .map(
              (item) => LoadingPointDm.fromJson(item),
            )
            .toList();
      }

      return [];
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<SiloTypeDm>> getSiloTypes() async {
    String? token = await SecureStorageHelper.read(
      'token',
    );

    try {
      final response = await ApiService.getRequest(
        endpoint: '/Master/siloType',
        token: token,
      );
      if (response == null) {
        return [];
      }

      if (response['data'] != null) {
        return (response['data'] as List<dynamic>)
            .map(
              (item) => SiloTypeDm.fromJson(item),
            )
            .toList();
      }

      return [];
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<SiloDm>> getSilos({
    required String siloTypeCode,
    required String lpCode,
  }) async {
    String? token = await SecureStorageHelper.read(
      'token',
    );

    try {
      final response = await ApiService.getRequest(
        endpoint: '/Master/silo',
        queryParams: {
          'SiloTypeCode': siloTypeCode,
          'LPCODE': lpCode,
        },
        token: token,
      );
      if (response == null) {
        return [];
      }

      if (response['data'] != null) {
        return (response['data'] as List<dynamic>)
            .map(
              (item) => SiloDm.fromJson(item),
            )
            .toList();
      }

      return [];
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<ItemSiloWiseDm>> getItemsSiloWise(
      {required String siloCode}) async {
    String? token = await SecureStorageHelper.read(
      'token',
    );

    try {
      final response = await ApiService.getRequest(
        endpoint: '/Master/item',
        queryParams: {
          'SiloCode': siloCode,
        },
        token: token,
      );
      if (response == null) {
        return [];
      }

      if (response['data'] != null) {
        return (response['data'] as List<dynamic>)
            .map(
              (item) => ItemSiloWiseDm.fromJson(item),
            )
            .toList();
      }

      return [];
    } catch (e) {
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> validateWip({
    required String cardNo,
  }) async {
    String? token = await SecureStorageHelper.read('token');

    try {
      final response = await ApiService.getRequest(
        endpoint: '/MobileEntry/validateWip',
        queryParams: {
          'CardNo': cardNo,
        },
        token: token,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> saveWipEntry({
    required String iCode,
    required String lpCode,
    required String siloCode,
    required List<Map<String, dynamic>> cards,
  }) async {
    String? token = await SecureStorageHelper.read(
      'token',
    );

    try {
      final Map<String, dynamic> requestBody = {
        'ICODE': iCode,
        'LPCODE': lpCode,
        'SILOCODE': siloCode,
        'CARDS': cards,
      };

      print(requestBody);

      var response = await ApiService.postRequest(
        endpoint: '/MobileEntry/wip',
        requestBody: requestBody,
        token: token,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
