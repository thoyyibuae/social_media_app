// import 'dart:io';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/app/modules/home/models/post_model.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  RxList<Post> posts = <Post>[].obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool? editPage = false.obs;
  PickedFile? pic;
  late int edtIndex;
  bool? isValid = false;
  final picker = ImagePicker();

  File? image;
  RxString imagePath = "".obs;
  RxString description = "".obs; // observable String

  TextEditingController? descriptionController;
  RxString title = "".obs;

  TextEditingController? titleController;

  @override
  void onInit() {
    descriptionController = TextEditingController(text: "");

// adding a listener that automatically updates the textfieldString with the textfield value

// description listener
    descriptionController!.addListener(() {
      description.value = descriptionController!.text;
      debugPrint(description.value);
    });
    titleController = TextEditingController(text: "");

// adding a listener that automatically updates the textfieldString with the textfield value

// title listener

    titleController!.addListener(() {
      title.value = titleController!.text;
      debugPrint(title.value);
    });
    super.onInit();
    //
    posts.forEach(print);
  }

  //add post
  addPost() {
    checkValid();
  }

//edit post
  editPost(int index, Post post, int editId) {
    edtIndex = index;
    editPage!.value = true;
    posts[index] = post;
    posts[index].id = post.id!;
    titleController!.text = post.title!;
    title.value = post.title!;
    description.value = post.title!;

    descriptionController!.text = post.description!;
    image = post.image!;

    imagePath.value = post.image.path;

    update();
  }

  //update post
  updatePost() {
    checkValid();
  }

//checkValid
  checkValid() {
    if (imagePath.value == "") {
      Get.snackbar("", "Image Required");
    }
    // ignore: unnecessary_null_comparison

    if (formKey.currentState!.validate() && imagePath.value != "") {
      formKey.currentState!.save();

      if (editPage!.value == false) {
        print("add.......");
        Post data = Post(
          id: posts.length + 1,
          title: titleController!.text.trim(),
          description: descriptionController!.text.trim(),
          image: image,
        );
        posts.add(data);
        titleController!.text = "";
        descriptionController!.text = "";
        title.value = "";
        description.value = "";
        titleController = TextEditingController(text: "");
        descriptionController = TextEditingController(text: "");
        formKey.currentState!.reset();

        print("Post added success");
        posts.forEach((element) {
          print(element.title);
        });
        imagePath.value = "";
        update();
      } else {
        Post data = Post(
          id: posts[edtIndex].id,
          title: titleController!.text,
          description: descriptionController!.text,
          image: image,
        );
        print("index:.....${edtIndex}");
        if (edtIndex != -1) {
          posts[edtIndex] = data;
        }

        editPage!.value = false;
      }
      titleController!.text = "";
      title.value = "";
      description.value = "";

      descriptionController!.text = "";
      titleController = TextEditingController(text: "");
      descriptionController = TextEditingController(text: "");

      formKey.currentState!.reset();
      print("Post Updated success");
      posts.forEach((element) {
        print(element.title);
      });
      imagePath.value = "";
      update();
    }
  }

  /// Get from gallery
  getFromGallery() async {
    pic = (await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    ))!;
    print("Hello: " + pic!.path.toString());
// ignore: unnecessary_null_comparison
    if (pic != null) {
      print("Hello: " + pic!.path);

      image = File(pic!.path);
      imagePath.value = pic!.path;
      update();
      Get.back();
    }
  }

  /// Get from Camera
  getFromCamera() async {
    // pic = null;
    pic = (await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    ))!;
    // ignore: unnecessary_null_comparison
    if (pic != null) {
      print("Hello: " + pic!.path);

      image = File(pic!.path);
      imagePath.value = pic!.path;
      update();
      Get.back();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
