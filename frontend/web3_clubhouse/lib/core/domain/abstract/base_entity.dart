abstract class IEntity {
  Map<String, dynamic> toJson();

  Map<String, dynamic> toSqlite();
}
