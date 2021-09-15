import 'package:flutter/material.dart';

class PostAddButton extends StatelessWidget {
  final Function onTap;
  final String text;

  const PostAddButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: OutlinedButton(
        child: Text("${text.toString()}"),
        onPressed: () {
          onTap();
        },
      ),
    );
  }
}
