import 'package:github_repo_plus/domain/users/models/user.dart';
import 'package:github_repo_plus/domain/users/usecases/search_users.dart';

import '../../../../domain/users/usecases/get_repo_count.dart';
import '../../../base/base_view_model.dart';

class ResultsViewModel extends BaseViewModel {
  final SearchUsers searchUsers;
  final GetRepoCount getRepoCount;

  Map<User, int> usersMap = {};

  bool get hasError => error != null;

  ResultsViewModel(
    this.searchUsers,
    this.getRepoCount,
  );

  Future<void> searchForUsers(String query) async {
    if (query.isEmpty) {
      return;
    }

    error = null;
    setState(ViewState.Loading);

    var usersFound = await searchUsers(query);

    if (usersFound.isSuccess) {
      usersMap = await _updateUsers(usersFound.data);
      setState(ViewState.Idle);
    } else {
      error = usersFound.error;
      setState(ViewState.Failed);
    }
  }

  void clearResults() {
    usersMap.clear();
    setState(ViewState.Idle);
  }

  Future<Map<User, int>> _updateUsers(List<User>? users) async {
    Map<User, int> newMap = {};
    if (users == null || users.length == 0) {
      return {};
    }

    for (var user in users) {
      var reposCount = await getRepoCount(user.username);
      if (reposCount.isSuccess) {
        newMap[user] = reposCount.data ?? 0;
      } else {
        newMap[user] = -1;
      }
    }

    return newMap;
  }
}
