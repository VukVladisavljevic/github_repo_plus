import 'package:flutter/material.dart';
import 'package:github_repo_plus/presentation/shared/theme/colors.dart';

class BaseScreenParams {
  final String? title;
  final List<Widget>? appBarActions;
  final bool showDefaultTopBar;
  final double? topPadding;
  final Color? backgroundColor;

  const BaseScreenParams({
    this.title,
    this.appBarActions,
    this.showDefaultTopBar = true,
    this.backgroundColor,
    this.topPadding,
  });
}

class BaseScreenWidget extends StatelessWidget {
  final BaseScreenParams params;
  final Widget screenContent;

  const BaseScreenWidget({
    this.params = const BaseScreenParams(),
    required this.screenContent,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _buildAppBar(context),
        backgroundColor: ThemeColors.darkGrey,
        body: Padding(
          padding: EdgeInsets.only(top: params.topPadding ?? 0),
          child: screenContent,
        ),
      );

  AppBar? _buildAppBar(BuildContext context) {
    return AppBar(
      title: params.title != null ? Text(params.title!) : null,
      elevation: 0.0,
      automaticallyImplyLeading: true,
      actions: params.appBarActions,
      backgroundColor: params.backgroundColor,
    );
  }
}
