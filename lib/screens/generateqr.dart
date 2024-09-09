import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io; // Renaming import to avoid confusion
import 'package:flutter/foundation.dart' show kIsWeb; // To detect web platform
import 'package:qrcodeapp/api.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomQrScreen extends StatefulWidget {
  @override
  _CustomQrScreenState createState() => _CustomQrScreenState();
}

class _CustomQrScreenState extends State<CustomQrScreen> {
  String? qrCodeUrl;
  final TextEditingController _textController = TextEditingController();
  final ApiService _apiService = ApiService();

  String _selectedColor = '000000'; // Default color (black) in hex

  void _generateQrCode() async {
    if (_textController.text.isNotEmpty) {
      try {
        final url = await _apiService.generateQrCode(
          _textController.text,
          '200x200',
          color: _selectedColor,
        );
        setState(() {
          qrCodeUrl = url;
        });
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  void _saveQrCode() async {
    if (qrCodeUrl != null) {
      if (kIsWeb) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Saving QR code is not supported on web'),
          ),
        );
        return;
      }

      try {
        final response = await Dio().get(
          qrCodeUrl!,
          options: Options(responseType: ResponseType.bytes),
        );
        final Uint8List bytes = Uint8List.fromList(response.data);

        final directory = await getExternalStorageDirectory();
        if (directory != null) {
          final String path = directory.path;
          final String fullPath = '$path/${DateTime.now().millisecondsSinceEpoch}.png';
          io.File file = io.File(fullPath);
          await file.writeAsBytes(bytes);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('QR code saved to $fullPath'),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to get directory'),
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save QR code: $e'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No QR code generated yet'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Generate QR Code',
          style: GoogleFonts.playfairDisplay(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter text to generate QR code',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropdownButtonFormField<String>(
                value: _selectedColor,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedColor = newValue!;
                  });
                },
                items: <String>[
                  '000000',
                  '0000FF',
                  'FF0000',
                  '00FF00',
                  '6A329F',
                  '5B5B5B',
                  'C90076',
                  '741B47',
                  '69E332',
                  '9380D2'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value == '000000'
                          ? 'Black'
                          : value == '0000FF'
                              ? 'Blue'
                              : value == 'FF0000'
                                  ? 'Red'
                                  : value == '00FF00'
                                      ? 'Green'
                                      : value == '6A329F'
                                          ? 'Purple'
                                          : value == '5B5B5B'
                                              ? 'Gray'
                                              : value == 'C90076'
                                                  ? 'Magenta'
                                                  : value == '741B47'
                                                      ? 'Burgundy'
                                                      : value == '69E332'
                                                          ? 'Lime'
                                                          : value == '9380D2'
                                                              ? 'Lavender'
                                                              : 'Unknown Color',
                    ),
                  );
                }).toList(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Select QR code color',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _generateQrCode,
              style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                        GoogleFonts.openSans(
                          textStyle: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),
                        ),
                      ),
                      minimumSize: MaterialStateProperty.all<Size>(
                        Size(200, 40),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.all(10),
                      ),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
              child: Text('Generate QR Code'),
            ),
            SizedBox(height: 20),
            if (qrCodeUrl != null) ...[
              Image.network(qrCodeUrl!),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveQrCode,
                style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                        GoogleFonts.openSans(
                          textStyle: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),
                        ),
                      ),
                      minimumSize: MaterialStateProperty.all<Size>(
                        Size(200, 40),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.all(10),
                      ),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                child: Text('Save in Gallery'),
              ),
            ] else
              Text('QR code will be displayed here'),
          ],
        ),
      ),
    );
  }
}
