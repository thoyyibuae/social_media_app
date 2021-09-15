import 'package:flutter/material.dart';
import 'package:social_media_app/app/components/camera_button.dart';

class DialogBox extends StatelessWidget {
  final Function onTapButton1;
  final Function onTapButton2;
  final String text1;
  final String text2;

  DialogBox({
    required this.onTapButton1,
    required this.onTapButton2,
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Text("Select Image"),
        SizedBox(
          height: 50,
        ),
        Row(
          children: [
            Container(
                // margin: EdgeInsets.fromLTRB(0, 30, 0, 20),
                child: CommonButton(
              buttonLabel: text1,
              onTap: () => onTapButton1(),
            )),
            SizedBox(
              width: 30,
            ),
            Container(
                // margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: CommonButton(
              buttonLabel: text2,
              onTap: () => onTapButton2(),
            ))
          ],
        )
      ],
    ));
  }
}
