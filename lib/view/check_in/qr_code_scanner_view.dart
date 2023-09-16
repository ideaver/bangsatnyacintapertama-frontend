import 'package:alvamind_library_two/app/theme/app_colors.dart';
import 'package:alvamind_library_two/app/theme/app_sizes.dart';
import 'package:alvamind_library_two/app/theme/app_text_style.dart';
import 'package:alvamind_library_two/app/utility/console_log.dart';
import 'package:alvamind_library_two/app/utility/date_formatter.dart';
import 'package:flutter/material.dart';

import 'qr_code_scanner_widget.dart';

class QRCodeScannerView extends StatefulWidget {
  const QRCodeScannerView({super.key});

  static String routeName = '/qrcode-scanner';

  @override
  State<QRCodeScannerView> createState() => _QRCodeScannerViewState();
}

class _QRCodeScannerViewState extends State<QRCodeScannerView> {
  String code = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.baseLv2,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.baseLv2,
      ),
      body: body(),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.padding),
      child: Column(
        children: [
          header(),
          scanner(),
          result(),
        ],
      ),
    );
  }

  Widget header() {
    return Column(
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
    return Expanded(
      flex: 4,
      child: AppBarcodeScannerWidget.defaultStyle(
        resultCallback: (String code) {
          setState(() {
            code = code;
            cl(code);
          });
        },
        openManual: true,
      ),
    );
  }

  Widget result() {
    return Column(
      children: [
        Text(
          'Hilda Mulya',
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
}
