import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:github_repo_plus/core/util/app_constants.dart';
import 'package:github_repo_plus/presentation/screens/home/home_screen.dart';

import 'core/dependency_injector/data_injections.dart' as dataDi;
import 'core/dependency_injector/domain_injections.dart' as domainDi;
import 'core/dependency_injector/presentation_injections.dart' as presentationDi;

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  dataDi.setupInjections();
  domainDi.setupInjections();
  presentationDi.setupInjections();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en')],
      useOnlyLangCode: true,
      path: AppConstants.translationsPath,
      fallbackLocale: const Locale('en'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        home: HomeScreen(),
      );
}
