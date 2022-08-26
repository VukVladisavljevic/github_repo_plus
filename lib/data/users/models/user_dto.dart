import 'package:github_repo_plus/domain/users/models/user.dart';

class UserDTO extends User {
  const UserDTO({
    required super.id,
    required super.username,
    required super.reposUrl,
    super.avatarUrl,
  });

  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
      id: json["id"],
      username: json["login"],
      avatarUrl: json["avatar_url"],
      reposUrl: json["repos_url"],
    );
  }
}
