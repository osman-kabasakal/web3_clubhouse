//import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

typedef Widget DiChild(BuildContext context);
typedef Provider<T> DiDepends<T>(BuildContext context);

class DiDependModel{
  final List<DiDepends> depends;
  final DiChild childBuilder;

  DiDependModel(this.depends, this.childBuilder);
}

class DiLevel extends StatefulWidget {
  final int order;
  final DiChild child;
  final List<DiDepends> depends;
  DiLevel({
    required this.order,
    required this.child,
    required this.depends,
    Key? key,
  }) : super(key: key);
  @override
  DiLevelState createState() => DiLevelState();
}

class DiLevelState extends State<DiLevel> {
  @override
  Widget build(BuildContext context) {
    if (widget.depends.isEmpty) return widget.child(context);

    return MultiProvider(
      providers: widget.depends
          .map((e) => e(context))

          //.map((e) => Provider(create: (_) => e(context)))
          .toList(),
      builder: (subCtx,child) {
        //subCtx.watch<Object>();
        return  widget.child(subCtx);
      }
      );

      //child: Builder(builder: (subCtx){
        //subCtx.watch();
        //return widget.child(subCtx);
      //}),
    //);
  }
}
