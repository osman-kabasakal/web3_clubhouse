import 'package:flutter/widgets.dart';

import 'bloc.dart';

class BlocProvider<T extends Bloc> extends StatefulWidget {
  final Widget child;
  final T bloc;
  static const Key _key = Key("key");
  const BlocProvider({Key key = _key, required this.bloc, required this.child})
      : super(key: key);

  // 2
  static T? of<T extends Bloc>(BuildContext context) {
    // final type = _providerType<BlocProvider<T>>();
    final BlocProvider<T>? provider =
        context.findAncestorWidgetOfExactType<BlocProvider<T>>();
    return provider?.bloc;
  }

  // 3
  // static T _providerType<T>() => T;

  @override
  State createState() => _BlocProviderState();
}

class _BlocProviderState extends State<BlocProvider> {
  // 4
  @override
  Widget build(BuildContext context) => widget.child;

  // 5
  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}
