import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PrizorLoadingWidget extends StatelessWidget {
  /// [PrizorLoadingWidget] is a widget that is used to show a loading animation.
  /// It receives an optional [accentColor] parameter that will be used as the color of the loading animation.
  /// The default value is [Colors.blue].
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
