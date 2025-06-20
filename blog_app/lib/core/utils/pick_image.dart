import 'package:image_picker/image_picker.dart';

class PickImage {
  Future<XFile?> pickImage(ImageSource image) async {
    try {
      final ImagePicker picker = ImagePicker();
      return await picker.pickImage(source: image);
    } catch (e) {
      return null;
    }
  }
}
