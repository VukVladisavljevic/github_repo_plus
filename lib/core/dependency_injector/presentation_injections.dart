import 'package:github_repo_plus/presentation/screens/home/view_models/results_view_model.dart';

import '../../main.dart';

void setupInjections() {
  // ViewModels
  getIt.registerSingleton<ResultsViewModel>(ResultsViewModel(getIt(), getIt()));
}
