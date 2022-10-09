import 'package:payment/datasource/session_datasource.dart';
import 'package:payment/model/session_model.dart';
import 'package:payment/model/session_response.dart';

class SessionRepoImp {
  final SessionDataSource sessionDataSource;

  SessionRepoImp(this.sessionDataSource);

  Future<SessionResponse> createSession(SessionModel sessionModel) async {
    try {
      final response = await sessionDataSource.createSession(sessionModel);
      return response;
    } catch (e) {
      throw Exception('${e}');
    }
  }
}
