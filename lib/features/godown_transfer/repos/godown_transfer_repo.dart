import 'package:vidres_app/features/godown_transfer/models/godown_dm.dart';
import 'package:vidres_app/features/godown_transfer/models/godown_location_dm.dart';
import 'package:vidres_app/features/godown_transfer/models/item_dm.dart';
import 'package:vidres_app/services/api_services.dart';
import 'package:vidres_app/utils/helpers/secure_storage_helper.dart';

class GodownTransferRepo {
  static Future<List<ItemDm>> getAllItems() async {
    String? token = await SecureStorageHelper.read(
      'token',
    );

    try {
      final response = await ApiService.getRequest(
        endpoint: '/Master/items',
        token: token,
      );
      if (response == null) {
        return [];
      }

      if (response['data'] != null) {
        return (response['data'] as List<dynamic>)
            .map(
              (item) => ItemDm.fromJson(item),
            )
            .toList();
      }

      return [];
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<GodownDm>> getFromGodowns({
    required String iCode,
  }) async {
    String? token = await SecureStorageHelper.read(
      'token',
    );

    try {
      final response = await ApiService.getRequest(
        endpoint: '/Master/FromGodown',
        queryParams: {
          'ICODE': iCode,
        },
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

  static Future<List<GodownLocationDm>> getToGodownLocation({
    required String toGodownLocationCode,
  }) async {
    String? token = await SecureStorageHelper.read(
      'token',
    );

    try {
      final response = await ApiService.getRequest(
        endpoint: '/Master/ToGodownLocation',
        queryParams: {
          'GDCODE': toGodownLocationCode,
        },
        token: token,
      );
      if (response == null) {
        return [];
      }

      if (response['data'] != null) {
        return (response['data'] as List<dynamic>)
            .map(
              (item) => GodownLocationDm.fromJson(item),
            )
            .toList();
      }

      return [];
    } catch (e) {
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> validateGodownTransfer({
    required String cardNo,
    required String fromGodownCode,
  }) async {
    String? token = await SecureStorageHelper.read('token');

    try {
      final response = await ApiService.getRequest(
        endpoint: '/MobileEntry/validateGdTrans',
        queryParams: {
          'CardNo': cardNo,
          'FROMGDCODE': fromGodownCode,
        },
        token: token,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> saveGodownTransferEntry({
    required String iCode,
    required String fromGdCode,
    required String toGdCode,
    required String toGdCodeLocation,
    required List<Map<String, dynamic>> cards,
  }) async {
    String? token = await SecureStorageHelper.read(
      'token',
    );

    try {
      final Map<String, dynamic> requestBody = {
        'ICODE': iCode,
        'FROMGDCODE': fromGdCode,
        'TOGDCODE': toGdCode,
        'GDLOCATION': toGdCodeLocation,
        'CARDS': cards,
      };

      var response = await ApiService.postRequest(
        endpoint: '/MobileEntry/godownTransfer',
        requestBody: requestBody,
        token: token,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
