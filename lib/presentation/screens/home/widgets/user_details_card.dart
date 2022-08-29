import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:github_repo_plus/domain/users/models/user.dart';
import 'package:github_repo_plus/presentation/shared/constants/string_keys.dart';
import 'package:github_repo_plus/presentation/shared/theme/colors.dart';
import 'package:github_repo_plus/presentation/shared/theme/theme_text_styles.dart';

import '../../../shared/constants/sizes.dart';

class UserDetailsCard extends StatelessWidget {
  final User userData;
  final int repoCount;

  UserDetailsCard(
    this.userData,
    this.repoCount,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: Sizes.padding.small,
        horizontal: Sizes.padding.medium,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: Sizes.misc.cornerRadius,
            backgroundImage: NetworkImage(userData.avatarUrl!),
            backgroundColor: Colors.transparent,
          ),
          SizedBox(width: Sizes.padding.large),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userData.username,
                  style: ThemeTextStyles.headers.large,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
                SizedBox(height: Sizes.padding.extraSmall),
                _buildRepoCount(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRepoCount() {
    // -1 presents the failed fetch request,
    bool requestFailed = repoCount == -1;
    String textValue =
        requestFailed ? StringKeys.requestLimitReached.tr() : "${StringKeys.numberOfPublicRepos.tr()}: $repoCount";
    TextStyle labelStyle =
        requestFailed ? ThemeTextStyles.body.large.copyWith(color: ThemeColors.red) : ThemeTextStyles.body.large;

    return Text(textValue, style: labelStyle);
  }
}
