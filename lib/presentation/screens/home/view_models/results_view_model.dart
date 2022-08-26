import 'package:github_repo_plus/domain/users/models/user.dart';
import 'package:github_repo_plus/domain/users/usecases/search_users.dart';

import '../../../../domain/users/usecases/get_repo_count.dart';
import '../../../base/base_view_model.dart';

class ResultsViewModel extends BaseViewModel {
  final SearchUsers searchUsers;
  final GetRepoCount getRepoCount;
  bool get hasError => error != null;
  List<User> users = [];
  // Map<User, int> usersMap = {};

  ResultsViewModel(
    this.searchUsers,
    this.getRepoCount,
  );

  Future<void> searchForUsers(String query) async {
    if (query == '') {
      clearResults();
      return;
    }

    error = null;
    setState(ViewState.Loading);

    var usersFound = await searchUsers(query);

    if (usersFound.isSuccess) {
      users = usersFound.data!;
    } else {
      error = usersFound.error;
    }
    setState(ViewState.Idle);
  }

  void clearResults() {
    users = [];
    setState(ViewState.Idle);
  }

  // void _updateUsers(List<User> users) async {
  //   users.forEach((element) async {
  //     var repos = await getRepoCount(element.reposUrl);
  //     if (repos.isSuccess) {
  //       usersMap[element] = repos.data ?? 0;
  //     } else {
  //       usersMap[element] = 0;
  //     }
  //   });
  //   log(usersMap.toString());
  // }
}
