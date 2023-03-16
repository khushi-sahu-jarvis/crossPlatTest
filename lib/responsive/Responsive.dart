import 'package:flutter/cupertino.dart';

class Responsive extends StatelessWidget {
  final Widget smallScreen;
  final Widget largeScreen;
  final Widget mediumScreen;

  const Responsive(
      {Key? key,
      required this.smallScreen,
      required this.largeScreen,
      required this.mediumScreen})
      : super(key: key);

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width <500;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 500 &&
        MediaQuery.of(context).size.width < 1200;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1200;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >= 1200) {
        return largeScreen;
      } else if (constraints.maxWidth >= 500 && constraints.maxWidth < 1200) {
        return mediumScreen;
      } else {
        return smallScreen;
      }
    });
  }
}
