import 'package:rxdart/rxdart.dart';

import 'bloc.dart';

abstract class ReactiveSubject<T2, T extends Subject<T2>> extends Bloc {
  late T subject;

  Stream<T2> get subjectStream => subject.stream.asBroadcastStream();

  @override
  void dispose() {
    subject.close();
  }
}

class ReactiveBehaviorSubjectBloc<T>
    extends ReactiveSubject<T, BehaviorSubject<T>> {
  BehaviorSubject<T>? _backField;
  @override
  get subject => _backField ?? (_backField = BehaviorSubject<T>());
}

class ReactivePublishSubjectBloc<T>
    extends ReactiveSubject<T, PublishSubject<T>> {
  PublishSubject<T>? _backField;
  @override
  get subject => _backField ?? (_backField = PublishSubject<T>());
}

abstract class ReactiveBehaviorSubjectListBloc<T>
    extends ReactiveSubject<List<T>, BehaviorSubject<List<T>>> {
  BehaviorSubject<List<T>>? _backField;
  @override
  get subject => _backField ?? (_backField = BehaviorSubject<List<T>>());
}

class ReactivePublishSubjectListBloc<T>
    extends ReactiveSubject<List<T>, PublishSubject<List<T>>> {
  PublishSubject<List<T>>? _backField;
  @override
  get subject => _backField ?? (_backField = PublishSubject<List<T>>());

  @override
  void dispose() {
    subject.close();
  }
}
