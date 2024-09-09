import 'package:flutter/material.dart';
import 'package:qrcodeapp/screens/generateqr.dart';
import 'package:qrcodeapp/screens/scanqr.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'QR Code Generator and Scanner',
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
  Text.rich(
    
  TextSpan(
    text: 'Welcome to a ',
    style: TextStyle(color: Colors.black,
  fontSize: 24,
    fontWeight: FontWeight.bold,),
              
     // Default style for the text
    children: <TextSpan>[
      TextSpan(
        text: 'c',
        style: TextStyle(color: Colors.blue), 
      ),
      TextSpan(
        text: 'o',
        style: TextStyle(color: Colors.red), 
      ),
      TextSpan(
        text: 'l',
        style: TextStyle(color: Color.fromARGB(255, 124, 206, 127)), 
      ),
      TextSpan(
        text: 'o',
        style: TextStyle(color: Color.fromARGB(255, 20, 20, 145)), 
      ),
      TextSpan(
        text: 'r',
        style: TextStyle(color:  const Color.fromARGB(255, 225, 212, 87))), 
      TextSpan(
        text: 'f',
        style: TextStyle(color: Colors.purple), 
      ),
      TextSpan(
        text: 'u',
        style: TextStyle(color: Colors.pink.shade200), 
      ),
      TextSpan(
        text: 'l',
        style: TextStyle(color: Color.fromARGB(255, 215, 111, 25)), 
      ),
      TextSpan(
        text: ' world of QR Codes.',
      ),
    ],
  ),
),
  
          SizedBox(height:30,),

            Text('Would you like to ?',
            style: GoogleFonts.luxuriousRoman(
            textStyle: TextStyle(
              
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
            ),
            SizedBox(height: 30,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CustomQrScreen()),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                textStyle: MaterialStateProperty.all<TextStyle>(
                  GoogleFonts.openSans(
                    textStyle: TextStyle(fontSize: 22),
                  ),
                ),
                minimumSize: MaterialStateProperty.all<Size>(
                  Size(300, 60), // Set the minimum size for both buttons
                ),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.all(16), // Increase padding for both buttons
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
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ScanQrScreen()),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                textStyle: MaterialStateProperty.all<TextStyle>(
                  GoogleFonts.openSans(
                    textStyle: TextStyle(fontSize: 22),
                  ),
                ),
                minimumSize: MaterialStateProperty.all<Size>(
                  Size(300, 60), // Set the minimum size for both buttons
                ),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.all(16), // Increase padding for both buttons
                ),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              child: Text('Scan QR Code'),
            ),
          ],
        ),
      ),
    );
  }
}
