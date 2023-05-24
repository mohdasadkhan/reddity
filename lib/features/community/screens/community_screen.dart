import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddity/core/common/error_text.dart';
import 'package:reddity/core/common/loader.dart';
import 'package:reddity/core/common/post_card.dart';
import 'package:reddity/features/auth/controller/auth_controller.dart';
import 'package:reddity/features/community/controller/community_controller.dart';
import 'package:reddity/models/community_model.dart';
import 'package:routemaster/routemaster.dart';

class CommunityScreen extends ConsumerWidget {
  final String name;
  const CommunityScreen({
    super.key,
    required this.name,
  });

  void navigateToModeTools(BuildContext context) {
    Routemaster.of(context).push('/mod-tools/$name');
  }

  void joinCommunity(WidgetRef ref, Community community, BuildContext context) {
    ref
        .read(communityControllerProvider.notifier)
        .joinCommunity(community, context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Scaffold(
        body: ref.watch(getCommunityByNameProvider(name)).when(
            data: (community) => NestedScrollView(
                  headerSliverBuilder: ((context, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        expandedHeight: 150,
                        floating: true,
                        snap: true,
                        flexibleSpace: Stack(
                          children: [
                            Positioned.fill(
                              child: Image.network(community.banner,
                                  fit: BoxFit.cover),
                            ),
                          ],
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.all(16.0),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate.fixed(
                            [
                              Align(
                                alignment: Alignment.topLeft,
                                child: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(community.avatar),
                                  radius: 35,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('r/${community.name}',
                                        style: const TextStyle(
                                            fontSize: 19.0,
                                            fontWeight: FontWeight.bold)),
                                    community.mods.contains(user!.uid)
                                        ? OutlinedButton(
                                            onPressed: () =>
                                                navigateToModeTools(context),
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 25),
                                            ),
                                            child: const Text('Mod Tools'),
                                          )
                                        : OutlinedButton(
                                            onPressed: () => joinCommunity(
                                                ref, community, context),
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 25),
                                            ),
                                            child: Text(community.members
                                                    .contains(user.uid)
                                                ? 'Joined'
                                                : 'Join'),
                                          ),
                                  ]),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child:
                                    Text('${community.members.length} members'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ];
                  }),
                  body: ref.watch(getCommunityPostsProvider(name)).when(
                        data: (data) => ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final post = data[index];
                            return PostCard(post: post);
                          },
                        ),
                        error: (error, stackTrace) =>
                            ErrorText(error: error.toString()),
                        loading: () => const Loader(),
                      ),
                ),
            error: (error, stackTrace) => ErrorText(error: error.toString()),
            loading: () => const Loader()));
  }
}
