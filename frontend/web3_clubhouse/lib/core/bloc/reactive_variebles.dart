import 'package:rxdart/rxdart.dart';
import 'package:web3_clubhouse/core/bloc/reactive_bloc.dart';

import '../domain/entities/user.dart';
import 'User/user_reactive_variable.dart';
import 'bloc.dart';

class ReactiveVariebles implements Bloc {
  static final _instance = ReactiveVariebles._internal();

  factory ReactiveVariebles() {
    return _instance;
  }

  ReactiveVariebles._internal();

  final Map<Type, ReactiveSubject> reactives = {
    // Database: DatabaseContext(),
    User: UserVariable()
  };

  ReactiveSubject<T, T2> getSubject<T, T2 extends Subject<T>>() {
    return reactives[T]! as ReactiveSubject<T, T2>;
  }

  ReactiveSubject<T?, T2> getNullableSubject<T, T2 extends Subject<T>>() {
    return reactives[T]! as ReactiveSubject<T?, T2>;
  }

  @override
  void dispose() {
    reactives.values.forEach((element) {
      element.dispose();
    });
  }
}
