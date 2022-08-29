import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:github_repo_plus/presentation/screens/home/view_models/results_view_model.dart';
import 'package:github_repo_plus/presentation/screens/home/widgets/user_details_card.dart';
import 'package:github_repo_plus/presentation/base/base_screen_widget.dart';
import 'package:github_repo_plus/presentation/shared/constants/string_keys.dart';
import 'package:github_repo_plus/presentation/shared/theme/theme_text_styles.dart';

import '../../base/base_view.dart';
import '../../base/base_view_model.dart';
import '../../shared/theme/colors.dart';

class ResultsScreen extends StatefulWidget {
  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  Timer? _debounce;
  Duration _debounceDuration = Duration(milliseconds: 750);

  @override
  Widget build(BuildContext context) {
    return BaseView<ResultsViewModel>(builder: (context, model, _) {
      return BaseScreenWidget(
        params: BaseScreenParams(
          showDefaultTopBar: true,
          title: StringKeys.title.tr(),
          backgroundColor: ThemeColors.darkBlue,
        ),
        screenContent: _buildScreenContent(model),
      );
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  Widget _buildScreenContent(ResultsViewModel viewModel) {
    return Column(
      children: [
        TextField(
          controller: _textEditingController,
          autofocus: true,
          cursorColor: ThemeColors.darkBlue,
          onChanged: (query) {
            if (query.isEmpty) {
              viewModel.clearResults();
            }

            if (_debounce?.isActive ?? false) _debounce!.cancel();
            _debounce = Timer(_debounceDuration, () {
              viewModel.searchForUsers(query);
            });
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            filled: true,
            fillColor: Colors.white,
            hintText: StringKeys.searchFieldHint.tr(),
            prefixIcon: Icon(
              Icons.search,
              color: ThemeColors.darkBlue,
            ),
            suffixIcon: _textEditingController.text.length > 0
                ? IconButton(
                    icon: Icon(
                      Icons.close,
                      color: ThemeColors.darkBlue,
                    ),
                    onPressed: () {
                      _textEditingController.clear();
                      viewModel.clearResults();
                    },
                  )
                : null,
          ),
        ),
        _buildResults(viewModel),
      ],
    );
  }

  Widget _buildResults(ResultsViewModel viewModel) {
    var contentWidget;

    switch (viewModel.state) {
      case ViewState.Loading:
        contentWidget = CircularProgressIndicator(
          color: ThemeColors.darkBlue,
        );
        break;

      case ViewState.Failed:
        contentWidget = Text(
          StringKeys.somethingWentWrong.tr(),
          style: ThemeTextStyles.headers.medium.copyWith(color: ThemeColors.red),
        );
        break;
      case ViewState.Idle:
        if (viewModel.usersMap.length == 0) {
          contentWidget = Text(
            StringKeys.noResults.tr(),
            style: ThemeTextStyles.headers.medium,
          );
        } else {
          contentWidget = ListView.builder(
            physics: BouncingScrollPhysics(),
            addAutomaticKeepAlives: true,
            itemBuilder: (context, index) {
              var user = viewModel.usersMap.keys.elementAt(index);
              return UserDetailsCard(user, viewModel.usersMap[user]!);
            },
            itemCount: viewModel.usersMap.length,
            scrollDirection: Axis.vertical,
          );
        }
        break;
    }

    return Expanded(
      child: Container(
        color: ThemeColors.darkGrey,
        child: Center(child: contentWidget),
      ),
    );
  }
}
