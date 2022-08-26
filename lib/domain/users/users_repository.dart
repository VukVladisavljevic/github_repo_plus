import 'package:github_repo_plus/domain/users/models/user.dart';

import '../../core/util/result.dart';

abstract class UsersRepository {
  Future<Result<List<User>>> searchCoins(String byString);
  Future<Result<int>> getRepoCount(String fromUrl);
}
