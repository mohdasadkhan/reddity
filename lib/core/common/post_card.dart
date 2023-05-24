import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddity/models/post_model.dart';
import 'package:reddity/theme/pallete.dart';

class PostCard extends ConsumerWidget {
  final Post post;
  const PostCard({required this.post, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTypeImage = post.type == 'image';
    final isTypeText = post.type == 'text';
    final isTypeLink = post.type == 'link';
    final currentTheme = ref.watch(themeNotifierProvider);
    return Column(
      children: [
        Container(
          decoration:
              BoxDecoration(color: currentTheme.drawerTheme.backgroundColor),
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 16)
                          .copyWith(right: 0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage(post.communityProfile),
                                radius: 16,
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
