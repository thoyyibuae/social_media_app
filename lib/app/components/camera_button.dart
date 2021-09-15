import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String buttonLabel;
  final Function onTap;
  const CommonButton({Key? key, required this.buttonLabel, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        onTap();
      },
      child: Text(buttonLabel),
    );
  }
}

// Widget galleryButton = FloatingActionButton(
//   backgroundColor: Colors.lightBlueAccent,
//   child: Row(
//     children: [
//       Expanded(child: Text("Gallery")),
//       Expanded(
//         child: Icon(
//           Icons.camera,
//         ),
//       )
//     ],
//   ),
//   onPressed: () {
//     print("No image...");
//     getFromGallery();
//     Get.back();

// //        alert.hide();
//   },
// );
