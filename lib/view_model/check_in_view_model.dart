import 'dart:async';

import 'package:bangsatnyacintapertama/app/service/auth/auth_service.dart';
import 'package:bangsatnyacintapertama_graphql_client/gql_guest_service.dart';
import 'package:bangsatnyacintapertama_graphql_client/operations/generated/guest_find_many_order_by_qr_code_scan.graphql.dart';
import 'package:bangsatnyacintapertama_graphql_client/operations/generated/qr_code_scan.graphql.dart';
import 'package:bangsatnyacintapertama_graphql_client/schema/generated/schema.graphql.dart';
import 'package:bangsatnyacintapertama_graphql_client/utils/gql_error_parser.dart';
import 'package:flutter/material.dart';

import '../app/const/app_const.dart';
import '../app/utility/console_log.dart';
import '../model/menu_item_model.dart';
import '../widget/atom/app_dialog.dart';
import '../widget/atom/app_snackbar.dart';

class CheckInViewModel extends ChangeNotifier {
  int totalCheckIn = 0;
  int totalUncheckIn = 0;
  int totalEmptySeat = 0;

  TextEditingController searchController = TextEditingController();

  List<Query$GuestFindManyOrderByQrCodeScan$guestFindMany>? guests;
  List<Query$GuestFindManyOrderByQrCodeScan$guestFindMany> selectedGuests = [];

  MenuItemModel? selectedAction = checkInActionDropdownItems.first;
  MenuItemModel? selectedSort = guestSortirDropdownItems.first;

  Enum$SortOrder invitationNameSortOrder = Enum$SortOrder.asc;
  // Enum$SortOrder sourceSortOrder = Enum$SortOrder.asc;
  Enum$SortOrder seatSortOrder = Enum$SortOrder.asc;
  Enum$SortOrder scannedAtSortOrder = Enum$SortOrder.asc;

  Query$QrCodeScan$qrCodeScan? scannedGuest;

  Timer? timer;

  void resetState() {
    totalCheckIn = 0;
    totalUncheckIn = 0;
    totalEmptySeat = 0;
    guests = null;
    selectedGuests = [];

    selectedAction = checkInActionDropdownItems.first;
    selectedSort = guestSortirDropdownItems.last;

    invitationNameSortOrder = Enum$SortOrder.asc;
    // sourceSortOrder = Enum$SortOrder.asc;
    seatSortOrder = Enum$SortOrder.asc;
    scannedAtSortOrder = Enum$SortOrder.asc;

    timer?.cancel();
    timer = null;
  }

  Future<void> initCheckInView() async {
    countTotalCheckIn();
    counttotalUnCheckIn();
    counttotalEmptySeat();
    getAllGuests();
  }

  void refreshData({bool reset = false}) async {
    if (reset) {
      guests = null;
      notifyListeners();
    }

    getAllGuests(contains: searchController.text);
  }

  Future<void> countTotalCheckIn() async {
    var res = await GqlGuestService.guestCountWhereScannetAtNotNull();

    if (res.parsedData?.guestCount != null && !res.hasException) {
      totalCheckIn = (res.parsedData?.guestCount ?? 0).toInt();
      notifyListeners();
    } else {
      cl('[countTotalCheckIn].error = ${gqlErrorParser(res)}');
    }
  }

  Future<void> counttotalUnCheckIn() async {
    var res = await GqlGuestService.guestCountWhereConfirmationStatusAndQrCodeScannedAtNull();

    if (res.parsedData?.guestCount != null && !res.hasException) {
      totalUncheckIn = (res.parsedData?.guestCount ?? 0).toInt();
      notifyListeners();
    } else {
      cl('[counttotalUnCheckIn].error = ${gqlErrorParser(res)}');
    }
  }

  Future<void> counttotalEmptySeat() async {
    var res = await GqlGuestService.guestCountWhereInvitedButNotCheckinYet();

    if (res.parsedData?.guestCount != null && !res.hasException) {
      totalEmptySeat = (res.parsedData?.guestCount ?? 0).toInt();
      notifyListeners();
    } else {
      cl('[counttotalEmptySeat].error = ${gqlErrorParser(res)}');
    }
  }

  Future<void> getAllGuests({
    int skip = 0,
    String contains = "",
  }) async {
    var res = await GqlGuestService.guestFindManyOrderByQrCodeScan(
      skip: skip,
      contains: contains,
      // userRole: userRole,
      // confirmationStatus: confirmationStatus,
      // emailQueueStatus: emailQueueStatus,
      // whatsAppQueueStatus: whatsAppQueueStatus,
      invitationNameSortOrder: invitationNameSortOrder,
      // sourceSortOrder: sourceSortOrder,
      seatSortOrder: seatSortOrder,
      scannedAtSortOrder: scannedAtSortOrder,
    );

    if (res.parsedData?.guestFindMany != null && !res.hasException) {
      if (skip == 0) {
        guests = res.parsedData?.guestFindMany ?? [];
      } else {
        guests?.addAll(res.parsedData?.guestFindMany ?? []);
      }
    } else {
      cl('[getAllGuests].error = ${gqlErrorParser(res)}');
    }

    notifyListeners();
  }

  Future<void> deleteGuestData(NavigatorState navigator) async {
    AppDialog.showDialogProgress(navigator);

    var res = await GqlGuestService.qrCodeDeleteMany(guests: selectedGuests);

    if (res.hasException) {
      navigator.pop();

      AppSnackbar.show(navigator, title: "Gagal dihapus");
    } else {
      selectedGuests.clear();
      navigator.pop();
      AppSnackbar.show(navigator, title: "Berhasil dihapus");
    }

    notifyListeners();
  }

  Future<void> qrCodeScan({
    required NavigatorState navigator,
    required String guestId,
  }) async {
    if (timer != null) {
      return;
    }

    timer = Timer(const Duration(seconds: 3), () {
      print("Yeah, this line is printed after 2 seconds");
      timer?.cancel();
      timer = null;
    });

    var res = await GqlGuestService.qrCodeScan(
      userId: AuthService.user!.id,
      guestId: guestId,
    );

    cl('USER ID ' + AuthService.user!.id);
    cl('GUEST ID ' + guestId);
    cl(res);

    if (res.parsedData?.qrCodeScan != null) {
      scannedGuest = res.parsedData?.qrCodeScan;
    } else {
      AppSnackbar.show(navigator, title: "Gagal check-in, silahkan coba lagi");
      cl('[qrCodeScan].error = ${gqlErrorParser(res)}');
    }

    notifyListeners();
  }

  void onSelectAll(bool? val) {
    if (val == null || guests == null) {
      return;
    }

    if (val) {
      selectedGuests.addAll(guests!);
    } else {
      selectedGuests.clear();
    }

    notifyListeners();
  }

  void onSelect(bool? val, int i) {
    if (val == null || guests == null) {
      return;
    }

    if (val) {
      selectedGuests.add(guests![i]);
    } else {
      selectedGuests.remove(guests![i]);
    }

    notifyListeners();
  }
}
