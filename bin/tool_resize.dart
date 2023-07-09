import 'dart:async';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;

void main() async {
  // Đường dẫn đến tệp ảnh cần resize
  final imagePath = 'C:/Users/phamm/OneDrive/Desktop/qr-code (3).png';
  // Đường dẫn đến tệp ảnh sau khi resize
  final resizedImagePath = 'C:/Users/phamm/OneDrive/Desktop';

  // // Load ảnh
  // final imageFile = File(imagePath);
  // final imageBytes = imageFile.readAsBytesSync();
  // final image = img.decodeImage(imageBytes);

  // // Thực hiện resize ảnh
  // final resizedImage = img.copyResize(image!, width: 400, height: 400);

  // // Lưu ảnh đã resize
  // final resizedImageFile = File(resizedImagePath);
  // resizedImageFile.writeAsBytesSync(img.encodePng(resizedImage));
  // ResizeImage resizeImage = ResizeImage();
  // resizeImage.runRezie(
  //     imagePath: imagePath, resizedImagePath: resizedImagePath);
  ResizeImage image = ResizeImage();

  List<String> data = [];
  readFilesRecursively("C:/Users/phamm/OneDrive/Desktop/test1", data);

  print(data.length);
  data.forEach((element) {
    print(element);
    image.runRezie(imagePath: element, resizedImagePath: path.dirname(element));
  });
}

void readFilesRecursively(String pathDirector, List<String> paths) {
  Directory directory = Directory(pathDirector);
  List<FileSystemEntity> entities = directory.listSync();

  for (FileSystemEntity entity in entities) {
    if (entity is File) {
      // Xử lý tệp ở đây
      String st = entity.path.replaceAll('\\', '/');
      // print('File: ${st}');

      if (path.basename(st).compareTo("icon.png") == 0) {
        print(st);
        paths.add(st);
      }
    } else if (entity is Directory) {
      // Đệ quy gọi hàm để đọc tệp trong thư mục con
      readFilesRecursively(entity.path, paths);
    }
  }
}

class ResizeImage {
  void runRezie({required String imagePath, required String resizedImagePath}) {
    // // Đường dẫn đến tệp ảnh cần resize
    // final imagePath = 'path/to/image.png';
    // // Đường dẫn đến tệp ảnh sau khi resize
    // final resizedImagePath = 'path/to/resized_image.png';

    // Load ảnh
    final imageFile = File(imagePath);
    final imageBytes = imageFile.readAsBytesSync();
    final image = img.decodeImage(imageBytes);

    resizeSave(
        image: image,
        resizedImagePath: "${resizedImagePath}/icon.png",
        width: 550,
        height: 550);
    resizeSave(
        image: image,
        resizedImagePath: "${resizedImagePath}/icon_114.png",
        width: 114,
        height: 114);
    resizeSave(
        image: image,
        resizedImagePath: "${resizedImagePath}/icon_1024x500.png",
        width: 1024,
        height: 500);
  }

  void resizeSave(
      {required final image,
      required String resizedImagePath,
      required int width,
      required int height}) {
    // Thực hiện resize ảnh
    final resizedImage = img.copyResize(image, width: width, height: height);

    // Lưu ảnh đã resize
    final resizedImageFile = File(resizedImagePath);
    resizedImageFile.writeAsBytesSync(img.encodePng(resizedImage));
  }
}
