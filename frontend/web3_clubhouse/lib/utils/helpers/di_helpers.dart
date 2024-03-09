import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/bloc/bloc.dart';
import '../../core/bloc/bloc_provider.dart';
import '../../core/bloc/reactive_bloc.dart';
import '../../core/bloc/reactive_variebles.dart';

extension DiHelpers on BuildContext {
  T? getRequireBlocService<T extends Bloc>() {
    return BlocProvider.of<T>(this);
  }

  T getRequireProviderService<T>({bool isListen = true}) {
    if (isListen) return watch<T>();

    return read<T>();
  }

  // ReactiveSubject<T> getRequireReactiveValue<T>() {
  //   return (BlocProvider.of<ReactiveVariebles>(this)?.getSubject<T>()
  //       as ReactiveSubject<T>);
  // }

  // ReactiveSubject<T?> getRequireReactiveNullableValue<T>() {
  //   return (BlocProvider.of<ReactiveVariebles>(this)?.getNullableSubject<T>()
  //       as ReactiveSubject<T?>);
  // }
}
