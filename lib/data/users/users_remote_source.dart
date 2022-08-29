import 'package:github_repo_plus/data/users/models/user_dto.dart';
import 'package:github_repo_plus/data/users/models/users_page_dto.dart';

import '../base/base_remote_source.dart';

abstract class UsersRemoteSource {
  Future<List<UserDTO>> searchUsers(String byString);
  Future<int> getRepoCount(String fromUrl);
}

class UsersRemoteSourceImpl extends BaseRemoteSource implements UsersRemoteSource {
  final usersPerQueryLimit = 6;
  final publicReposCountQualifier = 'public_repos';

  @override
  Future<List<UserDTO>> searchUsers(String byString) async {
    UsersPageDTO result = await execute(
      RequestType.Get,
      "$githubAPI/search/users?q=$byString+in:login",
      jsonMapper: (json) => UsersPageDTO.fromJson(json),
    );

    // As I was unable to further narrow search by query parameters,
    // limiting size of results array seemed like a best way to lower number of requests to /search/users
    if (result.users.length > usersPerQueryLimit) {
      return result.users.sublist(0, usersPerQueryLimit);
    }
    return result.users;
  }

  @override
  Future<int> getRepoCount(String forUser) async {
    Map<String, dynamic> result = await execute(
      RequestType.Get,
      "$githubAPI/users/$forUser",
    );

    return result[publicReposCountQualifier];
  }
}
