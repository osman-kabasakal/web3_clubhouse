import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
// import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common/sqlite_api.dart';

import '../../../constants/db_insert_confilict_action.dart';
import '../../bloc/bloc_provider.dart';
import '../context/context.dart';
import '../entities/entity_instances.dart';
import 'base_entity.dart';
import 'base_repository.dart';

class Repository<T extends IEntity> implements IBaseRepository<T?> {
  BehaviorSubject<Database>? reactiveDb;

  @override
  Database? get db {
    // if(_db==null)_db=await reactiveDb.first;
    if (reactiveDb?.value == null) return throw 'Database oluşturulmadı.';

    return reactiveDb?.value;
  }

  @override
  final String tableName;

  final BuildContext context;

  String primaryFieldName = "";

  Repository({
    required this.context,
    required this.tableName,
    required this.primaryFieldName,
    // @required this.db
  }) {
    reactiveDb = (BlocProvider.of<DatabaseContext>(context)?.subject
        as BehaviorSubject<Database>?);
  }

  @override
  Future<T?> add(T? seviye) async {
    try {
      final sendData = seviye!.toSqlite();
      final seviyeQuery = (await db?.insert(tableName, sendData))!;
      sendData[primaryFieldName] = sendData[primaryFieldName] == null
          ? seviyeQuery
          : sendData[primaryFieldName];
      return await single(EntityInstances.getEntity(entity, sendData));
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> delete(T? seviye) async {
    try {
      await db!.delete(tableName,
          where: "$primaryFieldName=?",
          whereArgs: [seviye!.toSqlite()[primaryFieldName]]);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<T>> query({String? where, List<dynamic>? whereArgs}) async {
    try {
      List<Map<String, dynamic>> seviyelerQueryResult;

      seviyelerQueryResult = where != null
          ? whereArgs != null
              ? (await db?.query(tableName, where: where))!
              : (await db?.query(tableName,
                  where: where, whereArgs: whereArgs))!
          : (await db?.query(
              tableName,
            ))!;
      List<T> seviyelerQueryMap;
      seviyelerQueryMap = seviyelerQueryResult
          .map<T>((e) => EntityInstances.getEntity(entity, e))
          .toList();
      return (seviyelerQueryMap);
    } catch (e) {
      return [];
    }
  }

  @override
  Future<T?> single(T? seviye) async {
    // assert(seviye.toJson()[primaryFieldName]==null);
    // print(seviye.toJson()[primaryFieldName]);
    try {
      final mappedSeviye = seviye!.toSqlite();
      final seviyelerQueryResult = await db!.query(tableName,
          where: "$primaryFieldName=?",
          whereArgs: [mappedSeviye[primaryFieldName]]);
      final seviyelerQueryMap =
          EntityInstances.getEntity(entity, seviyelerQueryResult.first);
      return seviyelerQueryMap as T;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<T?> update(T? seviye) async {
    try {
      final sendData = seviye!.toSqlite();
      final seviyeQuery = await db!.update(tableName, sendData,
          where: "$primaryFieldName=?",
          whereArgs: [sendData[primaryFieldName]]);
      sendData[primaryFieldName] = seviyeQuery;
      return await single(EntityInstances.getEntity(entity, sendData));
    } catch (e) {
      return null;
    }
  }

  @override
  Type get entity => T;

  @override
  Future<List<T>> rawQuery(String query,
      {List<dynamic>? whereArgs, String tag = ""}) async {
    try {
      List<Map<String, dynamic>> seviyelerQueryResult;

      seviyelerQueryResult = whereArgs != null
          ? await db!.rawQuery(query, whereArgs)
          : await db!.rawQuery(query);
      List<T> seviyelerQueryMap;
      seviyelerQueryMap = seviyelerQueryResult
          .map<T>((e) => EntityInstances.getEntity(entity, e))
          .toList();
      return (seviyelerQueryMap);
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> addAll(List<String> columns, List<T?> addedList,
      [DbInsertConfilictExtion conflictTypes =
          DbInsertConfilictExtion.ignore]) async {
    try {
      if (addedList.isEmpty) return true;
      // final playOfUsersQuery = "INSERT OR IGNORE into GamePlayOfUsers (oyunId) values ";
      // final oyunIdsValues = [];
      final conflictAction = conflictTypes == DbInsertConfilictExtion.ignore
          ? "IGNORE"
          : "REPLACE";
      final cozumInfosQuery =
          "INSERT OR $conflictAction into $tableName (${columns.join(',')}) values ";
      final cozumInfoValues = [];
      for (var item in addedList) {
        // oyunIdsValues.add("('" + userOfGame.gameId + "')");
        String valueString = "(";
        // final cozumInfo = GameCozumInfo(
        //   bitirdigiSure: userOfGame.bitirdigiSure,
        //   gamePlayId: userOfGame.gameId,
        //   oynadigiTarih: userOfGame.oynadigiTarih,
        //   uid: currentUser.uid,
        //   yaptigiHamleler: userOfGame.yaptigiHamleler,
        //   firebaseSyncInfo: FirebaseSyncInfo(
        //     documentId: userOfGame.documentId,
        //     isSyncFirebase: true,
        //     lastSyncDate: DateTime.now(),
        //   ),
        // );
        final sqliteModel = item!.toSqlite();
        valueString += columns
                .map((e) => sqliteModel[e] is String
                    ? "'" + sqliteModel[e].replaceAll("'", "''") + "'"
                    : sqliteModel[e].toString())
                .join(",") +
            ")";
        cozumInfoValues.add(valueString);
      }
      // await db.rawQuery(playOfUsersQuery + oyunIdsValues.join(","));
      await db!.rawQuery(cozumInfosQuery + cozumInfoValues.join(","));
      return true;
    } catch (e) {
      return false;
    }
  }
}
