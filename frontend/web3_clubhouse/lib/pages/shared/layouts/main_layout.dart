import 'package:flutter/material.dart';

abstract class MainLayout extends StatelessWidget {
  MainLayout(this.content) : super();

  final Widget content;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _onWilProp(context),
      onPopInvoked: (didPop) => _onWilProp(context),
      child: Container(
        // padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          //TODO: set background
          // image: DecorationImage(

          //   image: imagesConstants.backgroundImage,
          //   fit: BoxFit.fill,
          // ),
        ),
        child: SafeArea(
          top: true,
          child: _body(context),
        ),
      ),
    );
  }

  bool _onWilProp(BuildContext context)  {
    return true;
  }

  Widget _body(BuildContext context) {
    // final decorationConstants = Provider.of<DecorationConstants>(context);
    return Container(
        decoration: const BoxDecoration(color: Colors.amber), child: content);
  }
}
