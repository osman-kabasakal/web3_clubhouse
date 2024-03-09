// import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common/sqlite_api.dart';


import 'base_entity.dart';

abstract class IBaseRepository<T extends IEntity?> {
  Database? get db => null;
  final String tableName;
  IBaseRepository({this.tableName = ""});
  Type get entity;
  Future<T> add(T seviye);
  Future<T> update(T seviye);
  Future<bool> delete(T seviye);

  Future<T> single(T seviye);
  Future<List<T>> query({
    String? where,
    List<String>? whereArgs,
  });

  Future<bool> addAll(List<String> columns, List<T> addedList);

  Future<List<T>> rawQuery(String query, {List<dynamic>? whereArgs});
}
