import 'package:flutter/material.dart';
import 'package:github_repo_plus/domain/users/models/user.dart';
import 'package:github_repo_plus/presentation/shared/theme/theme_text_styles.dart';

import '../../../shared/constants/sizes.dart';

class UserDetailsCard extends StatelessWidget {
  final User userData;

  UserDetailsCard(this.userData);
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userData.username,
                style: ThemeTextStyles.headers.medium,
              ),
              SizedBox(height: Sizes.padding.extraSmall),
              Text(
                userData.id.toString(),
                style: ThemeTextStyles.body.medium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
