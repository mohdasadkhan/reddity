import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddity/theme/pallete.dart';
import 'package:routemaster/routemaster.dart';

class AddPostScreen extends ConsumerWidget {
  const AddPostScreen({super.key});

  void navigateToAddPostTypeScreen(BuildContext context, String type) =>
      Routemaster.of(context).push('/add-post/$type');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double cardHeightWidget = 120;
    double iconSize = 60;
    final currentTheme = ref.watch(themeNotifierProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => navigateToAddPostTypeScreen(context, 'image'),
          child: SizedBox(
            height: cardHeightWidget,
            width: cardHeightWidget,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: currentTheme.colorScheme.background,
              elevation: 16,
              child: Center(
                child: Icon(
                  Icons.image_outlined,
                  size: iconSize,
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () => navigateToAddPostTypeScreen(context, 'text'),
          child: SizedBox(
            height: cardHeightWidget,
            width: cardHeightWidget,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: currentTheme.colorScheme.background,
              elevation: 16,
              child: Center(
                child: Icon(
                  Icons.font_download_outlined,
                  size: iconSize,
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () => navigateToAddPostTypeScreen(context, 'link'),
          child: SizedBox(
            height: cardHeightWidget,
            width: cardHeightWidget,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: currentTheme.colorScheme.background,
              elevation: 16,
              child: Center(
                child: Icon(
                  Icons.link_outlined,
                  size: iconSize,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
