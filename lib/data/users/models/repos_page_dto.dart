import 'dart:developer';

class ReposPageDTO {
  int repoCount;

  ReposPageDTO(this.repoCount);

  factory ReposPageDTO.fromJson(List<dynamic> json) => ReposPageDTO(json.length);
}
