import 'package:json_annotation/json_annotation.dart';

import '../abstract/base_entity.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends IEntity {
  User({required this.id, this.email, this.jwtToken, this.expire});

  String? id;
  String? email;
  String? jwtToken;
  int? expire;

  DateTime get expireTime {
    return DateTime.fromMicrosecondsSinceEpoch(
        this.expire ?? DateTime.now().microsecondsSinceEpoch);
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  Map<String, dynamic> toSqlite() => _$UserToJson(this);
}
