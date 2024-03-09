import 'package:flutter/material.dart';

import '../abstract/repository.dart';
import '../entities/user.dart';

class UserRepository extends Repository<User> {
  UserRepository(BuildContext context)
      : super(context: context, tableName: "user", primaryFieldName: "id");

  Future<bool> hasUser(String uid) async {
    var user = await single(User(id: uid));
    return user != null;
  }
}
