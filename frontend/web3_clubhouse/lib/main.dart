import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:web3_clubhouse/AppStarter.dart';
import 'package:web3_clubhouse/config/app_config.dart';
import 'package:web3_clubhouse/core/bloc/bloc_provider.dart';
import 'package:web3_clubhouse/pages/shared/widgets/RestartWidget.dart';

void main() {
WidgetsFlutterBinding.ensureInitialized();

  var appConfig = AppConfig(false, "https://192.168.1.101", hasDatabase: false);
  if (defaultTargetPlatform == TargetPlatform.windows) {
    sqfliteFfiInit();
  }
  switch (defaultTargetPlatform) {
    case TargetPlatform.macOS:
    case TargetPlatform.windows:
    case TargetPlatform.iOS:
    case TargetPlatform.android:
      appConfig = AppConfig(false, "https://192.168.1.101", hasDatabase: false);
      break;
    default:
      appConfig =
          AppConfig(false, "https://localhost:7171", hasDatabase: false);
  }
  runApp(
    RestartWidget(
      child: BlocProvider(
        bloc: appConfig,
        child: const AppStarter(),
      ),
    ),
  );

}