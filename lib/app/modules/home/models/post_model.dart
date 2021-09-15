class Post {
  int? id;
  String? title;
  dynamic image;
  String? description;

  Post({this.id, this.title, this.image, this.description});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image'] = image;
    data['description'] = description;
    return data;
  }

  // @override
  // String toString() {
  //   return title.toString();
  // }
}
