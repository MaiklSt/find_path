import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.title});
  
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: title,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}