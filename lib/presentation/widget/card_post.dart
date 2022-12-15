import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../commons/helpers.dart';
import '../../data/post.dart';
import '../providers/favorites_notifier.dart';
import '../providers/post_notifier.dart';
import '../../commons/extensions.dart';
import 'card_comment.dart';
import 'card_post/button_action.dart';
import 'card_post/media_post.dart';

class CardPost extends ConsumerWidget {
  const CardPost({super.key, required this.id, this.title, this.description, this.userId, required this.onPressed1, required this.onPressed2});

  final int id;
  final String? title;
  final String? description;
  final int? userId;
  final Function()? onPressed1;
  final Function()? onPressed2;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Post post = ref.read(postsProvider.notifier).posts.firstWhere((post) => post.id == id);
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: Helpers.decorationCard,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  const MediaPost(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Consumer(
                      builder: (context, ref, child) {
                        final favs = ref.watch(favoritesProvider);
                        return IconButton(
                          onPressed: () => favs.favorites.contains('${post.id}')
                            ? favs.removeFavoriteId('${post.id}')
                            : favs.addFavoriteId('${post.id}'),
                          icon: favs.favorites.contains('${post.id}')
                            ? const Icon( Icons.bookmark, color: Colors.amber )
                            : Icon( Icons.bookmark_border_outlined, color: Colors.grey.shade400 )
                        );
                      },
                    ),
                  )
                ],
              ),
              4.0.vertical,
              userId == 0
                ? post.title.titlePost
                : title!.titlePost,
              // post.title.titlePost,
              4.0.vertical,
              // post.body.descriptionPost,
              userId == 0
                ? post.body.descriptionPost
                : description!.descriptionPost,
              16.0.vertical,
              Row(
                children: [
                  CardComment(
                    title: userId == 0
                    ? 'Usuario #${post.userId}'
                    : 'Usuario #$userId',
                    subTitle: 'Jue 15, 8:30',
                    userId: userId == 0
                    ? post.userId
                    : userId!,
                  ),
                  const Spacer(),
                  ButtonAction(
                    onPressed: onPressed1,
                    icon: Icons.comment_outlined,
                    color: Colors.teal,
                    text: '5'
                  ),
                  ButtonAction(
                    onPressed: onPressed2,
                    icon: Icons.favorite,
                    color: Colors.red,
                    text: '3.2 K'
                  ),
                ],
              ),
              16.0.vertical,
            ],
          ),
        ),
      ),
    );
  }
}