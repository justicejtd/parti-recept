import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partirecept/constants/colors.dart';
import 'package:partirecept/widgets/QR/qrCreator.dart';
import 'package:partirecept/widgets/QR/qrScanner.dart';

class Qrbody extends StatefulWidget {
  State<Qrbody> createState() => _QrBodyState();
}

class _QrBodyState extends State<Qrbody> {
  var scanMode = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: [
        scanMode == true ? QrScanner() : QrCreator(),
        Positioned(
            top: 0,
            child: Center(
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(primaryOrange)),
                    child: OverflowBar(children: [
                      Text(scanMode == true
                          ? 'Generate a code instead'
                          : "Scan a code instead"),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                          scanMode == true ? Icons.qr_code : Icons.image_search)
                    ]),
                    onPressed: () => setState(() {
                          this.scanMode = !this.scanMode;
                        }))))
      ],
    ));
  }
}
