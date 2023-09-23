import 'package:bangsatnyacintapertama_graphql_client/gql_user_service.dart';
import 'package:bangsatnyacintapertama_graphql_client/operations/generated/user_find_many.graphql.dart';
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

  List<Query$UserFindMany$userFindMany> guests = [];
  List<Query$UserFindMany$userFindMany> selectedGuests = [];

  MenuItemModel? selectedAction = checkInActionDropdownItems.first;
  MenuItemModel? selectedSortir = checkInSortirDropdownItems.first;

  Enum$UserRole userRole = Enum$UserRole.GUEST;
  Enum$ConfirmationStatus confirmationStatus = Enum$ConfirmationStatus.CONFIRMED;
  List<Enum$QueueStatus>? emailQueueStatus;
  List<Enum$QueueStatus>? whatsAppQueueStatus;

  void resetState() {
    totalCheckIn = 0;
    totalUncheckIn = 0;
    totalEmptySeat = 0;
  }

  Future<void> initCheckInView() async {
    countTotalCheckIn();
    counttotalUnCheckIn();
    counttotalEmptySeat();
    getAllGuests();
  }

  Future<void> countTotalCheckIn() async {
    var res = await GqlUserService.countUserWhereRoleIsGuest();

    if (res.parsedData?.userCount != null && !res.hasException) {
      totalCheckIn = (res.parsedData?.userCount ?? 0).toInt();
      notifyListeners();
    } else {
      cl('[countTotalCheckIn].error = ${gqlErrorParser(res)}');
    }
  }

  Future<void> counttotalUnCheckIn() async {
    var res = await GqlUserService.countUserWhereRoleIsGuestAndEmailOrWhatsappStatusEqualSent();

    if (res.parsedData?.userCount != null && !res.hasException) {
      totalUncheckIn = (res.parsedData?.userCount ?? 0).toInt();
      notifyListeners();
    } else {
      cl('[counttotalUnCheckIn].error = ${gqlErrorParser(res)}');
    }
  }

  Future<void> counttotalEmptySeat() async {
    var res = await GqlUserService.countUserWhereRoleIsGuestAndConfirmationStatusIsUnconfirmed();

    if (res.parsedData?.userCount != null && !res.hasException) {
      totalEmptySeat = (res.parsedData?.userCount ?? 0).toInt();
      notifyListeners();
    } else {
      cl('[counttotalEmptySeat].error = ${gqlErrorParser(res)}');
    }
  }

  Future<void> getAllGuests({
    int skip = 0,
    String contains = "",
  }) async {
    var res = await GqlUserService.userFindMany(
      skip: skip,
      contains: contains,
      userRole: userRole,
      confirmationStatus: confirmationStatus,
      emailQueueStatus: emailQueueStatus,
      whatsAppQueueStatus: whatsAppQueueStatus,
    );

    if (res.parsedData?.userFindMany != null && !res.hasException) {
      if (skip == 0) {
        guests = res.parsedData?.userFindMany ?? [];
      } else {
        guests.addAll(res.parsedData?.userFindMany ?? []);
      }
    } else {
      cl('[getAllGuests].error = ${gqlErrorParser(res)}');
    }

    notifyListeners();
  }

  void deleteGuestData(NavigatorState navigator) async {
    var res = await GqlUserService.userSoftDeletes(users: selectedGuests);

    if (!res.hasException) {
      selectedGuests.clear();
      initCheckInView();
      AppSnackbar.show(navigator, title: "Berhasil dihapus");
    } else {
      AppDialog.showErrorDialog(navigator, error: gqlErrorParser(res));
      cl('[counttotalUnCheckIn].error = ${gqlErrorParser(res)}');
    }
  }

  void onSelectAll(bool? val) {
    if (val == null) {
      return;
    }

    if (val) {
      selectedGuests.addAll(guests);
    } else {
      selectedGuests.clear();
    }

    notifyListeners();
  }

  void onSelect(bool? val, int i) {
    if (val == null) {
      return;
    }

    if (val) {
      selectedGuests.add(guests[i]);
    } else {
      selectedGuests.remove(guests[i]);
    }

    notifyListeners();
  }
}
