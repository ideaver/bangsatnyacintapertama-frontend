import 'package:bangsatnyacintapertama/widget/atom/app_dropdown.dart';
import 'package:bangsatnyacintapertama_graphql_client/operations/generated/guest_find_many_by_invitation_name.graphql.dart';
import 'package:bangsatnyacintapertama_graphql_client/schema/generated/schema.graphql.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/service/locator/service_locator.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_sizes.dart';
import '../../app/theme/app_text_style.dart';
import '../../app/utility/console_log.dart';
import '../../view_model/guest_add_edit_view.dart';
import '../../widget/atom/app_button.dart';
import '../../widget/atom/app_card_container.dart';
import '../../widget/atom/app_text_field.dart';
import '../../widget/atom/app_text_fields_wrapper.dart';

class AddEditGuestDialog extends StatefulWidget {
  final Query$GuestFindManyByInvitationName$guestFindMany? guest;

  const AddEditGuestDialog({Key? key, this.guest}) : super(key: key);

  @override
  State<AddEditGuestDialog> createState() => _AddEditGuestDialogState();
}

class _AddEditGuestDialogState extends State<AddEditGuestDialog> {
  final _guestAddEditViewModel = locator<GuestAddEditViewModel>();

  var confirmationStatusses = Enum$ConfirmationStatus.values;

