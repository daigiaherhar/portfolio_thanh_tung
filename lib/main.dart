import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_i18n/loaders/file_translation_loader.dart';
import 'package:flutter_i18n/loaders/network_file_translation_loader.dart';
import 'package:portfolio_thanh_tung/global_blocs/language/language_cubit.dart';

import 'constants/constants.dart';
import 'global_blocs/language/language_state.dart';
import 'modules/dashboard/dashboard_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return MultiBlocProvider(
      providers: [BlocProvider<LanguageCubit>(create: (_) => LanguageCubit())],
      child: BlocListener<LanguageCubit, LanguageState>(
        listener: (context, state) async {
          switch (state.status) {
            case LanguageStatus.en:
              await FlutterI18n.refresh(context, Locale("en"));
            case LanguageStatus.vi:
              await FlutterI18n.refresh(context, Locale("vi"));
          }
        },
        child: BlocBuilder<LanguageCubit, LanguageState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              locale: Locale(state.status.name),
              supportedLocales: [Locale("en"), Locale("vi")],
              localizationsDelegates: [
                FlutterI18nDelegate(
                  translationLoader: NetworkFileTranslationLoader(
                    baseUri: Uri.https("daigiaherhar.github.io", "/portfolio_data/"),
                    // forcedLocale: Locale("en"),

                    // useCountryCode: true
                  ),
                  missingTranslationHandler: (key, locale) {
                    print(
                      "--- Missing Key: $key, languageCode: ${locale?.toString()}",
                    );
                    debugPrint(
                      '--- Missing Key: $key, languageCode: ${locale?.languageCode}',
                    );
                  },
                ),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              scrollBehavior: MyCustomScrollBehavior(), //
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              ),
              home: DashboardPage(),
            );
          },
        ),
      ),
    );
  }
}

// ✅ Fix scroll trên Web (hỗ trợ chuột & trackpad)
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse, // Hỗ trợ chuột
    PointerDeviceKind.trackpad, // Hỗ trợ trackpad
  };
}