import 'package:payment/model/session_model.dart';
import 'package:payment/model/session_response.dart';
import 'package:payment/repository/session_repository.dart';

class UseCaseSession {
  final SessionRepoImp sessionRepoImp;

  UseCaseSession(this.sessionRepoImp);

  Future<SessionResponse> callCreateSession(SessionModel sessionModel) async =>
      await sessionRepoImp.createSession(sessionModel);
}
