import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:reddity/core/failure.dart';
import 'package:reddity/core/providers/firebase_providers.dart';
import 'package:reddity/core/type_defs.dart';

final storageRepositoryProvider = Provider(
  (ref) => StorageRepository(
    firebaseStorage: ref.watch(storageProvider),
  ),
);

class StorageRepository {
  final FirebaseStorage _firebaseStorage;

  StorageRepository({
    required FirebaseStorage firebaseStorage,
  }) : _firebaseStorage = firebaseStorage;

  FutureEither<String> storeFile(
      {required String path, required String id, required File? file}) async {
    try {
      // users/banner/123 >> it will get stored in user's folder and inside banner folder with name of the file 123
      final ref = _firebaseStorage.ref().child(path).child(id);
      UploadTask uploadTask = ref.putFile(file!);
      final snapshot = await uploadTask;
      return right(await snapshot.ref.getDownloadURL());
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
