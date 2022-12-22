import 'dart:io' as eos;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partirecept/constants/colors.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScanner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  final qrKey = GlobalKey(debugLabel: "QR");
  QRViewController? controller;
  Barcode? barcode;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (eos.Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (eos.Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        buildQRView(context),
        Positioned(bottom: 10, child: buildResult())
      ],
    ));
  }

  buildQRView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: secondaryYellow,
          borderWidth: 5,
          borderLength: 20,
          cutOutSize: MediaQuery.of(context).size.width * 0.8),
    );
  }

  onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((barcode) {
      setState(() {
        this.barcode = barcode;
      });
    });
  }

  buildResult() {
    return Container(
        padding: EdgeInsets.all(12),
        child: barcode == null
            ? Text(
                'Scan a code!',
                maxLines: 3,
              )
            : Text(
                'Barcode: ${this.barcode!.code}',
                maxLines: 3,
              ));
  }
}
