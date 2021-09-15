import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:social_media_app/app/components/dialog_widget.dart';
import 'package:social_media_app/app/components/post_add_button.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home Page'),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            // ignore: unnecessary_null_comparison
            Obx(
              () => controller.imagePath.value != ""
                  ? GestureDetector(
                      onTap: () {
                        Get.defaultDialog(actions: [
                          DialogBox(
                              onTapButton1: () {
                                controller.getFromCamera();
                              },
                              onTapButton2: () {
                                controller.getFromGallery();
                              },
                              text1: "From Camera",
                              text2: "From Gallery")
                        ]);
                        // controller.addImage();
                      },
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 250,
                                width: MediaQuery.of(context).size.width,
                                child: controller.imagePath.value.runtimeType ==
                                        "String"
                                    ? Image.network(controller.imagePath.value)
                                    : Image.file(
                                        File(controller.imagePath.value),
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              Positioned(
                                top: 70,
                                bottom: 70,
                                right: 70,
                                left: 70,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.black,
                                  size: 25,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Change Post Image",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        Get.defaultDialog(actions: [
                          DialogBox(
                              onTapButton1: () {
                                controller.getFromCamera();
                              },
                              onTapButton2: () {
                                controller.getFromGallery();
                              },
                              text1: "From Camera",
                              text2: "From Gallery")
                        ]);
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(50)),
                            width: 100,
                            height: 100,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.grey[800],
                            ),
                          ),
                          Text(
                            "Add Post Image",
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
            ),
            SizedBox(
              height: 26,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    TextFormField(
                      style: TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Post Title';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: Colors.grey)),
                          filled: true,
                          fillColor: Colors.grey[100],
                          labelStyle: TextStyle(color: Colors.black),
                          hintStyle: TextStyle(color: Colors.black),
                          hintText: "Post Title"),
                      controller: controller.titleController,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                        keyboardType: TextInputType.multiline,
                        minLines: 3,
                        maxLines: 5,
                        style: TextStyle(color: Colors.black),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Post Description';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                borderSide: BorderSide(color: Colors.grey)),
                            filled: true,
                            fillColor: Colors.grey[100],
                            labelStyle: TextStyle(color: Colors.black),
                            hintStyle: TextStyle(color: Colors.black),
                            hintText: "Post Description"),
                        controller: controller.descriptionController),
                    SizedBox(
                      height: 16,
                    ),
                    Obx(
                      () => Align(
                        alignment: Alignment.bottomRight,
                        child: PostAddButton(
                          text: controller.editPage!.value == true
                              ? "Update Post"
                              : "Add Post",
                          onTap: () {
                            if (controller.editPage!.value) {
                              controller.addPost();
                            } else {
                              controller.updatePost();
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Visibility(
              visible: controller.posts.length > 0,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Divider(
                  thickness: 2.3,
                  height: 20,
                ),
              ),
            ),
            Obx(
              () => ListView.builder(
                physics: ScrollPhysics(),
                itemCount: controller.posts.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(0.5),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 12.0,
                                bottom: 1.0,
                                right: 15.0,
                                left: 10.0),
                            child: Align(
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                    onTap: () {
                                      Get.defaultDialog(actions: [
                                        DialogBox(
                                            onTapButton1: () {
                                              controller.posts.remove(
                                                  controller.posts[index]);
                                              Get.back();
                                            },
                                            onTapButton2: () {
                                              // controller.post
                                              controller.editPost(
                                                  index,
                                                  controller.posts[index],
                                                  controller.posts[index].id!);
                                              Get.back();
                                            },
                                            text1: "Remove",
                                            text2: "Update")
                                      ]);
                                    },
                                    child: Icon(Icons.more_horiz))),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                child: Text(
                                  "${controller.posts[index].title}",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          // Text("${controller.posts[index].image.runtimeType}"),
                          controller.posts[index].image == "noimage"
                              ? Image.network(
                                  "https://thecsrjournal.in/wp-content/uploads/2018/10/speed-post.png")
                              : Image.file(controller.posts[index].image),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  child: Text(
                                      controller.posts[index].description!,
                                      maxLines: 28),
                                )),
                          ),

                          Divider(
                            thickness: 2.3,
                            height: 20,
                          )
                        ]),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
