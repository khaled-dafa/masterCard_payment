import 'package:get_it/get_it.dart';
import 'package:payment/datasource/session_datasource.dart';
import 'package:payment/repository/session_repository.dart';
import 'package:payment/usecase/usecase_session.dart';

final GetIt getIt = GetIt.instance;

init() async {
  getIt.registerLazySingleton<SessionDataSource>(() => SessionDataSource());
  getIt.registerLazySingleton<SessionRepoImp>(() => SessionRepoImp(getIt()));
  getIt.registerLazySingleton<UseCaseSession>(() => UseCaseSession(getIt()));
}
