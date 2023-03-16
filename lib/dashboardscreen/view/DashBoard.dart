import 'package:barcode/values/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';
class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);
  @override
  State<DashBoard> createState() => _DashBoardState();
}
class _DashBoardState extends State<DashBoard> {
  //final GlobalKey _globalKey=GlobalKey();
  var getResult = 'QR Code Result';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style:  ButtonStyle(
                shadowColor:
                MaterialStateProperty.all(AppColor().buttoncolor),
                shape:
                MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                backgroundColor:
                MaterialStateProperty.all(AppColor().buttoncolor),
              ),
              onPressed: () async {
                 await ImagePickerPlugin().pickImage(source: ImageSource.camera);

              },
              child: Text(
                'Scan QR',
                style: GoogleFonts.poppins(color: AppColor().textcolor3),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(getResult),
          ],
        ),
      ),
    );
  }

  void scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.DEFAULT);
      if (!mounted) {
        return;
      }
      setState(() {
        getResult = qrCode;
      });
      print('QR code Result');
      print(qrCode);
    } on PlatformException {
      getResult = 'Failed to Scan QR';
    }
  }
}
