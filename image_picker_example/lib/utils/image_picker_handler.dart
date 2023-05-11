import 'package:image_picker/image_picker.dart';

class ImagePickerHandler {
  Future<XFile?> takePicture([int? imageQuality]) async {
    final xFile = ImagePicker.platform
        .getImage(source: ImageSource.camera, imageQuality: imageQuality);
    return xFile;
  }

  Future<XFile?> selectFromGallery() async {
    final xFile =
        await ImagePicker.platform.getImage(source: ImageSource.gallery);
    return xFile;
  }
}
