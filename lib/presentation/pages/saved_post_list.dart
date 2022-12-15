import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/post.dart';
import '../../presentation/providers/post_notifier.dart';
import '../../commons/helpers.dart';
import '../providers/favorites_notifier.dart';
import '../widget/card_post.dart';

class SavedPostList extends ConsumerWidget {
  const SavedPostList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Future<List<Post>> posts = ref.read(postsProvider.notifier).getPosts();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Guardados"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon( Icons.arrow_back_ios_new, color: Colors.white, )
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.grey.shade300,
          child: Consumer(
            builder: (context, ref, child) => FutureBuilder<List<Post>>(
              future: posts, // a previously-obtained Future<String> or null
              builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
                final favs = ref.watch(favoritesProvider).favorites;
                List<Widget> children;
                if (snapshot.hasData) {
                  final List<Post> posts = snapshot.data!;
                  // ignore: avoid_unnecessary_containers
                  final favorites = posts.where((element) => favs.contains('${element.id}')).toList();
                  children = favorites.map((post) => Container(
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