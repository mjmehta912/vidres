import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vidres_app/utils/constants/color_constants.dart';
import 'package:vidres_app/utils/dialogs/app_dialogs.dart';
import 'package:vidres_app/utils/helpers/sound_helper.dart';

class QrScannerScreenWip extends StatefulWidget {
  final Function(String) onScanResult;
  final Set<String> existingCardNumbers;

  const QrScannerScreenWip({
    super.key,
    required this.onScanResult,
    required this.existingCardNumbers,
  });

  @override
  State<QrScannerScreenWip> createState() => _QrScannerScreenWipState();
}

class _QrScannerScreenWipState extends State<QrScannerScreenWip> {
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
          if (widget.existingCardNumbers.contains(scanDataCode)) {
            SoundHelper.playFailureSound();
            Get.back();
            showErrorSnackbar(
              'Duplicate Found',
              'This card has already been scanned.',
            );
          } else {
            widget.onScanResult(scanDataCode);
          }

          await controller.pauseCamera();
          await Future.delayed(const Duration(seconds: 2));
          await controller.resumeCamera();
        }

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
