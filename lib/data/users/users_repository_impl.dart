import 'package:github_repo_plus/core/util/result.dart';
import 'package:github_repo_plus/data/base/base_repository.dart';
import 'package:github_repo_plus/data/users/users_remote_source.dart';
import 'package:github_repo_plus/domain/users/models/user.dart';

import '../../domain/users/users_repository.dart';

class UsersRepositoryImpl extends BaseRepository implements UsersRepository {
  final UsersRemoteSource _usersRemoteSource;

  UsersRepositoryImpl(this._usersRemoteSource);

  @override
  Future<Result<List<User>>> searchCoins(String byString) =>
      resolveResultAsync(_usersRemoteSource.searchUsers(byString));

  @override
  Future<Result<int>> getRepoCount(String fromUrl) => resolveResultAsync(_usersRemoteSource.getRepoCount(fromUrl));
}
