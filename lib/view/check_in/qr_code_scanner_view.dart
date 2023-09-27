import 'package:bangsatnyacintapertama/app/service/locator/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_sizes.dart';
import '../../app/theme/app_text_style.dart';
import '../../app/utility/date_formatter.dart';
import '../../view_model/check_in_view_model.dart';

class QRCodeScannerView extends StatefulWidget {
  const QRCodeScannerView({super.key});

  static String routeName = '/qrcode-scanner';

  @override
  State<QRCodeScannerView> createState() => _QRCodeScannerViewState();
}

class _QRCodeScannerViewState extends State<QRCodeScannerView> {
  @override
  void initState() {
    locator<CheckInViewModel>().scannedGuest = null;
    super.initState();
  }

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
    // return Consumer<NetworkCheckerService>(builder: (context, model, _) {
    //   if (!model.isConnected) {
    //     return Center(child: noInternet());
    //   }

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.padding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            header(),
            scanner(),
            result(),
          ],
        ),
      ),
    );
    // });
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
          textAlign: TextAlign.center,
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
    return Consumer<CheckInViewModel>(builder: (context, model, _) {
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
                final navigator = Navigator.of(context);
                final List<Barcode> barcodes = capture.barcodes;
                // final Uint8List? image = capture.image;
                // for (final barcode in barcodes) {
                debugPrint('Barcode found! ${barcodes.firstOrNull?.rawValue}');

                if (barcodes.firstOrNull?.rawValue != null) {
                  model.qrCodeScan(navigator: navigator, guestId: barcodes.first.rawValue!);
                }
                // }
              },
            ),
          ),
        ),
      );
    });
  }

  Widget result() {
    return Consumer<CheckInViewModel>(builder: (context, model, _) {
      if (model.scannedGuest == null) {
        return const SizedBox.shrink();
      }

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!model.scannedGuest!.isSuccess) ...[
            Text(
              '⚠︎  ${model.scannedGuest?.message}',
              textAlign: TextAlign.center,
              style: AppTextStyle.bold(
                context,
                fontSize: 16,
                color: AppColors.red,
              ),
            ),
          ],
          const SizedBox(height: AppSizes.padding / 4),
          Text(
            model.scannedGuest?.qrData.guest.invitationName ?? '-',
            textAlign: TextAlign.center,
            style: AppTextStyle.bold(
              context,
              fontSize: 26,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: AppSizes.padding / 2),
          Text(
            'Berhasil Check-In pada ${model.scannedGuest?.qrData.createdAt != null ? DateFormatter.slashDateShortedYearWithClock(model.scannedGuest!.qrData.createdAt) : '-'}',
            textAlign: TextAlign.center,
            style: AppTextStyle.medium(
              context,
              fontSize: 14,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: AppSizes.padding),
          Text(
            'Seat ${model.scannedGuest?.qrData.guest.seat}',
            textAlign: TextAlign.center,
            style: AppTextStyle.bold(
              context,
              fontSize: 26,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: AppSizes.padding),
          Text(
            'Studio: ${model.scannedGuest?.qrData.guest.studio}  |  Show Time: ${model.scannedGuest?.qrData.guest.showTime}',
            textAlign: TextAlign.center,
            style: AppTextStyle.bold(
              context,
              fontSize: 20,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: AppSizes.padding),
        ],
      );
    });
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
