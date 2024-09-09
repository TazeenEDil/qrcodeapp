import 'package:http/http.dart' as http;

class ApiService {
  static const String apiUrl = 'http://api.qrserver.com/v1/create-qr-code/';

  Future<String> generateQrCode(String data, String size, {String color = '000000'}) async {
    final Uri url = Uri.parse('$apiUrl?data=${Uri.encodeComponent(data)}&size=$size&color=$color');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return url.toString();
    } else {
      throw Exception('Failed to generate QR code');
    }
  }
}
