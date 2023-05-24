//loggedOut route
//loggedIn route

import 'package:flutter/material.dart';
import 'package:reddity/features/community/screens/add_mods_screen.dart';
import 'package:reddity/features/community/screens/community_screen.dart';
import 'package:reddity/features/community/screens/create_community_screen.dart';
import 'package:reddity/features/community/screens/edit_community_screen.dart';
import 'package:reddity/features/community/screens/mod_tools_screen.dart';
import 'package:reddity/features/home/screen/home_screen.dart';
import 'package:reddity/features/posts/screens/add_post_type_screen.dart';
import 'package:reddity/features/user_profile/screens/edit_profile_screen.dart';
import 'package:reddity/features/user_profile/screens/user_profile_screen.dart';
import 'package:routemaster/routemaster.dart';

import 'features/auth/login_screen/login_screen.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: LoginScreen()),
});

final loggedInRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: HomeScreen()),
  '/create-community': (_) =>
      const MaterialPage(child: CreateCommunityScreen()),
  //after : 'name' is call slug, which is dynamic
  '/r/:name': (route) => MaterialPage(
        child: CommunityScreen(
          name: route.pathParameters['name']!,
        ),
      ),
  '/mod-tools/:name': (route) =>
      MaterialPage(child: ModToolsScreens(name: route.pathParameters['name']!)),
  '/edit-community/:name': (route) => MaterialPage(
      child: EditCommunityScreen(name: route.pathParameters['name']!)),
  '/add-mods/:name': (route) =>
      MaterialPage(child: AddModsScreen(name: route.pathParameters['name']!)),
  '/u/:uid': (route) => MaterialPage(
        child: UserProfileScreen(
          uid: route.pathParameters['uid']!,
        ),
      ),
  '/edit-profile/:uid': (route) =>
      MaterialPage(child: EditProfileScreen(uid: route.pathParameters['uid']!)),
  '/add-post/:type': (route) =>
      MaterialPage(child: AddPostTypeScreen(type: route.pathParameters['type']!)),
});
