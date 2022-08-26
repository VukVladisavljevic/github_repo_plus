import 'package:github_repo_plus/core/util/logger.dart';
import 'package:github_repo_plus/data/users/users_remote_source.dart';
import 'package:github_repo_plus/data/users/users_repository_impl.dart';
import 'package:github_repo_plus/domain/users/users_repository.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

import '../../data/base/http_interceptor.dart';
import '../../main.dart';

void setupInjections() {
  // Utils
  getIt.registerSingleton<Logger>(LoggerImpl());
  getIt.registerSingleton<Client>(InterceptedClient.build(interceptors: [HttpInterceptor(getIt())]));

  // Remote sources
  getIt.registerSingleton<UsersRemoteSource>(UsersRemoteSourceImpl());

  // Repository implementations
  getIt.registerSingleton<UsersRepository>(UsersRepositoryImpl(getIt()));
}
