import 'package:image_picker/image_picker.dart';

class HelperFunction {
  static final ImagePicker _picker = ImagePicker();

  static Future<XFile?> pickImageFromGallery() async {
    try {
      final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        print("Image path: ${pickedImage.path}");
        return pickedImage;
      }
    } catch (e) {
      print("Error picking image: $e");
    }
    return null;
  }
}
