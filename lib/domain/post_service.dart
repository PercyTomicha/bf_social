import 'package:dio/dio.dart';

import '../commons/helpers.dart';
import '../data/post.dart';


class PostService {
  late final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Helpers.baseURL,
      connectTimeout: Helpers.connectTimeout,
      receiveTimeout: Helpers.receiveTimeout,
      responseType: ResponseType.json,
    ),
  );

  Future<List<dynamic>> fetchPosts() async {
    final postsData = await _dio.get('/posts');
    return postsData.data;
  }

  Future<dynamic> addPost(Post postData) async {
    // Load json data
    try {
      final response = await _dio.post(
        '/posts',
        data: postData.toRawJson(),
      );
      return response.data;
    } on DioError catch (e) {
      throw e.toString();
    }
  }

  Future<dynamic> fetchPost(id) async {
    final postsData = await _dio.get('/posts/$id');
    return postsData.data;
  }

  Future<List<dynamic>> fetchCommentsByPost(id) async {
    final commentsData = await _dio.get('/posts/$id/comments');
    return commentsData.data;
  }
}