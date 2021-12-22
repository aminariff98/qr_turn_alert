import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.indigo,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
