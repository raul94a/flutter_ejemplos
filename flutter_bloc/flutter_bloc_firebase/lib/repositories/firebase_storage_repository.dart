import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class FirebaseStorageRepository {
  final FirebaseStorage storage;
  const FirebaseStorageRepository({required this.storage});

  Future<XFile?> uploadFile({XFile? file}) async {
    if (file == null) {
      return null;
    }
    Reference reference = storage.ref().child('profile').child('profile.jpg');
    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path},
    );
    final task = await reference.putFile(File(file.path), metadata);
    if (task.state == TaskState.success) {
      final documentDirectory = await getApplicationSupportDirectory();
      print(documentDirectory.path);
      final fullpath = '${documentDirectory.path}/profile.jpg';
      await file.saveTo(fullpath);
      return XFile(fullpath);
    }
    return null;
  }

  Future<String?> fetchProfileImage() async {
    Reference reference = storage.ref('profile/profile.jpg');
    try {
      final url = await reference.getDownloadURL();
      return url;
    } catch (ignoreFlavio) {
      print(ignoreFlavio);
      return null;
    }
  }
}
