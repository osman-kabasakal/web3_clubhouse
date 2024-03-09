import 'dart:async';

import '../../domain/entities/user.dart';
import '../reactive_bloc.dart';

class UserVariable extends ReactiveBehaviorSubjectBloc<User?> {
  late StreamSubscription<User?> listener;

  @override
  Stream<User?> get subjectStream => subject.asBroadcastStream();

  UserVariable() {
    listener = subject.listen((value) {
      // subject?.drain(value);
    });
  }

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }
}
