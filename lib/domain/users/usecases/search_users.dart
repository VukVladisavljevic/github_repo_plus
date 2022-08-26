import 'package:github_repo_plus/domain/users/users_repository.dart';

import '../../../core/util/result.dart';
import '../../use_case.dart';
import '../models/user.dart';

class SearchUsers implements UseCaseParam<List<User>, String> {
  final UsersRepository _usersRepository;

  SearchUsers(this._usersRepository);

  @override
  Future<Result<List<User>>> call(param) async => _usersRepository.searchCoins(param);
}
