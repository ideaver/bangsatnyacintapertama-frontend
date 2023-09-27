import 'package:bangsatnyacintapertama_graphql_client/gql_guest_service.dart';
import 'package:bangsatnyacintapertama_graphql_client/operations/generated/guest_find_many_by_invitation_name.graphql.dart';
import 'package:bangsatnyacintapertama_graphql_client/schema/generated/schema.graphql.dart';
import 'package:bangsatnyacintapertama_graphql_client/utils/gql_error_parser.dart';
import 'package:flutter/material.dart';

import '../app/service/locator/service_locator.dart';
import '../app/utility/console_log.dart';
import '../widget/atom/app_dialog.dart';
import '../widget/atom/app_snackbar.dart';
import 'guest_invitation_view_model.dart';

class GuestAddEditViewModel extends ChangeNotifier {
  Query$GuestFindManyByInvitationName$guestFindMany? guest;

  Enum$ConfirmationStatus confirmationStatus = Enum$ConfirmationStatus.CONFIRMED;

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController sourceCtrl = TextEditingController();
  TextEditingController contactListCtrl = TextEditingController();
  TextEditingController whatsAppCtrl = TextEditingController();
  TextEditingController categoryCtrl = TextEditingController();
  TextEditingController studioCtrl = TextEditingController();
  TextEditingController seatCtrl = TextEditingController();
  TextEditingController showTimeCtrl = TextEditingController();

  void resetState() {
    guest = null;
    confirmationStatus = Enum$ConfirmationStatus.CONFIRMED;
  }

  Future<void> initInvitationView(Query$GuestFindManyByInvitationName$guestFindMany? data) async {
    if (data != null) {
      guest = data;

      nameCtrl.text = guest?.invitationName ?? '';
      sourceCtrl.text = guest?.source ?? '';
      contactListCtrl.text = guest?.contactList ?? '';
      whatsAppCtrl.text = guest?.whatsapp.toString() ?? '';
      categoryCtrl.text = guest?.category ?? '';
      studioCtrl.text = guest?.studio ?? '';
      seatCtrl.text = guest?.seat ?? '';
      showTimeCtrl.text = guest?.showTime ?? '';

      confirmationStatus = guest?.confirmationStatus ?? Enum$ConfirmationStatus.CONFIRMED;
    } else {
      guest = Query$GuestFindManyByInvitationName$guestFindMany(
        id: '',
        invitationName: nameCtrl.text,
        source: sourceCtrl.text,
        contactList: contactListCtrl.text,
        whatsapp: double.tryParse(whatsAppCtrl.text)?.sign,
        category: categoryCtrl.text,
        studio: studioCtrl.text,
        seat: seatCtrl.text,
        showTime: showTimeCtrl.text,
      );
    }

    notifyListeners();
  }

  void addEditGuest(NavigatorState navigator) async {
    if (guest == null) {
      cl('[addEditGuest].guest = null');
      return;
    }

    AppDialog.showDialogProgress(navigator);

    var data = Query$GuestFindManyByInvitationName$guestFindMany(
      id: guest!.id,
      invitationName: nameCtrl.text,
      source: sourceCtrl.text,
      contactList: contactListCtrl.text,
      whatsapp: double.tryParse(whatsAppCtrl.text)?.sign,
      category: categoryCtrl.text,
      studio: studioCtrl.text,
      seat: seatCtrl.text,
      showTime: showTimeCtrl.text,
      confirmationStatus: confirmationStatus,
    );

    var res = guest!.id.isEmpty
        ? await GqlGuestService.guestCreateOne(guest: data)
        : await GqlGuestService.guestUpdateOne(guest: data);

    cl(nameCtrl.text);
    cl(data.toJson());
    cl(res);

    if (!res.hasException) {
      navigator.pop();
      navigator.pop();
      AppSnackbar.show(navigator, title: "Berhasil ${guest!.id.isEmpty ? 'ditambah' : 'diperbarui'}");
    } else {
      navigator.pop();
      navigator.pop();
      AppDialog.showErrorDialog(navigator, error: gqlErrorParser(res));
      cl('[counttotalGuestInvitationSent].error = ${gqlErrorParser(res)}');
    }

    locator<GuestInvitationViewModel>().refreshData();
  }
}
