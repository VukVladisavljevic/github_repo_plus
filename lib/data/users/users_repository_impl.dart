import 'package:github_repo_plus/data/base/base_repository.dart';
import 'package:github_repo_plus/data/users/users_remote_source.dart';

import '../../domain/users/users_repository.dart';

class UsersRepositoryImpl extends BaseRepository implements UsersRepository {
  final UsersRemoteSource _usersRemoteSource;

  UsersRepositoryImpl(this._usersRemoteSource);
}
