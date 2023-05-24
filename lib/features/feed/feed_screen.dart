import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddity/core/common/error_text.dart';
import 'package:reddity/core/common/loader.dart';
import 'package:reddity/core/common/post_card.dart';
import 'package:reddity/features/community/controller/community_controller.dart';
import 'package:reddity/features/posts/controller/post_controller.dart';

class FeedScreen extends ConsumerWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(userCommunitiesProvider).when(
          data: (data) => ref.watch(userPostsProvider(data)).when(
                data: (data) {
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final post = data[index];
                        return PostCard(post: post);
                      });
                },
                error: (error, stackTrace) =>
                    ErrorText(error: error.toString()),
                loading: () => const Loader(),
              ),
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => const Loader(),
        );
  }
}
