import 'dart:io';

import '../core/bloc/bloc.dart';

// import 'package:firebase_analytics/firebase_analytics.dart';

class AppConfig implements Bloc {
  // static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  // FirebaseAnalyticsObserver observer =
  // FirebaseAnalyticsObserver(analytics: analytics);

  final bool hasDatabase;

  AppConfig(this.debug, this.basApiUrl, {required this.hasDatabase});
  final bool debug;
  final String basApiUrl;
  @override
  void dispose() {}

  Future<bool> localAuthorize() async {
    return true;
  }

  Future<bool> get hasInternet async {
    try {
      final googlePing = await InternetAddress.lookup("google.com")
          .timeout(const Duration(seconds: 1));
      if (googlePing.isNotEmpty && googlePing[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
