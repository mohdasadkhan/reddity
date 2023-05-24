import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddity/core/constants/constants.dart';
import 'package:reddity/features/auth/controller/auth_controller.dart';
import 'package:reddity/features/home/delegates/search_community_delegate.dart';
import 'package:reddity/features/home/drawers/community_list_drawer.dart';
import 'package:reddity/features/home/drawers/profile_drawer.dart';
import 'package:reddity/theme/pallete.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _page = 0;

  void displayDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  void displayEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  void onPageChanged(int page) => setState(
        () {
          _page = page;
        },
      );

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
    final currentTheme = ref.watch(themeNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: false,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => displayDrawer(context),
          );
        }),
        actions: [
          IconButton(
            onPressed: () => showSearch(
                context: context, delegate: SearchCommunityDelegate(ref: ref)),
            icon: const Icon(Icons.search),
          ),
          Builder(
            builder: (context) {
              return IconButton(
                  icon: CircleAvatar(
                    backgroundImage: NetworkImage(user.profilePic),
                  ),
                  onPressed: () => displayEndDrawer(context));
            },
          )
        ],
      ),
      drawer: const CommunityListDrawer(),
      endDrawer: const ProfileDrawer(),
      bottomNavigationBar: CupertinoTabBar(
        activeColor: currentTheme.iconTheme.color,
        backgroundColor: currentTheme.colorScheme.background,
        onTap: onPageChanged,
        currentIndex: _page,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'asad',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'khan',
          ),
        ],
      ),
      body: Constants.tabWidgets[_page],
    );
  }
}
