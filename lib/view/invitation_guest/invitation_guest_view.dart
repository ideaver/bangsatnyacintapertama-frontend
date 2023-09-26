import 'package:bangsatnyacintapertama/widget/atom/app_progress_indicator.dart';
import 'package:bangsatnyacintapertama_graphql_client/schema/generated/schema.graphql.dart';
import 'package:flutter/material.dart';
import 'package:image_downloader_web/image_downloader_web.dart';
import 'package:provider/provider.dart';
import 'package:responsive_toolkit/responsive_toolkit.dart';

import '../../app/const/app_const.dart';
import '../../app/service/locator/service_locator.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_sizes.dart';
import '../../app/theme/app_text_style.dart';
import '../../model/menu_item_model.dart';
import '../../model/table_model.dart';
import '../../view_model/guest_invitation_view_model.dart';
import '../../widget/atom/app_card_container.dart';
import '../../widget/atom/app_checkbox.dart';
import '../../widget/atom/app_dropdown.dart';
import '../../widget/atom/app_icon_button.dart';
import '../../widget/atom/app_table.dart';
import '../../widget/atom/app_text_button.dart';
import '../../widget/atom/app_text_field.dart';
import '../../widget/molecule/card_program.dart';
import '../../widget/organism/app_bar_widget.dart';

class InvitationGuestView extends StatefulWidget {
  const InvitationGuestView({Key? key}) : super(key: key);

  static const String routeName = '/invitation-guest';

  @override
  State<InvitationGuestView> createState() => _InvitationGuestViewState();
}

class _InvitationGuestViewState extends State<InvitationGuestView> {
  List<TableModel> headerData = [];

  @override
  void initState() {
    final guestInvitationViewModel = locator<GuestInvitationViewModel>();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      headerData = [
        TableModel(
          expanded: false,
          child: AppCheckbox(
            value: false,
            fillColor: AppColors.primary,
            padding: const EdgeInsets.only(left: AppSizes.padding / 2),
            onChanged: guestInvitationViewModel.onSelectAll,
          ),
        ),
        TableModel(
          data: 'Nama',
          textStyle: AppTextStyle.bold(context, color: AppColors.baseLv4),
        ),
        TableModel(
          data: 'Kategori',
          textStyle: AppTextStyle.bold(context, color: AppColors.baseLv4),
        ),
        // TableModel(
        //   data: 'Email',
        //   textStyle: AppTextStyle.bold(context, color: AppColors.baseLv4),
        // ),
        TableModel(
          data: 'WhatsApp',
          textStyle: AppTextStyle.bold(context, color: AppColors.baseLv4),
        ),
        TableModel(
          data: 'Studio',
          textStyle: AppTextStyle.bold(context, color: AppColors.baseLv4),
        ),
        TableModel(
          data: 'Seat',
          textStyle: AppTextStyle.bold(context, color: AppColors.baseLv4),
        ),
        TableModel(
          data: 'Show Time',
          textStyle: AppTextStyle.bold(context, color: AppColors.baseLv4),
        ),
        TableModel(
          data: 'RSVP',
          textStyle: AppTextStyle.bold(context, color: AppColors.baseLv4),
        ),
        TableModel(
          data: 'Invitation Status',
          textStyle: AppTextStyle.bold(context, color: AppColors.baseLv4),
        ),
        TableModel(
          data: 'Invitation Image',
          textStyle: AppTextStyle.bold(context, color: AppColors.baseLv4),
        ),
      ];

      guestInvitationViewModel.initInvitationView();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppSizes.screenSize = MediaQuery.of(context).size;
    final navigator = Navigator.of(context);

    return Scaffold(
      backgroundColor: AppColors.baseLv7,
      appBar: appBarWidget(navigator: navigator, title: "Tamu Undangan"),
      body: body(),
    );
  }

  Widget body() {
    return ResponsiveLayout(
      Breakpoints(
        xs: compactBodyLayout(),
        lg: wideBodyLayout(),
      ),
    );
  }

