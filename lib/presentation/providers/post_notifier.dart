import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/comment.dart';
import '../../data/post.dart';
import '../../domain/post_service.dart';

class PostsNotifier extends ChangeNotifier {
  List<Post> postsLocal = <Post>[];
  List<Post> posts = <Post>[];

  PostsNotifier() {
    getPosts();
  }

  Future<void> addPost(Post newPost) async {
    final postData = await PostService().addPost(newPost);
    final post =  Post.fromJson(postData);
    postsLocal = [
      post,
      ...postsLocal
    ];
    notifyListeners();
    posts = [
      ...postsLocal,
      ...posts
    ];
    notifyListeners();
  }

  // Let's allow removing posts
  void removePost(String postId) {
    // ignore: unrelated_type_equality_checks
    posts.remove(posts.firstWhere((element) => element.id == postId));
    notifyListeners();
  }

  Future<Post> getPost(id) async {
    final postData = await PostService().fetchPost(id);
    final post =  Post.fromJson(postData);
    return post;
  }

  Future<List<Post>> getPosts() async {
    final postsData = await PostService().fetchPosts();
    posts =  postsData.map((post) => Post.fromJson(post)).toList();
    posts = [
      ...postsLocal,
      ...posts
    ];
    notifyListeners();
    return posts;
  }

  Future<List<Comment>> getCommentsByPost(id) async {
    final commentsData = await PostService().fetchCommentsByPost(id);
    final comments =  commentsData.map((comment) => Comment.fromJson(comment)).toList();
    return comments;
  }
}

final postsProvider = ChangeNotifierProvider<PostsNotifier>((ref) {
  return PostsNotifier();
});