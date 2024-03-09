import 'package:path/path.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../../config/app_config.dart';
import '../../bloc/reactive_bloc.dart';

class DatabaseContext extends ReactiveBehaviorSubjectBloc<Database> {
  AppConfig? appConfig;

  DatabaseContext() {
    open();
  }

  // @override
  // BehaviorSubject<Database> subject = BehaviorSubject<Database>();

  // @override
  // Stream<Database> get subjectStream => subject.stream.asBroadcastStream();

  Future open() async {
    try {
      var databasesPath = await databaseFactoryFfi.getDatabasesPath();

      //TODO: database file name eklenecek.
      var path = join(databasesPath, "dental.db");

      var exists = await databaseFactoryFfi.databaseExists(path);

      if (!exists) {
        try {
          await Directory(dirname(path)).create(recursive: true);
        } catch (_) {
          var debug = _;
        }

        // // Copy from asset
        // //TODO: Eğer hazır db varsa onun yolu eklenecek
        // ByteData data = await rootBundle.load(join("assets", ""));

        // List<int> bytes =
        //     data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

        // await File(path).writeAsBytes(bytes, flush: true);
      } else {}
      final database = await databaseFactoryFfi.openDatabase(path,
          options: OpenDatabaseOptions(
            version: 1,
            readOnly: false,
            singleInstance: true,
            onUpgrade: databaseOnUpgrade,
          ));
      if (!migrate) {
        //TODO: migrate edilmemiş.
      }
      subject.sink.add(database);
    } catch (e) {
      stderr.write(e);
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }
  }

  bool migrate = false;
  final List<List<String>> migrationScripts = [
    [
      '''CREATE TABLE "user" (
	"id"	TEXT NOT NULL UNIQUE,
	"email"	TEXT NOT NULL UNIQUE,
	"jwtToken"	TEXT,
	"expire"	INTEGER,
	PRIMARY KEY("id")
);'''
    ]
  ];
  Future<void> databaseOnUpgrade(
      Database database, int oldversion, int version) async {
    try {
      for (var i = oldversion; i < version; i++) {
        for (var item in migrationScripts[i]) {
          try {
            await database.rawQuery(item);
          } catch (e) {
            continue;
          }
        }
      }
      migrate = true;
      return;
    } catch (e) {
      var debug = e;
    }
  }
}
