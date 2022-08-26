import 'package:github_repo_plus/domain/users/users_repository.dart';

import '../../../core/util/result.dart';
import '../../use_case.dart';

class GetRepoCount implements UseCaseParam<int, String> {
  final UsersRepository _usersRepository;

  GetRepoCount(this._usersRepository);

  @override
  Future<Result<int>> call(param) async => _usersRepository.getRepoCount(param);
}
