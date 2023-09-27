import 'package:bangsatnyacintapertama/app/utility/date_formatter.dart';
import 'package:bangsatnyacintapertama_graphql_client/schema/generated/schema.graphql.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_toolkit/responsive_toolkit.dart';

import '../../app/const/app_const.dart';
import '../../app/service/locator/service_locator.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_sizes.dart';
import '../../app/theme/app_text_style.dart';
import '../../model/menu_item_model.dart';
import '../../model/table_model.dart';
import '../../view_model/check_in_view_model.dart';
import '../../widget/atom/app_card_container.dart';
import '../../widget/atom/app_checkbox.dart';
import '../../widget/atom/app_dialog.dart';
import '../../widget/atom/app_dropdown.dart';
import '../../widget/atom/app_icon_button.dart';
import '../../widget/atom/app_progress_indicator.dart';
import '../../widget/atom/app_snackbar.dart';
import '../../widget/atom/app_table.dart';
import '../../widget/atom/app_text_field.dart';
import '../../widget/molecule/card_program.dart';
import '../../widget/organism/app_bar_widget.dart';
import 'qr_code_scanner_view.dart';

class CheckInView extends StatefulWidget {
  const CheckInView({Key? key}) : super(key: key);

  static const String routeName = '/check-in';

  @override
  State<CheckInView> createState() => _CheckInViewState();
}

class _CheckInViewState extends State<CheckInView> {
  final checkInViewModel = locator<CheckInViewModel>();

  ScrollController scrollController = ScrollController();

  List<TableModel> headerData = [];

