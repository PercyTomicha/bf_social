import 'package:bf_social/presentation/pages/saved_post_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'commons/helpers.dart';
import 'presentation/pages/comments_by_post.dart';
import 'presentation/pages/create_post.dart';
import 'presentation/pages/post_details.dart';
import 'presentation/pages/post_list.dart';

class PostApp extends ConsumerWidget {
  PostApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = ThemeData();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.black,
          secondary: Colors.blue,
        ),
      ),
      title: 'BF Social',
    );
  }

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) => const PostList(),
      ),
      GoRoute(
        path: '/${Routes.favorites}',
        builder: (BuildContext context, GoRouterState state) => const SavedPostList(),
      ),
      GoRoute(
        path: '/${Routes.post}',
        builder: (context, state) {
          final id = state.params['id'];

          return PostDetails(id: id.toString());
        },
      ),
      GoRoute(
        path: '/${Routes.crearPostURL}',
        builder: (context, state) => const CreatePost()
      ),
      GoRoute(
        path: '/${Routes.posts}/:id/${Routes.comments}',
        builder: (context, state) {
          final id = state.params['id'];

          return CommentsByPost(id: int.parse(id!), userId: 0);
        },
      ),
      GoRoute(
        path: '/${Routes.post}/:id',
        builder: (context, state) {
          final id = state.params['id'];

          return PostDetails(id: id.toString());
        },
      ),
    ],
  );
}