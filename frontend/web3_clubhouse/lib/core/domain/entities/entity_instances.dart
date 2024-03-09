import '../abstract/base_entity.dart';

class EntityInstances {
  static final Map<Type, IEntity Function(Map<String, dynamic> json)>
      instances = {
    // User: (json) => User.fromJson(json)
  };

  static T getEntity<T extends IEntity>(Type type, Map<String, dynamic> json) {
    return instances[type]!(json) as T;
  }
}
