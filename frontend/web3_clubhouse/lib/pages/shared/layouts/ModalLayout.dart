import 'package:flutter/material.dart';
import 'package:web3_clubhouse/utils/helpers/di_helpers.dart';

import '../../../constants/SvgConstants.dart';

class MainModalLayout extends StatefulWidget {
  final Widget child;

  final String title;

  final bool dismissable;

  final IconData? dismissIcon;

  final Color? dismissColor;

  var scroolable;

  MainModalLayout(
      {Key? key,
      required this.title,
      required this.child,
      this.dismissIcon,
      this.dismissColor,
      this.dismissable = false,
      this.scroolable = true})
      : super(key: key);
  @override
  State<MainModalLayout> createState() => _MainModalLayoutState();
}

class _MainModalLayoutState extends State<MainModalLayout> {
  List<Widget> get header {
    return [
      Expanded(
        flex: 10,
        child: Stack(
          children: [
            SizedBox.expand(
              child: context
                  .getRequireProviderService<SvgConstants>(isListen: false)
                  .ModalTitleBg,
            ),
            Container(
              // decoration:
              //     Provider.of<DecorationsConstants>(context).headerTitle,
              child: Center(
                child: FittedBox(
                  child: Text(
                    widget.title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontFamily: "Pixeloid",
                          color: Color.fromARGB(255, 2, 220, 176),
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      if (widget.dismissable) const Spacer(),
      if (widget.dismissable)
        Expanded(
          flex: 2,
          child: MaterialButton(
            onPressed: () => Navigator.of(context).pop(),
            child: LayoutBuilder(
              builder: (ctx, boxSize) {
                return Icon(
                  widget.dismissIcon ?? Icons.close,
                  size: boxSize.biggest.shortestSide,
                  color: widget.dismissColor ?? Colors.redAccent,
                );
              },
            ),
          ),
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // if(MediaQuery.of(context))
    final rectangle =
        MediaQuery.of(context).size.width < MediaQuery.of(context).size.height
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.height;
    return Dialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          SizedBox.expand(
            child:
                context.getRequireProviderService<SvgConstants>().ModalFrameBg,
          ),
          SizedBox.expand(
            child: LayoutBuilder(builder: (lbContext, boxConstrait) {
              return Container(
                padding: EdgeInsets.symmetric(
                    vertical: boxConstrait.maxHeight * .021,
                    horizontal: boxConstrait.maxWidth * .025),
                width: rectangle,
                height: rectangle,
                decoration: BoxDecoration(
                  // image: DecorationImage(
                  //     image: SvgParser().parse(context.getRequireProviderService<SvgConstants>().ModalFrameBg.toString()) ),
                  //     fit: BoxFit.fill),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 10.0),
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: header,
                      ),
                    ),
                    Expanded(
                      flex: 11,
                      child: Stack(
                        children: [
                          // SizedBox.expand(
                          //   child: context
                          //       .getRequireProviderService<SvgConstants>(
                          //           isListen: false)
                          //       .ModalBodyBg,
                          // ),
                          widget.scroolable
                              ? SingleChildScrollView(child: widget.child)
                              : widget.child,
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