  Widget compactBodyLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.padding),
      child: Column(
        children: [
          invitedGuestTotalCard(),
          const SizedBox(height: AppSizes.padding),
          sendedTotalCard(),
          const SizedBox(height: AppSizes.padding),
          failedSentTotalCard(),
          const SizedBox(height: AppSizes.padding),
          invitedGuestList(),
        ],
      ),
    );
  }

  Widget wideBodyLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.padding),
      child: Column(
        children: [
          SizedBox(
            height: 300,
            child: Row(
              children: [
                Expanded(child: invitedGuestTotalCard()),
                const SizedBox(width: AppSizes.padding),
                Expanded(child: sendedTotalCard()),
                const SizedBox(width: AppSizes.padding),
                Expanded(child: failedSentTotalCard()),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.padding),
          invitedGuestList(),
        ],
      ),
    );
  }

  Widget invitedGuestTotalCard() {
    return Consumer<GuestInvitationViewModel>(builder: (context, model, _) {
      return CardProgram(
        iconProgram: Icons.person_outline,
        backgroundColorIcon: AppColors.white,
        backgroundColor: AppColors.primary,
        title: 'TOTAL TAMU UNDANGAN',
        contentText: '${model.totalGuest}',
        contentSubtext: 'ORANG',
        titleColor: AppColors.white.withOpacity(0.54),
        subtitleColor: AppColors.white,
        withButton: true,
        toolTipTitle: 'Total tamu undangan',
        paddingToolTip: const EdgeInsets.only(right: AppSizes.padding * 12),
        tootipContentWidget: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Untuk upload data secara masssal. Gunakan template XLSx di bawah ini.',
              style: AppTextStyle.regular(
                context,
                fontSize: 14,
                color: AppColors.baseLv4,
              ),
            ),
            const SizedBox(height: AppSizes.padding / 4),
            AppTextButton(
              text: "Download Template",
              textStyle: AppTextStyle.semiBold(
                context,
                fontSize: 14,
                color: AppColors.primary,
              ),
              onTap: () {
                // TODO
              },
            ),
          ],
        ),
        buttonText: "Upload Tamu",
        onTapButton: () {
          // TODO
        },
      );
    });
  }

  Widget sendedTotalCard() {
    return Consumer<GuestInvitationViewModel>(builder: (context, model, _) {
      return CardProgram(
        iconProgram: Icons.person_outline,
        title: 'UNDANGAN TERKIRIM',
        contentText: '${model.totalGuestInvitationSent}',
        contentSubtext: 'UNDANGAN',
        bottomTitleColor: AppColors.baseLv4,
        toolTipTitle: 'Total undangan terkirim',
        toolTipsubtitle: 'Total undangan terkirim',
      );
    });
  }

  Widget failedSentTotalCard() {
    return Consumer<GuestInvitationViewModel>(builder: (context, model, _) {
      return CardProgram(
        iconProgram: Icons.person_outline,
        title: 'UNDANGAN GAGAL TERKIRIM',
        contentText: '${model.totalGuestInvitationFailedSent}',
        contentSubtext: 'UNDANGAN',
        bottomTitleColor: AppColors.baseLv4,
        toolTipTitle: 'Total undangan gagal dikirim',
        toolTipsubtitle: 'Total undangan gagal dikirim',
      );
    });
  }

  Widget invitedGuestList() {
    return AppCardContainer(
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          header(),
          const SizedBox(height: AppSizes.padding),
          table(),
        ],
      ),
    );
  }

  Widget invitedGuestListHeaderTitle() {
    return Text(
      'Daftar Tamu Undangan',
      style: AppTextStyle.bold(context, fontSize: 20),
    );
  }

  Widget header() {
    return Column(
      children: [
        ResponsiveLayout(
          Breakpoints(
            xs: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: invitedGuestListHeaderTitle()),
                listInvitedGuestHeaderMenu(),
              ],
            ),
            xl: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: invitedGuestListHeaderTitle()),
                Expanded(flex: 2, child: listInvitedGuestHeaderMenu()),
              ],
            ),
          ),
        ),
        ResponsiveLayout(
          Breakpoints(
            xs: Padding(
              padding: const EdgeInsets.only(top: AppSizes.padding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  searchField(),
                  const SizedBox(height: AppSizes.padding / 1.5),
                  Row(
                    children: [
                      Expanded(child: invitedGuestStatusDropDown()),
                      const SizedBox(width: AppSizes.padding / 1.5),
                      Expanded(child: actionDropDown()),
                    ],
                  ),
                ],
              ),
            ),
            xl: const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }

  Widget listInvitedGuestHeaderMenu() {
    return ResponsiveLayout(
      Breakpoints(
        xs: Row(
          children: [
            addButton(),
            const SizedBox(width: AppSizes.padding / 1.5),
            deleteButton(),
          ],
        ),
        xl: Row(
          children: [
            Expanded(child: searchField()),
            const SizedBox(width: AppSizes.padding / 1.5),
            Expanded(child: invitedGuestStatusDropDown()),
            const SizedBox(width: AppSizes.padding / 1.5),
            Expanded(child: actionDropDown()),
            const SizedBox(width: AppSizes.padding / 1.5),
            addButton(),
            const SizedBox(width: AppSizes.padding / 1.5),
            deleteButton(),
          ],
        ),
      ),
    );
  }

  Widget invitedGuestStatusDropDown() {
    return Consumer<GuestInvitationViewModel>(builder: (context, model, _) {
      return AppDropDown(
        customButton: AppCardContainer(
          margin: EdgeInsets.zero,
          borderRadius: BorderRadius.circular(100),
          backgroundColor: AppColors.baseLv7,
          padding: const EdgeInsets.symmetric(
            vertical: AppSizes.padding / 1.5,
            horizontal: AppSizes.padding,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    model.selectedStatus?.icon ?? const SizedBox.shrink(),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: AppSizes.padding / 2),
                        child: Text(
                          model.selectedStatus?.text ?? '',
                          style: AppTextStyle.semiBold(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_drop_down)
            ],
          ),
        ),
        items: [
          ...statusDropdownItems.map(
            (item) => DropdownMenuItem<MenuItemModel>(
              value: item,
              child: Row(
                children: [
                  item.icon ?? const SizedBox.shrink(),
                  Padding(
                    padding: const EdgeInsets.only(left: AppSizes.padding / 2),
                    child: Text(
                      item.text ?? '',
                      style: AppTextStyle.semiBold(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        onChanged: (value) {
          model.selectedStatus = value as MenuItemModel;

          if (Enum$ConfirmationStatus.values.where((e) => e.name == model.selectedAction?.value).isNotEmpty) {
            model.confirmationStatus =
                Enum$ConfirmationStatus.values.where((e) => e.name == model.selectedAction?.value).first;
          }

          setState(() {});
        },
      );
    });
  }

  Widget actionDropDown() {
    return Consumer<GuestInvitationViewModel>(builder: (context, model, _) {
      return AppDropDown(
        customButton: AppCardContainer(
          margin: EdgeInsets.zero,
          borderRadius: BorderRadius.circular(100),
          backgroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(
            vertical: AppSizes.padding / 1.5,
            horizontal: AppSizes.padding,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  model.selectedAction?.text ?? '',
                  style: AppTextStyle.semiBold(context, color: AppColors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(Icons.arrow_drop_down, color: AppColors.white)
            ],
          ),
        ),
        items: [
          ...actionDropdownItems.map(
            (item) => DropdownMenuItem<MenuItemModel>(
              value: item,
              child: Row(
                children: [
                  item.icon ?? const SizedBox.shrink(),
                  Padding(
                    padding: const EdgeInsets.only(left: AppSizes.padding / 2),
                    child: Text(
                      item.text ?? '',
                      style: AppTextStyle.semiBold(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        onChanged: (value) {
          model.selectedAction = value as MenuItemModel;
          setState(() {});
        },
      );
    });
  }

  Widget searchField() {
    return Consumer<GuestInvitationViewModel>(builder: (context, model, _) {
      return AppTextField(
        type: AppTextFieldType.search,
        showSuffixButton: false,
        prefixIcon: const Icon(Icons.search),
        fillColor: AppColors.baseLv7,
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.padding / 2),
        hintText: 'Cari...',
        onChanged: (value) {
          if (value.length % 3 == 0) {
            model.getAllGuests(contains: value);
          }
        },
      );
    });
  }

  Widget addButton() {
    return Consumer<GuestInvitationViewModel>(builder: (context, model, _) {
      return AppIconButton(
        icon: Icons.add_box_outlined,
        iconSize: 22,
        backgroundColor: AppColors.baseLv7,
        borderRadius: AppSizes.radius,
        onPressed: () {
          // TODO
        },
      );
    });
  }

  Widget deleteButton() {
    return Consumer<GuestInvitationViewModel>(builder: (context, model, _) {
      return AppIconButton(
        icon: Icons.delete_forever_outlined,
        iconSize: 22,
        backgroundColor: AppColors.baseLv7,
        borderRadius: AppSizes.radius,
        onPressed: () {
          // final navigator = Navigator.of(context);
          // if (model.selectedGuests.isEmpty) {
          //   AppSnackbar.show(navigator, title: "Pilih data terlebih dahulu");
          //   return;
          // }

          // AppDialog.show(
          //   navigator,
          //   title: "Hapus Data",
          //   text:
          //       "Apa anda yakin ingin menghapus ${model.selectedGuests.length} data ini?\nAnda tidak dapat memulihkan data yang telah dihapus!",
          //   rightButtonText: "Hapus (${model.selectedGuests.length})",
          //   leftButtonText: "Batal",
          //   rightButtonTextColor: AppColors.red,
          //   onTapRightButton: () {
          //     navigator.pop();
          //     model.deleteGuestData(navigator);
          //   },
          // );
        },
      );
    });
  }

  Widget table() {
    return Consumer<GuestInvitationViewModel>(builder: (context, model, _) {
      if (model.guests == null) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(AppSizes.padding),
            child: AppProgressIndicator(),
          ),
        );
      }

      return AppTable(
        borderRadius: AppSizes.radius,
        tableBorderColor: AppColors.baseLv6,
        tableBorderWidth: 1,
        headerBottomBorderWidth: 1,
        width: ResponsiveLayout.value(
          context,
          Breakpoints(
            xs: AppSizes.screenSize.width * 2,
            xl: AppSizes.screenSize.width,
          ),
        ),
        height: ResponsiveLayout.value(
          context,
          Breakpoints(
            xs: AppSizes.screenSize.height - 350,
            xl: AppSizes.screenSize.height - 280,
          ),
        ),
        padding: const EdgeInsets.all(AppSizes.padding),
        maxLines: 2,
        headerData: headerData,
        data: List.generate(
          model.guests!.length,
          (i) => [
            TableModel(
              expanded: false,
              child: AppCheckbox(
                value: false,
                fillColor: AppColors.primary,
                padding: const EdgeInsets.only(left: AppSizes.padding / 2),
                onChanged: (val) {
                  model.onSelect(val, i);
                },
              ),
            ),
            TableModel(
              data: model.guests![i].invitationName,
              textStyle: AppTextStyle.bold(context),
            ),
            TableModel(
              // data: '${model.guests![i].guestInfo?.category1 ?? ''}/${model.guests![i].guestInfo?.category2 ?? ''}',
              data: model.guests![i].category ?? '-',
            ),
            // TableModel(
            //   data: '${model.guests![i].email}',
            // ),
            TableModel(
              data: '${model.guests![i].whatsapp ?? '-'}',
            ),
            TableModel(
              data: model.guests![i].studio,
              textStyle: AppTextStyle.bold(context),
            ),
            TableModel(
              data: model.guests![i].seat ?? '-',
            ),
            TableModel(
              data: model.guests![i].showTime ?? '-',
            ),
            TableModel(
              child: rsvpTableWidgetValue(
                confirmationStatusDropdownItems
                    .where((e) => e.value == model.guests![i].confirmationStatus?.name)
                    .firstOrNull,
              ),
            ),
            TableModel(
              data: model.guests![i].whatsappStatuses?.firstOrNull?.status.name ?? '-',
            ),
            TableModel(
              child: model.guests![i].invitationImage == null || model.guests![i].invitationImage?.path == null
                  ? const SizedBox.shrink()
                  : InkWell(
                      onTap: () async {
                        // ImageDownloader.download(
                        //   context,
                        //   model.guests![i].invitationImage?.path,
                        //   model.guests![i].invitationName,
                        // );
                        await WebImageDownloader.downloadImageFromWeb(model.guests![i].invitationImage?.path ?? '');
                      },
                      child: Container(
                        color: AppColors.transparent,
                        padding: const EdgeInsets.all(AppSizes.padding / 2),
                        child: Text(
                          "Download Image",
                          style: AppTextStyle.medium(
                            context,
                            fontSize: 12,
                            color: AppColors.primary,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      );
    });
  }

  Widget rsvpTableWidgetValue(MenuItemModel? data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.padding / 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: data?.icon ?? const SizedBox.shrink(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: AppSizes.padding / 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data?.text ?? '-',
                  style: AppTextStyle.semiBold(context),
                  overflow: TextOverflow.ellipsis,
                ),
                // const SizedBox(height: AppSizes.padding / 4),
                // Text(
                //   DateFormatter.slashDate(DateTime.now().toIso8601String()),
                //   style: AppTextStyle.semiBold(context, fontSize: 12, color: AppColors.baseLv4),
                //   overflow: TextOverflow.ellipsis,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
