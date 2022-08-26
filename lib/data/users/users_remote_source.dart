import 'dart:developer';

import 'package:github_repo_plus/data/users/models/repos_page_dto.dart';
import 'package:github_repo_plus/data/users/models/user_dto.dart';
import 'package:github_repo_plus/data/users/models/users_page_dto.dart';

import '../base/base_remote_source.dart';

abstract class UsersRemoteSource {
  Future<List<UserDTO>> searchUsers(String byString);
  Future<int> getRepoCount(String fromUrl);
}

class UsersRemoteSourceImpl extends BaseRemoteSource implements UsersRemoteSource {
  @override
  Future<List<UserDTO>> searchUsers(String byString) async {
    UsersPageDTO result = await execute(
      RequestType.Get,
      "$githubAPI/search/users?q=$byString",
      (json) => UsersPageDTO.fromJson(json),
    );
    return result.users;
  }

  @override
  Future<int> getRepoCount(String fromUrl) async {
    ReposPageDTO result = await execute(
      RequestType.Get,
      fromUrl,
      (json) => ReposPageDTO.fromJson(json),
    );
    log(result.repoCount.toString());
    return result.repoCount;
  }
}
