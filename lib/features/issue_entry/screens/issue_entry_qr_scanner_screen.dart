import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vidres_app/utils/constants/color_constants.dart';

class IssueEntryQrScannerScreen extends StatefulWidget {
  final Function(String, QRViewController) onScanResult;

  const IssueEntryQrScannerScreen({
    super.key,
    required this.onScanResult,
  });

  @override
  State<IssueEntryQrScannerScreen> createState() =>
      _IssueEntryQrScannerScreenState();
}

class _IssueEntryQrScannerScreenState extends State<IssueEntryQrScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool isScanning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: kColorCard5Primary,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: MediaQuery.of(context).size.width * 0.75,
            ),
          ),
          Positioned(
            top: 50,
            left: 25,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: kColorWhite,
                size: 30,
              ),
              onPressed: () {
                controller?.dispose();
                Get.back();
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    controller.scannedDataStream.listen(
      (scanData) async {
        if (isScanning) return;

        isScanning = true;

        String scanDataCode = scanData.code ?? '';

        if (scanDataCode.isNotEmpty) {
          widget.onScanResult(scanDataCode, controller);
        }

        await Future.delayed(
          const Duration(
            seconds: 3,
          ),
        );
        isScanning = false;
      },
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
