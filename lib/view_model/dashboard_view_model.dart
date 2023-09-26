import 'package:flutter/material.dart';

class DashboardViewModel extends ChangeNotifier {
  int totalGuest = 0;
  int totalGuestConfirmed = 0;
  int totalGuestRejected = 0;
  int totalGuestInvitationSent = 0;
  int totalGuestInvitationFailedSent = 0;
  int totalGuestInvitationUnconfirmed = 0;

  void resetState() {
    totalGuest = 0;
    totalGuestConfirmed = 0;
    totalGuestRejected = 0;
    totalGuestInvitationSent = 0;
    totalGuestInvitationFailedSent = 0;
    totalGuestInvitationUnconfirmed = 0;
  }

  Future<void> initDashboardView() async {
    // countTotalGuest();
    // counttotalGuestConfirmed();
    // counttotalGuestInvitationUnconfirmed();
    // counttotalGuestRejected();
    // counttotalGuestInvitationSent();
    // counttotalGuestInvitationFailedSent();
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

  // Future<void> counttotalGuestConfirmed() async {
  //   var res = await GqlUserService.countUserWhereRoleIsGuestAndConfirmationStatusIsConfirmed();

  //   if (res.parsedData?.userCount != null && !res.hasException) {
  //     totalGuestConfirmed = (res.parsedData?.userCount ?? 0).toInt();
  //     notifyListeners();
  //   } else {
  //     cl('[counttotalGuestConfirmed].error = ${gqlErrorParser(res)}');
  //   }
  // }

  // Future<void> counttotalGuestInvitationUnconfirmed() async {
  //   var res = await GqlUserService.countUserWhereRoleIsGuestAndConfirmationStatusIsUnconfirmed();

  //   if (res.parsedData?.userCount != null && !res.hasException) {
  //     totalGuestInvitationUnconfirmed = (res.parsedData?.userCount ?? 0).toInt();
  //     notifyListeners();
  //   } else {
  //     cl('[counttotalGuestInvitationUnconfirmed].error = ${gqlErrorParser(res)}');
  //   }
  // }

  // Future<void> counttotalGuestRejected() async {
  //   var res = await GqlUserService.countUserWhereRoleIsGuestAndConfirmationStatusIsRejected();

  //   if (res.parsedData?.userCount != null && !res.hasException) {
  //     totalGuestRejected = (res.parsedData?.userCount ?? 0).toInt();
  //     notifyListeners();
  //   } else {
  //     cl('[counttotalGuestRejected].error = ${gqlErrorParser(res)}');
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
}
