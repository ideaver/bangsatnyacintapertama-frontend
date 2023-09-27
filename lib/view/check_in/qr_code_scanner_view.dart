import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

import '../../app/service/network_checker/network_checker_service.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_sizes.dart';
import '../../app/theme/app_text_style.dart';
import '../../app/utility/console_log.dart';
import '../../app/utility/date_formatter.dart';

class QRCodeScannerView extends StatefulWidget {
  const QRCodeScannerView({super.key});

  static String routeName = '/qrcode-scanner';

  @override
  State<QRCodeScannerView> createState() => _QRCodeScannerViewState();
}

class _QRCodeScannerViewState extends State<QRCodeScannerView> {
  List<String> fakenames = [
    "Jhon Doe",
    "Toyama Nao",
    "Amamiya Sora",
  ];

  String code = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.baseLv2,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.baseLv2,
        iconTheme: const IconThemeData(color: AppColors.white),
      ),
      body: body(),
    );
  }

  Widget body() {
    return Center(
      child: Consumer<NetworkCheckerService>(
        builder: (context, network, _) {
          cl(network.isConnected);
          if (!network.isConnected) {
            return noInternet();
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.padding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                header(),
                scanner(),
                result(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget header() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Scan QR Code',
          style: AppTextStyle.bold(
            context,
            fontSize: 26,
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: AppSizes.padding / 2),
        Text(
          'Arahkan kamera ke QR Code dan tahan beberapa saat',
          style: AppTextStyle.medium(
            context,
            fontSize: 14,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }

  Widget scanner() {
    return Container(
      margin: const EdgeInsets.all(AppSizes.padding * 2),
      constraints: BoxConstraints(
        maxHeight: AppSizes.screenSize.height / 2,
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSizes.radius * 2),
          child: MobileScanner(
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              // final Uint8List? image = capture.image;
              for (final barcode in barcodes) {
                // code = fakenames[Random().nextInt(3)];
                code = barcode.rawValue ?? '';
                debugPrint('Barcode found! ${barcode.rawValue}');
                setState(() {});
              }
            },
          ),
        ),
      ),
    );
  }

  Widget result() {
    if (code == '') {
      return const SizedBox.shrink();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          code,
          textAlign: TextAlign.center,
          style: AppTextStyle.bold(
            context,
            fontSize: 26,
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: AppSizes.padding / 2),
        Text(
          'Berhasil Check-In pada ${DateFormatter.slashDateShortedYearWithClock(DateTime.now().toIso8601String())}',
          style: AppTextStyle.medium(
            context,
            fontSize: 14,
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: AppSizes.padding),
        Text(
          'Seat 4H',
          style: AppTextStyle.bold(
            context,
            fontSize: 26,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }

  Widget noInternet() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Anda Sedang Offline",
          textAlign: TextAlign.center,
          style: AppTextStyle.bold(
            context,
            fontSize: 26,
            color: AppColors.red,
          ),
        ),
        const SizedBox(height: AppSizes.padding / 2),
        Text(
          'Segera koneksikan ke internet',
          style: AppTextStyle.medium(
            context,
            fontSize: 14,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}
