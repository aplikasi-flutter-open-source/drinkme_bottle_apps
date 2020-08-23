import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

abstract class ScannerService {
  Future<ScanResult> scan();
}

class QRScanner implements ScannerService {
  @override
  Future<ScanResult> scan() async {
    try {
      return await BarcodeScanner.scan(
          options: ScanOptions(
        restrictFormat: [BarcodeFormat.qr],
      ));
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        throw const AccessDeniedException();
      } else {
        throw ScannerException(e.toString());
      }
    }
  }
}

class ScannerException implements Exception {
  final String message;

  const ScannerException(this.message);
}

class AccessDeniedException implements ScannerException {
  final String message = 'The user did not grant camera permissions';

  const AccessDeniedException();
}
