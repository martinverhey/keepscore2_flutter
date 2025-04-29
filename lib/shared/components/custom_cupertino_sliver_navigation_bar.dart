import 'package:flutter/cupertino.dart';
import 'package:keepscore2_flutter/main.dart';

class CustomCupertinoSliverNavigationBar extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const CustomCupertinoSliverNavigationBar({
    super.key,
    required this.title,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoSliverNavigationBar(
      largeTitle: Text(
        title,
        style: TextStyle(color: $styles.colors.orange),
      ),
      trailing: trailing,
    );
  }
}
