import 'package:image_picker/image_picker.dart';

abstract class ProfileImageEvent {}

class FetchProfileImage extends ProfileImageEvent {
  final String? path;
  FetchProfileImage({this.path});
}

class UploadProfileImage extends ProfileImageEvent {
  final XFile? file;
  UploadProfileImage({required this.file});
}
