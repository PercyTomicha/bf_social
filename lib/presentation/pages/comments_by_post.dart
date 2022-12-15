import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../commons/extensions.dart';
import '../../commons/helpers.dart';
import '../../presentation/providers/post_notifier.dart';
import '../../presentation/widget/card_comment.dart';
import '../../presentation/widget/card_post.dart';

import '../../data/comment.dart';

class CommentsByPost extends ConsumerWidget {
  const CommentsByPost({super.key, required this.id, this.title, this.description, this.userId});

  final int id;
  final String? title;
  final String? description;
  final int? userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Future<List<Comment>> comments = ref.read(postsProvider.notifier).getCommentsByPost(id);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: const Text("Comentarios"),
        centerTitle: true,
      ),
      body: SafeArea(
        // ignore: avoid_unnecessary_containers
        child: Container(
          child: ListView(
            children: [
              CardPost(
                id: id,
                title: title ?? '',
                description: description ?? '',
                userId: userId,
                onPressed1: null,
                onPressed2: () => {}
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: Container(
                  decoration: Helpers.decorationCard,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: 'Comentarios'.textTitle
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: FutureBuilder<List<Comment>>(
                          future: comments, // a previously-obtained Future<String> or null
                          builder: (BuildContext context, AsyncSnapshot<List<Comment>> snapshot) {
                            List<Widget> children;
                            if (snapshot.hasData) {
                              final List<Comment> comments = snapshot.data!;

                              // ignore: avoid_unnecessary_containers
                              children = comments.map((comment) => Container(
                                child: Column(
                                  children: [
                                    CardComment(
                                      title: comment.email,
                                      subTitle: comment.body,
                                      userId: 0,
                                    )
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}