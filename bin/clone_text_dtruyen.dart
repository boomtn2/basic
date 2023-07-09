import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'package:html/dom.dart' as dom;

void main() async {
  String url =
      'https://dtruyen.com/thap-nien-70-nu-cuong-nhan/bat-dau-mot-cai-mieng-1_4292798.html'; // Thay thế bằng đường dẫn web thực tế
  // Gửi yêu cầu HTTP để lấy nội dung trang web
  StringBuffer data = StringBuffer();
  int dem = 0;
  int phan = 0;
  String _chuong = "";
  String _dataChuong = "";
  try {
    for (int i = 0; i < 787; ++i) {
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        String htmlString = response.body;
        // Phân tích cú pháp HTML
        dom.Document document = htmlParser.parse(htmlString);

        _dataChuong = cloneTextBody(document);
        print(_dataChuong);
        data.write(_dataChuong);

        _chuong = tenChuong(document);
        // print(_chuong);
        if (dem == 50 || i == 787) {
          saveToFile(data.toString(),
              "C:/Users/phamm/OneDrive/Desktop/kieutheclone/text${phan}.txt");
          data.clear();
          dem = 0;
          ++phan;
          print("=======");
          print(_chuong);
          print("=======");
        }
        ++dem;
        //  url = "https://wikisach.net/" + getHrefA(document);

        url = getHrefA(document);
        print(url);
        await Future.delayed(Duration(seconds: 2));
      } else {
        print("Lỗi${_chuong}");
        saveToFile(data.toString(),
            "C:/Users/phamm/OneDrive/Desktop/kieutheclone/lỗi.txt");
        break;
      }
    }
  } catch (e) {
    print("lõi");
    saveToFile(data.toString(),
        "C:/Users/phamm/OneDrive/Desktop/kieutheclone/lỗi.txt");
  }
}

String cloneTextBody(dom.Document document) {
  // Tìm thẻ div với id là "bookContentBody"
  //dom.Element? divElement = document.querySelector('#bookContentBody');
  //chapter-content
  dom.Element? divElement = document.querySelector('#chapter-content');

  String texts = "";
  // Kiểm tra nếu tìm thấy thẻ div
  if (divElement != null) {
    // Lấy tất cả các thẻ con của div là các thẻ <p>
    // List<dom.Element> paragraphElements = divElement.text;
    texts = divElement.text.toString();
    //print(texts);
    // // Lấy văn bản từ các thẻ <p>

    // paragraphElements.map((element) => texts.write(element.text)).toList();

    // In ra các văn bản
  }
  return texts.toString();
}

String getHrefA(dom.Document document) {
  // Lấy tất cả các thẻ con của div là các thẻ <p>
  List<dom.Element> paragraphElements = document.querySelectorAll('a');
  String link = "Error";
  paragraphElements.forEach((element) {
    if (element.text == 'Sau ') {
      // In ra văn bản của thẻ <a>
      link = element.attributes['href'].toString();
    }
  });
  return link;
}

String tenChuong(dom.Document document) {
  // Lấy tất cả các thẻ con của div là các thẻ <p>
  StringBuffer tenChuong = StringBuffer();
  List<dom.Element> paragraphElements =
      document.querySelectorAll('story-title');
  //story-title
  // document.querySelectorAll('p.book-title');

  paragraphElements.forEach((element) {
    tenChuong.write(element.text);
  });
  return tenChuong.toString();
}

String removeSpecialCharacters(String input) {
  String newString =
      input.replaceAll(RegExp(r'[^a-zA-ZÀ-ỹ0-9{1,}.!:? ]+'), ' ');
  //newString = newString.replaceAll(RegExp(r'/.{2,}'), '.');
  // newString = newString.replaceAll(
  //     RegExp("trần tháng 5", caseSensitive: false), "Trần ngũ nguyệt");
  // newString = newString.replaceAll(
  //     RegExp("trần tháng sáu", caseSensitive: false), "Trần lục nguyệt");
  // newString = newString.replaceAll(RegExp("Trọng sinh 80 kiều kiều tức"), " ");
  newString.trim();
  return newString;
}

void saveToFile(String data, String filePath) {
  final file = File(filePath);

  file
      .writeAsString(data)
      .then((value) => print('File saved successfully.'))
      .catchError((error) => print('Failed to save file: $error'));
}
