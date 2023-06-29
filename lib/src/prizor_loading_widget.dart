import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PrizorLoadingWidget extends StatelessWidget {
  final Color accentColor;
  const PrizorLoadingWidget({
    super.key,
    this.accentColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.transparent,
      child: Center(
        child: SpinKitThreeBounce(
          color: accentColor,
          size: 16.0,
        ),
      ),
    );
  }
}
