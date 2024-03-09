import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web3_clubhouse/constants/SvgConstants.dart';
import 'package:web3_clubhouse/core/localizations/AppLocalizationTags.dart';
import 'package:web3_clubhouse/core/localizations/AppLocations.dart';
import 'package:web3_clubhouse/pages/shared/layouts/MainScreen.dart';
import 'package:web3_clubhouse/pages/shared/layouts/ModalLayout.dart';
import 'package:web3_clubhouse/utils/helpers/di_helpers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MainScreen(LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          fit: StackFit.expand,
          children: [
            SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: LayoutBuilder(
                builder: (p0, p1) => Container(
                  color: const Color.fromARGB(255, 21, 47, 70),
                  padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                        flex: 10,
                        child: Text(AppLocations.of(context)!.translate(AppLocalizationTags.homeTitle),style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Colors.white),),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      },
    ));
  }
}
