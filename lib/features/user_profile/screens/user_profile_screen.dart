import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:reddity/core/common/error_text.dart';
import 'package:reddity/core/common/loader.dart';
import 'package:reddity/core/common/post_card.dart';
import 'package:reddity/features/auth/controller/auth_controller.dart';
import 'package:reddity/features/user_profile/controller/user_profile_controller.dart';
import 'package:routemaster/routemaster.dart';

class UserProfileScreen extends ConsumerWidget {
  final String uid;

  const UserProfileScreen({super.key, required this.uid});

  void navigateToEditUser(BuildContext context) {
    Routemaster.of(context).push('/edit-profile/$uid');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: ref.watch(getUserDataProvider(uid)).when(
            data: (user) => NestedScrollView(
                  headerSliverBuilder: ((context, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        expandedHeight: 250,
                        floating: true,
                        snap: true,
                        flexibleSpace: Stack(
                          children: [
                            Positioned.fill(
                              child:
                                  Image.network(user.banner, fit: BoxFit.cover),
                            ),
                            Container(
                              alignment: Alignment.bottomLeft,
                              padding:
                                  const EdgeInsets.all(20).copyWith(bottom: 70),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(user.profilePic),
                                radius: 45,
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomLeft,
                              padding: const EdgeInsets.all(20),
                              child: OutlinedButton(
                                onPressed: () => navigateToEditUser(context),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                ),
                                child: const Text('Edit Profile'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.all(16.0),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate.fixed(
                            [
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('u/${user.name}',
                                        style: const TextStyle(
                                            fontSize: 19.0,
                                            fontWeight: FontWeight.bold)),
                                  ]),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text('${user.karma} karma'),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Divider()
                            ],
                          ),
                        ),
                      ),
                    ];
                  }),
                  body: ref.watch(getUserPostsProvider(uid)).when(
                      data: (data) => ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final post = data[index];
                            return PostCard(post: post);
                          }),
                      error: (error, stackTrace) =>
                          ErrorText(error: error.toString()),
                      loading: () => const Loader()),
                ),
            error: (error, stackTrace) => ErrorText(error: error.toString()),
            loading: () => const Loader()));
  }
}
