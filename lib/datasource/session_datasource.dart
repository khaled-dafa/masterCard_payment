import 'package:dio/dio.dart';
import 'package:payment/core/network/api_helper.dart';
import 'package:payment/model/session_model.dart';
import 'package:payment/model/session_response.dart';

class SessionDataSource extends ApiHelper {
  Future<SessionResponse> createSession(SessionModel sessionModel) async {
    try {
      final response = await dio.post(
        'payment/create/session',
        queryParameters: {'apiOperation': 'CREATE_CHECKOUT_SESSION'},
        data: sessionModel.toJson(),
      );
      return SessionResponse.fromJson(response.data);
    } on DioError catch (e) {
      throw Exception('dio error ${e.message}');
    }
  }
}
