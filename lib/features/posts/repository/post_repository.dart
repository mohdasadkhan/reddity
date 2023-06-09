import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:reddity/core/constants/firebase_constants.dart';
import 'package:reddity/core/failure.dart';
import 'package:reddity/core/providers/firebase_providers.dart';
import 'package:reddity/core/type_defs.dart';
import 'package:reddity/models/community_model.dart';
import 'package:reddity/models/post_model.dart';

final postRepositoryProvider = Provider((ref) {
  return PostRepository(firebaseFirestore: ref.watch(firestoreProvider));
});

class PostRepository {
  final FirebaseFirestore _firebaseFirestore;

  PostRepository({
    required FirebaseFirestore firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore;

  CollectionReference get _post =>
      _firebaseFirestore.collection(FirebaseConstants.postsCollection);

  FutureVoid addPost(Post post) async {
    try {
      return right(_post.doc(post.id).set(post.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  Stream<List<Post>> fetchUserPosts(List<Community> communities) {
    return _post
        .where('communityName',
            whereIn: communities.map((e) => e.name).toList())
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((event) => event.docs
            .map((e) => Post.fromMap(e.data() as Map<String, dynamic>))
            .toList());
  }

  FutureVoid deletePost(Post post) async {
    try {
      return right(_post.doc(post.id).delete());
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  void upvote(Post post, String userId) async {
    if (post.downvotes.contains(userId)) {
      _post.doc(post.id).update({
        'downvotes': FieldValue.arrayRemove([userId])
      });
    }
    if (post.upvotes.contains(userId)) {
      _post.doc(post.id).update({
        'upvotes': FieldValue.arrayRemove([userId])
      });
    } else {
      _post.doc(post.id).update({
        'upvotes': FieldValue.arrayUnion([userId])
      });
    }
  }

  void downvote(Post post, String userId) async {
    if (post.upvotes.contains(userId)) {
      _post.doc(post.id).update({
        'upvotes': FieldValue.arrayRemove([userId])
      });
    }
    if (post.upvotes.contains(userId)) {
      _post.doc(post.id).update({
        'downvotes': FieldValue.arrayRemove([userId])
      });
    } else {
      _post.doc(post.id).update({
        'downvotes': FieldValue.arrayUnion([userId])
      });
    }
  }
}
