import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class BarCodeer extends StatefulWidget {
  const BarCodeer({Key? key}) : super(key: key);

  @override
  State<BarCodeer> createState() => _BarCodeerState();
}

class _BarCodeerState extends State<BarCodeer> {
  String _scanBarcode = 'Unknown';

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Image(
                image: AssetImage("assets/img/login.png"),
                height: 150,
                color: Colors.blue,
              ),
              const SizedBox(
                height: 50,
              ),
              Text('Scan result : $_scanBarcode\n',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan,
                    ),
                    onPressed: () => barcodeScan(),
                    child: const Text('Barcode Scan',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold))),
              ),
            ]));
  }

  Future<void> barcodeScan() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }
}
