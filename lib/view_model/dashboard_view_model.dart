import 'package:bangsatnyacintapertama_graphql_client/gql_guest_service.dart';
import 'package:bangsatnyacintapertama_graphql_client/utils/gql_error_parser.dart';
import 'package:flutter/material.dart';

import '../app/utility/console_log.dart';

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
    countTotalGuest();
    counttotalGuestConfirmed();
    counttotalGuestInvitationUnconfirmed();
    counttotalGuestRejected();
    counttotalGuestInvitationSent();
    counttotalGuestInvitationFailedSent();
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

  Future<void> counttotalGuestConfirmed() async {
    var res = await GqlGuestService.guestCountWhereConfirmed();

    if (res.parsedData?.guestCount != null && !res.hasException) {
      totalGuestConfirmed = (res.parsedData?.guestCount ?? 0).toInt();
      notifyListeners();
    } else {
      cl('[counttotalGuestConfirmed].error = ${gqlErrorParser(res)}');
    }
  }

  Future<void> counttotalGuestInvitationUnconfirmed() async {
    var res = await GqlGuestService.guestCountWhereUnconfirmed();

    if (res.parsedData?.guestCount != null && !res.hasException) {
      totalGuestInvitationUnconfirmed = (res.parsedData?.guestCount ?? 0).toInt();
      notifyListeners();
    } else {
      cl('[counttotalGuestInvitationUnconfirmed].error = ${gqlErrorParser(res)}');
    }
  }

  Future<void> counttotalGuestRejected() async {
    var res = await GqlGuestService.guestCountWhereRejected();

    if (res.parsedData?.guestCount != null && !res.hasException) {
      totalGuestRejected = (res.parsedData?.guestCount ?? 0).toInt();
      notifyListeners();
    } else {
      cl('[counttotalGuestRejected].error = ${gqlErrorParser(res)}');
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
}
