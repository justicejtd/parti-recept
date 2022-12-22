import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:partirecept/constants/colors.dart';
import 'package:partirecept/themes/TextThemeOswald.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';

class QrCreator extends StatefulWidget {
  const QrCreator({Key? key}) : super(key: key);
  State<QrCreator> createState() => _CreateQrCodeState();
}

class _CreateQrCodeState extends State<QrCreator> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        SizedBox(height: 40),
        Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Row(children: [
            Expanded(
              child: Image(
                image: AssetImage('assets/images/logo.png'),
                width: 150,
                height: 150,
              ),
            )
          ]),
          Row(children: [
            Expanded(
              child: Text(
                'Generate a QR code',
                textAlign: TextAlign.center,
                style: TextThemeOswald(Colors.black).headline3,
              ),
            ),
          ]),
          Row(children: [
            Expanded(
              child: Text(
                'and share it with others',
                textAlign: TextAlign.center,
                style: TextThemeOswald(Colors.black).subtitle1,
              ),
            ),
          ])
        ]),
        SizedBox(height: 40),
        Center(
          child: SingleChildScrollView(
              child: QrImage(
            data: controller.text,
            size: 300,
            backgroundColor: Colors.white,
          )),
        ),
        SizedBox(
          height: 30,
        ),
        ElevatedButton(
            onPressed: () => {saveQRImage()},
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(primaryOrange)),
            child: OverflowBar(
              children: [Text("Save this QR code"), Icon(Icons.download)],
            )),
        buildTextField(context)
      ],
    ));
  }

  saveQRImage() async {
    final qrValidationResult = QrValidator.validate(
      data: this.controller.text,
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.L,
    );

    if (qrValidationResult.status == QrValidationStatus.valid) {
      final qrCode = qrValidationResult.qrCode;
      final painter = QrPainter.withQr(
        qr: qrCode as QrCode,
        color: const Color(0xFF000000),
        gapless: true,
        embeddedImageStyle: null,
        embeddedImage: null,
      );
      Directory tempDir = await getExternalStorageDirectory() as Directory;
      String tempPath = tempDir.path;
      final ts = DateTime.now().millisecondsSinceEpoch.toString();
      String path = '$tempPath/$ts.png';
      print(path);
      final picData =
          await painter.toImageData(2048, format: ImageByteFormat.png);
      await writeToFile(picData as ByteData, path);
      final success = await GallerySaver.saveImage(path);

      Scaffold.of(context).showSnackBar(SnackBar(
        content: success != null
            ? Text('Image saved to Gallery')
            : Text('Error saving image'),
      ));
    }
  }

  Future<void> writeToFile(ByteData data, String path) async {
    final buffer = data.buffer;
    await File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  Widget buildTextField(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(24),
        child: Column(children: [
          TextField(
            onSubmitted: (text) => setState(() {}),
            controller: controller,
            decoration: InputDecoration(
              hintText: "What would you like to share?",
              suffixIcon: IconButton(
                  onPressed: () => setState(() {}), icon: Icon(Icons.done)),
            ),
          ),
          SizedBox(height: 50),
        ]));
  }
}
