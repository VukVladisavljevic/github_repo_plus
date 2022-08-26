import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:github_repo_plus/presentation/screens/home/view_models/results_view_model.dart';
import 'package:github_repo_plus/presentation/screens/home/widgets/user_details_card.dart';
import 'package:github_repo_plus/presentation/base/base_screen_widget.dart';
import 'package:github_repo_plus/presentation/shared/constants/string_keys.dart';
import 'package:github_repo_plus/presentation/shared/theme/theme_text_styles.dart';

import '../../base/base_view.dart';
import '../../shared/theme/colors.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<ResultsViewModel>(
        builder: (context, model, _) => BaseScreenWidget(
              params: BaseScreenParams(
                showDefaultTopBar: true,
                title: StringKeys.title.tr(),
                backgroundColor: ThemeColors.darkBlue,
              ),
              screenContent: _buildContent(model),
            ));
  }

  Widget _buildContent(ResultsViewModel model) {
    return Column(
      children: [
        TextField(
          controller: _textEditingController,
          autofocus: true,
          cursorColor: ThemeColors.darkBlue,
          onChanged: (text) {
            model.searchForUsers(text);
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            filled: true,
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
                      model.clearResults();
                    },
                  )
                : null,
          ),
        ),
        _buildScreenContent(model),
      ],
    );
  }

  Widget _buildScreenContent(ResultsViewModel model) {
    var contentWidget;
    if (model.isLoading) {
      contentWidget = CircularProgressIndicator(
        color: ThemeColors.darkBlue,
      );
    } else if (model.hasError) {
      contentWidget = Text(
        StringKeys.somethingWentWrong.tr(),
        style: ThemeTextStyles.headers.medium.copyWith(color: Colors.redAccent),
      );
    } else {
      if (model.users.length == 0) {
        contentWidget = Text(
          StringKeys.noResults.tr(),
          style: ThemeTextStyles.headers.medium,
        );
      } else {
        contentWidget = ListView.builder(
          physics: BouncingScrollPhysics(),
          addAutomaticKeepAlives: true,
          itemBuilder: (context, index) => UserDetailsCard(model.users[index]),
          itemCount: model.users.length,
          scrollDirection: Axis.vertical,
        );
      }
    }
    return Expanded(
        child: Container(
      color: ThemeColors.darkGrey,
      child: Center(child: contentWidget),
    ));
  }
}
