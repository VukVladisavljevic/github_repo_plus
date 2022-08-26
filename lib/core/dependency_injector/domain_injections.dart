import 'package:github_repo_plus/domain/users/usecases/get_repo_count.dart';
import 'package:github_repo_plus/domain/users/usecases/search_users.dart';

import '../../main.dart';

void setupInjections() {
  getIt.registerFactory<SearchUsers>(() => SearchUsers(getIt()));
  getIt.registerFactory<GetRepoCount>(() => GetRepoCount(getIt()));
}
