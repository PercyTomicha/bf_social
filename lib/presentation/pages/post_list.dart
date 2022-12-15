import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/post.dart';
import '../../presentation/providers/post_notifier.dart';
import '../../commons/helpers.dart';
import '../widget/card_post.dart';

class PostList extends ConsumerWidget {
  const PostList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Future<List<Post>> posts = ref.read(postsProvider.notifier).getPosts();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Publicaciones"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => context.push('/${Routes.favorites}'),
            icon: const Icon( Icons.bookmark, color: Colors.white, )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/${Routes.crearPostURL}'),
        backgroundColor: Colors.grey.shade700,
        child: const Icon( Icons.add ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.grey.shade300,
          child: Consumer(
            builder: (context, ref, child) => FutureBuilder<List<Post>>(
              future: posts, // a previously-obtained Future<String> or null
              builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
                List<Widget> children;
                if (snapshot.hasData) {
                  final List<Post> posts = snapshot.data!;
                  // ignore: avoid_unnecessary_containers
                  children = posts.map((post) => Container(
                    child: Column(
                      children: [
                        CardPost(
                          id: post.id,
                          title: post.title,
                          description: post.body,
                          userId: post.userId,
                          onPressed1: () => context.push('/${Routes.posts}/${post.id}/${Routes.comments}'),
                          onPressed2: () => context.push('/${Routes.post}/${post.id}'),
                        ),
                      ],
                    ),
                  )).toList();
          
                } else if (snapshot.hasError) {
                  children = <Widget>[
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Error: ${snapshot.error}'),
                    )
                  ];
                } else {
                  children = const <Widget>[
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Esperando resultados...'),
                    )
                  ];
                }
                return Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: children,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}