import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:reddity/core/constants/firebase_constants.dart';
import 'package:reddity/core/failure.dart';
import 'package:reddity/core/providers/firebase_providers.dart';
import 'package:reddity/core/type_defs.dart';
import 'package:reddity/models/user_model.dart';


final userProfileRepositoryProvider = Provider((ref) {
  return UserProfileRepository(firebaseFirestore: ref.watch(firestoreProvider));
});

class UserProfileRepository {
  final FirebaseFirestore _firebaseFirestore;

  UserProfileRepository({
    required FirebaseFirestore firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore;

  CollectionReference get _users =>
      _firebaseFirestore.collection(FirebaseConstants.usersCollection);

  FutureVoid editCommunity(UserModel user) async {
    try {
      return right(_users.doc(user.uid).update(user.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }


}
