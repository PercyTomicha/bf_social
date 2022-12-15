import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/post.dart';
import '../providers/post_notifier.dart';
import '../widget/card_post.dart';

class PostDetails extends ConsumerWidget {
  const PostDetails({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Future<Post> post = ref.read(postsProvider.notifier).getPost(id);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Text("ID de Publicación : $id"),
        centerTitle: true,
      ),
      body: SafeArea(
        // ignore: avoid_unnecessary_containers
        child: Container(
          child: FutureBuilder<Post>(
            future: post, // a previously-obtained Future<String> or null
            builder: (BuildContext context, AsyncSnapshot<Post> snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                final Post post = snapshot.data as Post;
  
                children = <Widget>[
                  CardPost(
                    id: post.id,
                    title: post.title,
                    description: post.body,
                    userId: 0,
                    onPressed1: () => context.push('/posts/${post.id}/comments'),
                    onPressed2: () => {}
                  )
                ];
              } else if (snapshot.hasError) {
                children = <Widget>[
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('No exite publicación con ese ID'),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: children,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}