  @override
  void initState() {
    _guestAddEditViewModel.nameCtrl = TextEditingController();
    _guestAddEditViewModel.sourceCtrl = TextEditingController();
    _guestAddEditViewModel.contactListCtrl = TextEditingController();
    _guestAddEditViewModel.whatsAppCtrl = TextEditingController();
    _guestAddEditViewModel.categoryCtrl = TextEditingController();
    _guestAddEditViewModel.studioCtrl = TextEditingController();
    _guestAddEditViewModel.seatCtrl = TextEditingController();
    _guestAddEditViewModel.showTimeCtrl = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _guestAddEditViewModel.initInvitationView(widget.guest);
    });
    super.initState();
  }

  @override
  void dispose() {
    _guestAddEditViewModel.nameCtrl.dispose();
    _guestAddEditViewModel.sourceCtrl.dispose();
    _guestAddEditViewModel.contactListCtrl.dispose();
    _guestAddEditViewModel.whatsAppCtrl.dispose();
    _guestAddEditViewModel.categoryCtrl.dispose();
    _guestAddEditViewModel.studioCtrl.dispose();
    _guestAddEditViewModel.seatCtrl.dispose();
    _guestAddEditViewModel.showTimeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _guestAddEditViewModel,
      builder: (context, snapshot) {
        return Consumer<GuestAddEditViewModel>(
          builder: (context, model, _) {
            return Column(
              children: [
                widget.guest == null ? addForm(model) : updateForm(model),
                const SizedBox(height: AppSizes.padding * 2),
                submitButton(model),
              ],
            );
          },
        );
      },
    );
  }

  Widget addForm(GuestAddEditViewModel model) {
    return AppTextFieldsWrapper(
      textFields: [
        AppTextField(
          controller: model.nameCtrl,
          lableText: 'Nama',
        ),
        const Divider(
          color: AppColors.baseLv6,
          thickness: 1.5,
          height: 0,
        ),
        AppTextField(
          controller: model.sourceCtrl,
          lableText: 'Source',
        ),
        const Divider(
          color: AppColors.baseLv6,
          thickness: 1.5,
          height: 0,
        ),
        AppTextField(
          controller: model.contactListCtrl,
          lableText: 'Contact List',
        ),
        const Divider(
          color: AppColors.baseLv6,
          thickness: 1.5,
          height: 0,
        ),
        AppTextField(
          controller: model.whatsAppCtrl,
          lableText: 'WhatsApp',
        ),
        const Divider(
          color: AppColors.baseLv6,
          thickness: 1.5,
          height: 0,
        ),
        AppTextField(
          controller: model.categoryCtrl,
          lableText: 'Category',
        ),
        const Divider(
          color: AppColors.baseLv6,
          thickness: 1.5,
          height: 0,
        ),
        AppTextField(
          controller: model.studioCtrl,
          lableText: 'Studio',
        ),
        const Divider(
          color: AppColors.baseLv6,
          thickness: 1.5,
          height: 0,
        ),
        AppTextField(
          controller: model.seatCtrl,
          lableText: 'Seat',
        ),
        const Divider(
          color: AppColors.baseLv6,
          thickness: 1.5,
          height: 0,
        ),
        AppTextField(
          controller: model.showTimeCtrl,
          lableText: 'Show Time',
        ),
      ],
    );
  }

  Widget updateForm(GuestAddEditViewModel model) {
    return AppTextFieldsWrapper(
      textFields: [
        AppTextField(
          controller: model.nameCtrl,
          lableText: 'Nama',
        ),
        const Divider(
          color: AppColors.baseLv6,
          thickness: 1.5,
          height: 0,
        ),
        AppTextField(
          controller: model.sourceCtrl,
          lableText: 'Source',
        ),
        const Divider(
          color: AppColors.baseLv6,
          thickness: 1.5,
          height: 0,
        ),
        AppTextField(
          controller: model.contactListCtrl,
          lableText: 'Contact List',
        ),
        // const Divider(
        //   color: AppColors.baseLv6,
        //   thickness: 1.5,
        //   height: 0,
        // ),
        // AppTextField(
        //   controller: model.whatsAppCtrl,
        //   lableText: 'WhatsApp',
        // ),
        const Divider(
          color: AppColors.baseLv6,
          thickness: 1.5,
          height: 0,
        ),
        AppTextField(
          controller: model.categoryCtrl,
          lableText: 'Category',
        ),
        const Divider(
          color: AppColors.baseLv6,
          thickness: 1.5,
          height: 0,
        ),
        AppTextField(
          controller: model.studioCtrl,
          lableText: 'Studio',
        ),
        const Divider(
          color: AppColors.baseLv6,
          thickness: 1.5,
          height: 0,
        ),
        AppTextField(
          controller: model.seatCtrl,
          lableText: 'Seat',
        ),
        const Divider(
          color: AppColors.baseLv6,
          thickness: 1.5,
          height: 0,
        ),
        AppTextField(
          controller: model.showTimeCtrl,
          lableText: 'Show Time',
        ),
        const Divider(
          color: AppColors.baseLv6,
          thickness: 1.5,
          height: 0,
        ),
        AppDropDown(
          customButton: AppCardContainer(
            margin: EdgeInsets.zero,
            backgroundColor: AppColors.transparent,
            padding: const EdgeInsets.symmetric(
              vertical: AppSizes.padding * 1.5,
              horizontal: AppSizes.padding / 2,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: AppSizes.padding / 2),
                    child: Text(
                      model.confirmationStatus.name,
                      style: AppTextStyle.semiBold(context),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const Icon(Icons.arrow_drop_down)
              ],
            ),
          ),
          items: [
            ...List.generate(
              confirmationStatusses.length - 1,
              (index) => DropdownMenuItem<Enum$ConfirmationStatus>(
                value: confirmationStatusses[index],
                child: Text(
                  confirmationStatusses[index].name,
                  style: AppTextStyle.semiBold(context),
                ),
              ),
            )
          ],
          onChanged: (value) {
            model.confirmationStatus = value as Enum$ConfirmationStatus;

            cl(model.confirmationStatus.name);
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget submitButton(GuestAddEditViewModel model) {
    return AppButton(
      text: widget.guest == null ? 'Tambah' : 'Perbarui',
      onTap: () {
        FocusScope.of(context).unfocus();
        final navigator = Navigator.of(context);
        model.addEditGuest(navigator);
      },
    );
  }
}
