import 'package:github_repo_plus/data/users/models/user_dto.dart';

class UsersPageDTO {
  List<UserDTO> users;
  UsersPageDTO(this.users);

  factory UsersPageDTO.fromJson(Map<String, dynamic> json) {
    const resultsQualifier = "items";

    if (json[resultsQualifier] != null) {
      return UsersPageDTO(
        List<UserDTO>.generate(
          json[resultsQualifier].length,
          (i) => UserDTO.fromJson(json[resultsQualifier][i]),
        ),
      );
    } else {
      return UsersPageDTO([]);
    }
  }
}
