import 'package:cross_file/cross_file.dart';
import 'package:file_picker/file_picker.dart';

class FilePickService {
  FilePickService() {
    _filePicker = FilePicker.platform;
  }

  late final FilePicker _filePicker;

  Future<XFile?> pickPhoto() async {
    final photo = await _filePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    );

    if (photo == null) return null;

    return photo.xFiles.first;
  }
}
