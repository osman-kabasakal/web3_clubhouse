import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:web3_clubhouse/constants/DecorationConstants.dart';
import 'package:web3_clubhouse/core/localizations/AppLocalizationTags.dart';
import 'package:web3_clubhouse/utils/helpers/di_helpers.dart';
import 'package:web3_clubhouse/utils/helpers/route_helpers.dart';

import 'config/app_config.dart';
import 'constants/SvgConstants.dart';
import 'core/bloc/bloc_provider.dart';
import 'core/bloc/reactive_variebles.dart';
import 'core/di/di_level.dart';
import 'core/domain/context/context.dart';
import 'core/localizations/AppLocations.dart';

class AppStarter extends StatelessWidget {
  const AppStarter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: ReactiveVariebles(),
      child: DiLevel(
        order: 1,
        child: (chCtx) => DiLevel(
            order: 2,
            child: (context3) => DiLevel(
                    order: 3,
                    child: (context4) => DiLevel(
                          order: 4,
                          child: (context5) => DiLevel(
                              order: 5,
                              child: (context6) => MaterialApp(
                                    title: AppLocations.of(context6)?.translate(AppLocalizationTags.homeTitle)??"",
                                    locale: const Locale("tr", "TR"),
                                    // localeResolutionCallback:
                                    //     (locale, supportedLocales) {
                                    //   return const Locale("tr", "TR");
                                    // },
                                    // localeListResolutionCallback:
                                    //     (locales, supportedLocales) {
                                    //       return const Locale("tr", "TR");
                                    //     },
                                    supportedLocales: const [
                                      Locale("tr", "TR"),
                                      Locale("en", "US")
                                    ],
                                    localizationsDelegates: const [
                                      AppLocations.delegate,
                                      GlobalMaterialLocalizations.delegate,
                                      GlobalWidgetsLocalizations.delegate,
                                      GlobalCupertinoLocalizations.delegate,
                                    ],
                                    // initialRoute: Routes.login,
                                    onGenerateRoute: (settings) {
                                      if (ModalRoute.of(context)
                                              ?.settings
                                              .name ==
                                          settings.name) {
                                        return null;
                                      }
                                      return settings.getRoute();
                                    },
                                  ),
                              depends: []),
                          depends: [
                            // (ctx) => Provider<ApiHttpManager>(
                            //     create: (_) => ApiHttpManager(ctx)),
                          ],
                        ),
                    depends: [
                      // (ctx) => Provider<UserService>(
                      //     create: (_) => UserService(ctx)),
                    ]),
            depends: [
              // (ctx) => Provider<UserRepository>(
              //     create: (_) => UserRepository(ctx)),
            ]),
        depends: [
          (ctx) => Provider<DecorationsConstants>(
                create: (_) => DecorationsConstants(),
              ),
          (ctx) => Provider<SvgConstants>(
                create: (_) => SvgConstants(),
              ),
        ],
      ),
    );
  }
}

class RepositoriesLevel extends StatefulWidget {
  final Widget next;

  const RepositoriesLevel({super.key, required this.next});
  @override
  _RepositoriesLevelState createState() => _RepositoriesLevelState();
}

class _RepositoriesLevelState extends State<RepositoriesLevel> {
  @override
  Widget build(BuildContext context) {
    final db = context.getRequireBlocService<DatabaseContext>();
    final appConfig = context.getRequireBlocService<AppConfig>();
    if (appConfig != null && !appConfig.hasDatabase) {
      return widget.next;
    }
    return StreamBuilder(
      stream: db!.subjectStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return widget.next;
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