  @override
  void initState() {
    checkInViewModel.searchController = TextEditingController();

    scrollController.addListener(() {
      if (scrollController.offset == scrollController.position.maxScrollExtent) {
        checkInViewModel.getAllGuests(
          skip: checkInViewModel.guests!.length,
          contains: checkInViewModel.searchController.text,
        );
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      headerData = [
        TableModel(
          expanded: false,
          child: AppCheckbox(
            value: false,
            fillColor: AppColors.primary,
            padding: const EdgeInsets.only(left: AppSizes.padding / 2),
            onChanged: checkInViewModel.onSelectAll,
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
          data: 'Scanned At',
          textStyle: AppTextStyle.bold(context, color: AppColors.baseLv4),
        ),
        // TableModel(
        //   data: 'Scanned By',
        //   textStyle: AppTextStyle.bold(context, color: AppColors.baseLv4),
        // ),
      ];

      checkInViewModel.initCheckInView();
    });

    super.initState();
  }

  @override
  void dispose() {
    checkInViewModel.searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppSizes.screenSize = MediaQuery.of(context).size;
    final navigator = Navigator.of(context);

    return Scaffold(
      backgroundColor: AppColors.baseLv7,
      appBar: appBarWidget(navigator: navigator, title: "Check-In Tamu"),
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
    return Scrollbar(
      controller: scrollController,
      thickness: AppSizes.padding / 1.5,
      child: SingleChildScrollView(
        controller: scrollController,
        padding: const EdgeInsets.all(AppSizes.padding),
        child: Column(
          children: [
            checkInTotalCard(),
            const SizedBox(height: AppSizes.padding),
            unCheckInTotalCard(),
            const SizedBox(height: AppSizes.padding),
            emptySeatTotalCard(),
            const SizedBox(height: AppSizes.padding),
            invitedGuestList(),
          ],
        ),
      ),
    );
  }

  Widget wideBodyLayout() {
    return Scrollbar(
      controller: scrollController,
      thickness: AppSizes.padding / 1.5,
      child: SingleChildScrollView(
        controller: scrollController,
        padding: const EdgeInsets.all(AppSizes.padding),
        child: Column(
          children: [
            SizedBox(
              height: 300,
              child: Row(
                children: [
                  Expanded(child: checkInTotalCard()),
                  const SizedBox(width: AppSizes.padding),
                  Expanded(child: unCheckInTotalCard()),
                  const SizedBox(width: AppSizes.padding),
                  Expanded(child: emptySeatTotalCard()),
                ],
              ),
            ),
            const SizedBox(height: AppSizes.padding),
            invitedGuestList(),
          ],
        ),
      ),
    );
  }

  Widget checkInTotalCard() {
    return Consumer<CheckInViewModel>(builder: (context, model, _) {
      return CardProgram(
        iconProgram: Icons.person_outline,
        backgroundColorIcon: AppColors.white,
        backgroundColor: AppColors.primary,
        title: 'TOTAL CHECK-IN',
        contentText: '${model.totalCheckIn}',
        contentSubtext: 'ORANG',
        titleColor: AppColors.white.withOpacity(0.54),
        subtitleColor: AppColors.white,
        withButton: true,
        toolTipTitle: 'Lorem',
        toolTipsubtitle: 'Lorem ipsum dolor ',
        buttonText: "QR Scan",
        onTapButton: () async {
          await Navigator.pushNamed(context, QRCodeScannerView.routeName);
          model.refreshData();
        },
      );
    });
  }

  Widget unCheckInTotalCard() {
    return Consumer<CheckInViewModel>(builder: (context, model, _) {
      return CardProgram(
        iconProgram: Icons.person_outline,
        title: 'BELUM CHECK-IN',
        contentText: '${model.totalUncheckIn}',
        contentSubtext: 'ORANG',
        bottomTitleColor: AppColors.baseLv4,
        toolTipTitle: 'Lorem',
        toolTipsubtitle: 'Lorem ipsum dolor ',
      );
    });
  }

  Widget emptySeatTotalCard() {
    return Consumer<CheckInViewModel>(builder: (context, model, _) {
      return CardProgram(
        iconProgram: Icons.person_outline,
        title: 'KURSI KOSONG',
        contentText: '${model.totalEmptySeat}',
        contentSubtext: 'KURSI',
        bottomTitleColor: AppColors.baseLv4,
        toolTipTitle: 'Lorem',
        toolTipsubtitle: 'Lorem ipsum dolor ',
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
                      Expanded(child: sortDropDown()),
                      // const SizedBox(width: AppSizes.padding / 1.5),
                      // Expanded(child: actionDropDown()),
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
            deleteButton(),
            const SizedBox(width: AppSizes.padding / 1.5),
            refreshButton(),
          ],
        ),
        xl: Row(
          children: [
            Expanded(child: searchField()),
            const SizedBox(width: AppSizes.padding / 1.5),
            Expanded(child: sortDropDown()),
            // const SizedBox(width: AppSizes.padding / 1.5),
            // Expanded(child: actionDropDown()),
            const SizedBox(width: AppSizes.padding / 1.5),
            deleteButton(),
            const SizedBox(width: AppSizes.padding / 1.5),
            refreshButton(),
          ],
        ),
      ),
    );
  }

  Widget sortDropDown() {
    return Consumer<CheckInViewModel>(builder: (context, model, _) {
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
                    const Icon(
                      Icons.sort,
                      size: 14,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: AppSizes.padding / 2),
                        child: Text(
                          model.selectedSort?.text ?? '',
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
          ...guestScannedSortirDropdownItems.map(
            (item) => DropdownMenuItem<MenuItemModel>(
              value: item,
              child: Row(
                children: [
                  item.icon ?? const SizedBox.shrink(),
                  Padding(
                    padding: const EdgeInsets.only(left: AppSizes.padding / 2),
                    child: Text(
                      item.text ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: AppTextStyle.semiBold(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        onChanged: (value) {
          model.selectedSort = value as MenuItemModel;

          if (model.selectedSort!.text!.contains('Name')) {
            if (model.selectedSort!.text!.contains('Ascending')) {
              model.invitationNameSortOrder = Enum$SortOrder.asc;
            } else {
              model.invitationNameSortOrder = Enum$SortOrder.desc;
            }
          }

          if (model.selectedSort!.text!.contains('Seat')) {
            if (model.selectedSort!.text!.contains('Ascending')) {
              model.seatSortOrder = Enum$SortOrder.asc;
            } else {
              model.seatSortOrder = Enum$SortOrder.desc;
            }
          }

          if (model.selectedSort!.text!.contains('Scanned')) {
            if (model.selectedSort!.text!.contains('Ascending')) {
              model.scannedAtSortOrder = Enum$SortOrder.asc;
            } else {
              model.scannedAtSortOrder = Enum$SortOrder.desc;
            }
          }

          model.getAllGuests();

          setState(() {});
        },
      );
    });
  }

  // Widget actionDropDown() {
  //   return Consumer<CheckInViewModel>(builder: (context, model, _) {
  //     return AppDropDown(
  //       customButton: AppCardContainer(
  //         margin: EdgeInsets.zero,
  //         borderRadius: BorderRadius.circular(100),
  //         backgroundColor: AppColors.primary,
  //         padding: const EdgeInsets.symmetric(
  //           vertical: AppSizes.padding / 1.5,
  //           horizontal: AppSizes.padding,
  //         ),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Expanded(
  //               child: Text(
  //                 model.selectedAction?.text ?? '',
  //                 style: AppTextStyle.semiBold(context, color: AppColors.white),
  //                 overflow: TextOverflow.ellipsis,
  //               ),
  //             ),
  //             const Icon(Icons.arrow_drop_down, color: AppColors.white)
  //           ],
  //         ),
  //       ),
  //       items: [
  //         ...checkInActionDropdownItems.map(
  //           (item) => DropdownMenuItem<MenuItemModel>(
  //             value: item,
  //             child: Row(
  //               children: [
  //                 item.icon ?? const SizedBox.shrink(),
  //                 Padding(
  //                   padding: const EdgeInsets.only(left: AppSizes.padding / 2),
  //                   child: Text(
  //                     item.text ?? '',
  //                     style: AppTextStyle.semiBold(context),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //       onChanged: (value) {
  //         model.selectedAction = value as MenuItemModel;

  //         // TODO
  //         setState(() {});
  //       },
  //     );
  //   });
  // }

  Widget searchField() {
    return Consumer<CheckInViewModel>(builder: (context, model, _) {
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

  Widget refreshButton() {
    return Consumer<CheckInViewModel>(builder: (context, model, _) {
      return AppIconButton(
        icon: Icons.refresh_rounded,
        iconSize: 22,
        backgroundColor: AppColors.baseLv7,
        borderRadius: AppSizes.radius,
        onPressed: () {
          model.refreshData(reset: true);
        },
      );
    });
  }

  Widget deleteButton() {
    return Consumer<CheckInViewModel>(builder: (context, model, _) {
      return Opacity(
        opacity: model.selectedGuests.isEmpty ? 0.5 : 1.0,
        child: AppIconButton(
          icon: Icons.delete_forever_outlined,
          iconSize: 22,
          backgroundColor: AppColors.baseLv7,
          borderRadius: AppSizes.radius,
          onPressed: () {
            if (model.selectedGuests.isEmpty) {
              return;
            }

            final navigator = Navigator.of(context);
            if (model.selectedGuests.isEmpty) {
              AppSnackbar.show(navigator, title: "Pilih data terlebih dahulu");
              return;
            }

            AppDialog.show(
              navigator,
              title: "Hapus Data",
              text:
                  "Apa anda yakin ingin menghapus ${model.selectedGuests.length} data ini?\nAnda tidak dapat memulihkan data yang telah dihapus!",
              rightButtonText: "Hapus (${model.selectedGuests.length})",
              leftButtonText: "Batal",
              rightButtonTextColor: AppColors.red,
              onTapRightButton: () async {
                navigator.pop();
                await model.deleteGuestData(navigator);
                model.refreshData();
              },
            );
          },
        ),
      );
    });
  }

  Widget table() {
    return Consumer<CheckInViewModel>(builder: (context, model, _) {
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
            sm: AppSizes.screenSize.width * 2,
            xl: AppSizes.screenSize.width,
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
                value: model.selectedGuests.contains(model.guests![i]),
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
              data: model.guests![i].studio ?? '-',
              textStyle: AppTextStyle.bold(context),
            ),
            TableModel(
              data: model.guests![i].seat ?? '-',
            ),
            TableModel(
              data: model.guests![i].showTime ?? '-',
            ),
            TableModel(
              data: model.guests![i].qrcode?.scannedAt != null
                  ? DateFormatter.slashDateWithClock(model.guests![i].qrcode!.scannedAt!)
                  : '-',
            ),
            // TableModel(
            //   data: model.guests![i].qrcode?.scannedBy?.fullName ?? '-',
            // ),
            // TableModel(
            //   child: rsvpTableWidgetValue(
            //     confirmationStatusDropdownItems
            //         .where((e) => e.value == model.guests![i].confirmationStatus?.name)
            //         .firstOrNull,
            //   ),
            // ),
          ],
        ),
      );
    });
  }
}
