import 'package:bangsatnyacintapertama/widget/atom/app_dialog.dart';
import 'package:bangsatnyacintapertama_graphql_client/gql_guest_service.dart';
import 'package:bangsatnyacintapertama_graphql_client/operations/generated/guest_find_many_by_invitation_name.graphql.dart';
import 'package:bangsatnyacintapertama_graphql_client/schema/generated/schema.graphql.dart';
import 'package:bangsatnyacintapertama_graphql_client/utils/gql_error_parser.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

import '../app/const/app_const.dart';
import '../app/utility/console_log.dart';
import '../model/menu_item_model.dart';
import '../widget/atom/app_snackbar.dart';

class GuestInvitationViewModel extends ChangeNotifier {
  int totalGuest = 0;
  int totalGuestInvitationSent = 0;
  int totalGuestInvitationFailedSent = 0;

  TextEditingController searchController = TextEditingController();

  List<Query$GuestFindManyByInvitationName$guestFindMany>? guests;
  List<Query$GuestFindManyByInvitationName$guestFindMany> selectedGuests = [];

  // MenuItemModel? selectedAction = actionDropdownItems.first;
  MenuItemModel? selectedSort = guestSortirDropdownItems.first;
  MenuItemModel? selectedStatus = statusDropdownItems.last;

  Enum$SortOrder invitationNameSortOrder = Enum$SortOrder.asc;
  Enum$SortOrder sourceSortOrder = Enum$SortOrder.asc;
  Enum$SortOrder seatSortOrder = Enum$SortOrder.asc;

  Enum$UserRole userRole = Enum$UserRole.GUEST;
  Enum$ConfirmationStatus? confirmationStatus;
  List<Enum$QueueStatus>? emailQueueStatus;
  List<Enum$QueueStatus>? whatsAppQueueStatus;

  void resetState() {
    totalGuest = 0;
    totalGuestInvitationSent = 0;
    totalGuestInvitationFailedSent = 0;
    guests = null;
    selectedGuests = [];

    selectedSort = actionDropdownItems.first;
    selectedStatus = statusDropdownItems.last;

    userRole = Enum$UserRole.GUEST;
    confirmationStatus = null;
    emailQueueStatus = null;
    whatsAppQueueStatus = null;
  }

  Future<void> initInvitationView() async {
    countTotalGuest();
    counttotalGuestInvitationSent();
    counttotalGuestInvitationFailedSent();
    getAllGuests();

    // TEST PURPOSE
    // guests = [
    //   ...List.generate(
    //     20,
    //     (index) => Query$UserFindMany$userFindMany(
    //       id: '',
    //       fullName: 'User ${index + 1}',
    //       password: "",
    //       role: Enum$UserRole.GUEST,
    //       email: "user${index + 1}@user.com",
    //       whatsapp: "+6283366446${index + 10}",
    //       guestInfo: Query$UserFindMany$userFindMany$guestInfo(
    //         userId: "",
    //         parties: 1,
    //         confirmationStatus: Enum$ConfirmationStatus.CONFIRMED,
    //         personInCharge: "User X",
    //         category1: "Guest",
    //         category2: "VIP",
    //         seat: "${index + 1}",
    //       ),
    //       createdAt: DateTime.now().toIso8601String(),
    //       updatedAt: DateTime.now().toIso8601String(),
    //     ),
    //   )
    // ];
  }

  void refreshData({bool reset = false}) async {
    if (reset) {
      guests = null;
      notifyListeners();
    }

    getAllGuests(contains: searchController.text);
  }

  Future<void> countTotalGuest() async {
    var res = await GqlGuestService.countGuest();

    if (res.parsedData?.guestCount != null && !res.hasException) {
      totalGuest = (res.parsedData?.guestCount ?? 0).toInt();
      notifyListeners();
    } else {
      cl('[countTotalGuest].error = ${gqlErrorParser(res)}');
    }
  }

  Future<void> counttotalGuestInvitationSent() async {
    var res = await GqlGuestService.guestCountWhereWhatsappStatusSent();

    if (res.parsedData?.guestCount != null && !res.hasException) {
      totalGuestInvitationSent = (res.parsedData?.guestCount ?? 0).toInt();
      notifyListeners();
    } else {
      cl('[counttotalGuestInvitationSent].error = ${gqlErrorParser(res)}');
    }
  }

  Future<void> counttotalGuestInvitationFailedSent() async {
    var res = await GqlGuestService.guestCountWhereWhatsappStatusNeverSent();

    if (res.parsedData?.guestCount != null && !res.hasException) {
      totalGuestInvitationFailedSent = (res.parsedData?.guestCount ?? 0).toInt();
      notifyListeners();
    } else {
      cl('[counttotalGuestInvitationFailedSent].error = ${gqlErrorParser(res)}');
    }
  }

  Future<void> getAllGuests({
    int skip = 0,
    String contains = "",
  }) async {
    var res = await GqlGuestService.guestFindManyByInvitationName(
      skip: skip,
      contains: contains,
      // userRole: userRole,
      confirmationStatus: confirmationStatus,
      // emailQueueStatus: emailQueueStatus,
      whatsAppQueueStatus: whatsAppQueueStatus,
      invitationNameSortOrder: invitationNameSortOrder,
      sourceSortOrder: sourceSortOrder,
      seatSortOrder: seatSortOrder,
    );

    cl("getAllGuests $contains");

    if (res.parsedData?.guestFindMany != null && !res.hasException) {
      if (skip == 0) {
        guests = res.parsedData?.guestFindMany ?? [];
      } else {
        guests?.addAll(res.parsedData?.guestFindMany ?? []);
      }
    } else {
      cl('[getAllGuests].error = ${gqlErrorParser(res)}');
    }

    cl(guests?.length);

    notifyListeners();
  }

  Future<void> deleteGuestData(NavigatorState navigator) async {
    AppDialog.showDialogProgress(navigator);

    var res = await GqlGuestService.guestDeleteMany(guests: selectedGuests);

    if (res.hasException) {
      navigator.pop();
      selectedGuests.clear();
      AppSnackbar.show(navigator, title: "Gagal dihapus");
    } else {
      navigator.pop();
      AppSnackbar.show(navigator, title: "Berhasil dihapus");
    }
  }

  Future<void> uploadGuestInvitationFile(Uint8List bytes, NavigatorState navigator) async {
    List<int> list = bytes.cast();

    var multipartFile = MultipartFile.fromBytes(
      'file',
      list,
      filename: '${DateTime.now().second}.xlsx',
      contentType: MediaType('*', '*'),
    );

    var res = await GqlGuestService.uploadSingleFile(
      multipartFile: multipartFile,
    );

    if (res.parsedData?.uploadSingleFile != null && !res.hasException) {
      navigator.pop();

      AppSnackbar.show(navigator, title: "Berhasil diupload");
    } else {
      navigator.pop();

      AppSnackbar.show(
        navigator,
        title: "Gagal diupload ${res.exception?.graphqlErrors.firstOrNull?.extensions?['code']}",
      );

      cl('[uploadGuestInvitationFile].error = ${gqlErrorParser(res)}');
    }
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

    cl(val);
    cl(selectedGuests.length);
    cl(guests?.length);
    cl(selectedGuests.length == guests?.length);

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

    cl(val);
    cl(selectedGuests.length);
    cl(guests?.length);

    notifyListeners();
  }
}
