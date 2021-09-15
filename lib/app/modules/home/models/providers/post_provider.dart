import 'package:get/get.dart';

import '../post_model.dart';

class PostProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Post.fromJson(map);
      if (map is List) return map.map((item) => Post.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Post?> getPost(int id) async {
    final response = await get('post/$id');
    return response.body;
  }

  // Future<Response<Post>> postPost(Post post) async => await post('post', post);
  Future<Response> deletePost(int id) async => await delete('post/$id');
}
