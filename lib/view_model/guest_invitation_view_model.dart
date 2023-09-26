import 'package:bangsatnyacintapertama_graphql_client/gql_guest_service.dart';
import 'package:bangsatnyacintapertama_graphql_client/operations/generated/guest_find_many_by_invitation_name.graphql.dart';
import 'package:bangsatnyacintapertama_graphql_client/schema/generated/schema.graphql.dart';
import 'package:bangsatnyacintapertama_graphql_client/utils/gql_error_parser.dart';
import 'package:flutter/material.dart';

import '../app/const/app_const.dart';
import '../app/utility/console_log.dart';
import '../model/menu_item_model.dart';

class GuestInvitationViewModel extends ChangeNotifier {
  int totalGuest = 0;
  int totalGuestInvitationSent = 0;
  int totalGuestInvitationFailedSent = 0;

  List<Query$GuestFindManyOrderByInvitationName$guestFindMany>? guests;
  List<Query$GuestFindManyOrderByInvitationName$guestFindMany> selectedGuests = [];

  MenuItemModel? selectedAction = actionDropdownItems.first;
  MenuItemModel? selectedStatus = statusDropdownItems.last;

  Enum$UserRole userRole = Enum$UserRole.GUEST;
  Enum$ConfirmationStatus confirmationStatus = Enum$ConfirmationStatus.CONFIRMED;
  List<Enum$QueueStatus>? emailQueueStatus;
  List<Enum$QueueStatus>? whatsAppQueueStatus;

  void resetState() {
    totalGuest = 0;
    totalGuestInvitationSent = 0;
    totalGuestInvitationFailedSent = 0;
  }

  Future<void> initInvitationView() async {
    // countTotalGuest();
    // counttotalGuestInvitationSent();
    // counttotalGuestInvitationFailedSent();
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

  // Future<void> countTotalGuest() async {
  //   var res = await GqlUserService.countUserWhereRoleIsGuest();

  //   if (res.parsedData?.userCount != null && !res.hasException) {
  //     totalGuest = (res.parsedData?.userCount ?? 0).toInt();
  //     notifyListeners();
  //   } else {
  //     cl('[countTotalGuest].error = ${gqlErrorParser(res)}');
  //   }
  // }

  // Future<void> counttotalGuestInvitationSent() async {
  //   var res = await GqlUserService.countUserWhereRoleIsGuestAndEmailOrWhatsappStatusEqualSent();

  //   if (res.parsedData?.userCount != null && !res.hasException) {
  //     totalGuestInvitationSent = (res.parsedData?.userCount ?? 0).toInt();
  //     notifyListeners();
  //   } else {
  //     cl('[counttotalGuestInvitationSent].error = ${gqlErrorParser(res)}');
  //   }
  // }

  // Future<void> counttotalGuestInvitationFailedSent() async {
  //   var res = await GqlUserService.countUserWhereRoleIsGuestAndConfirmationStatusIsUnconfirmed();

  //   if (res.parsedData?.userCount != null && !res.hasException) {
  //     totalGuestInvitationFailedSent = (res.parsedData?.userCount ?? 0).toInt();
  //     notifyListeners();
  //   } else {
  //     cl('[counttotalGuestInvitationFailedSent].error = ${gqlErrorParser(res)}');
  //   }
  // }

  Future<void> getAllGuests({
    int skip = 0,
    String contains = "",
  }) async {
    var res = await GqlGuestService.guestFindManyOrderByInvitationName(
      skip: skip,
      // contains: contains,
      // userRole: userRole,
      // confirmationStatus: confirmationStatus,
      // emailQueueStatus: emailQueueStatus,
      // whatsAppQueueStatus: whatsAppQueueStatus,
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

  // void deleteGuestData(NavigatorState navigator) async {
  //   var res = await GqlUserService.userSoftDeletes(users: selectedGuests);

  //   if (!res.hasException) {
  //     selectedGuests.clear();
  //     initInvitationView();
  //     AppSnackbar.show(navigator, title: "Berhasil dihapus");
  //   } else {
  //     AppDialog.showErrorDialog(navigator, error: gqlErrorParser(res));
  //     cl('[counttotalGuestInvitationSent].error = ${gqlErrorParser(res)}');
  //   }
  // }

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
