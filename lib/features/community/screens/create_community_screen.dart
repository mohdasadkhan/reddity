import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddity/core/common/loader.dart';
import 'package:reddity/core/providers/storage_repository_providers.dart';
import 'package:reddity/features/community/controller/community_controller.dart';
import 'package:reddity/features/community/repository/community_repository.dart';

final communityControllerProvider =
    StateNotifierProvider<CommunityController, bool>(
  (ref) {
    final communityRepository = ref.watch(communityRepositoryProvider);
    final storageRepository = ref.watch(storageRepositoryProvider);
    return CommunityController(
        communityRepository: communityRepository, ref: ref, storageRepository: storageRepository);
  },
);

class CreateCommunityScreen extends ConsumerStatefulWidget {
  const CreateCommunityScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateCommunityScreenState();
}

class _CreateCommunityScreenState extends ConsumerState<CreateCommunityScreen> {
  final communityNameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    communityNameController.dispose();
  }

  void createCommunity() {
    ref
        .read(communityControllerProvider.notifier)
        .createCommunity(communityNameController.text.trim(), context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(communityControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Community'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Community name'),
            const SizedBox(
              height: 10.0,
            ),
            TextField(
              autofocus: true,
              controller: communityNameController,
              decoration: const InputDecoration(
                hintText: 'r/community_name',
                filled: true,
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(15),
              ),
              maxLength: 21,
            ),
            const SizedBox(
              height: 30.0,
            ),
            isLoading
                ? const Loader()
                : ElevatedButton(
                    onPressed: () => createCommunity(),
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: const Text('Create Community',
                        style: TextStyle(fontSize: 17)),
                  )
          ],
        ),
      ),
    );
  }
}
