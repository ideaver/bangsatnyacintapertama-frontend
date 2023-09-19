import 'package:alvamind_library_two/app/theme/app_colors.dart';
import 'package:alvamind_library_two/app/theme/app_sizes.dart';
import 'package:alvamind_library_two/app/theme/app_text_style.dart';
import 'package:alvamind_library_two/app/utility/date_formatter.dart';
import 'package:alvamind_library_two/model/menu_item_model.dart';
import 'package:alvamind_library_two/model/table_model.dart';
import 'package:alvamind_library_two/widget/atom/app_card_container.dart';
import 'package:alvamind_library_two/widget/atom/app_dialog.dart';
import 'package:alvamind_library_two/widget/atom/app_icon_button.dart';
import 'package:alvamind_library_two/widget/atom/app_table.dart';
import 'package:alvamind_library_two/widget/atom/app_text_field.dart';
import 'package:alvamind_library_two/widget/molecule/app_checkbox.dart';
import 'package:alvamind_library_two/widget/molecule/app_dropdown.dart';
import 'package:alvamind_library_two/widget/organism/card_program/card_program.dart';
import 'package:flutter/material.dart';
import 'package:responsive_toolkit/responsive_toolkit.dart';

import '../../widget/app_bar_widget.dart';
import 'qr_code_scanner_view.dart';

class CheckInView extends StatefulWidget {
  const CheckInView({Key? key}) : super(key: key);

  static const String routeName = '/check-in';

  @override
  State<CheckInView> createState() => _CheckInViewState();
}

class _CheckInViewState extends State<CheckInView> {
  String? code;

  MenuItemModel? selectedAction;
  MenuItemModel? selectedCategory;

  List<MenuItemModel> actionDropdownItems = [
    MenuItemModel(
      text: 'Check-In',
      icon: const Icon(
        Icons.exit_to_app_rounded,
        size: 14,
      ),
    ),
    MenuItemModel(
      text: 'Batalkan Check-In',
      icon: const Icon(
        Icons.cancel_outlined,
        size: 14,
      ),
    ),
  ];

  List<MenuItemModel> statusDropdownItems = [
    MenuItemModel(
      text: 'Urutkan Kategori',
      icon: const Icon(
        Icons.person_outline,
        size: 14,
      ),
    ),
    MenuItemModel(
      text: 'Urutkan Sub Kategori',
      icon: const Icon(
        Icons.person_outline,
        size: 14,
      ),
    ),
    MenuItemModel(
      text: 'Urutkan Nama',
      icon: const Icon(
        Icons.card_membership_rounded,
        size: 14,
      ),
    ),
    MenuItemModel(
      text: 'Terbaru',
      icon: const Icon(
        Icons.fullscreen_exit_rounded,
        size: 14,
      ),
    ),
  ];

  List<TableModel> headerData = [];

  List<List<TableModel>> data = [];

  @override
  void initState() {
    selectedCategory = statusDropdownItems.first;
    selectedAction = actionDropdownItems.first;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      headerData = [
        TableModel(
          expanded: false,
          child: AppCheckbox(
            value: false,
            fillColor: AppColors.primary,
            padding: const EdgeInsets.only(left: AppSizes.padding / 2),
            onChanged: onSelectAll,
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
        TableModel(
          data: 'Email',
          textStyle: AppTextStyle.bold(context, color: AppColors.baseLv4),
        ),
        TableModel(
          data: 'No. HP',
          textStyle: AppTextStyle.bold(context, color: AppColors.baseLv4),
        ),
        TableModel(
          data: 'PIC',
          textStyle: AppTextStyle.bold(context, color: AppColors.baseLv4),
        ),
        TableModel(
          data: 'Seat',
          textStyle: AppTextStyle.bold(context, color: AppColors.baseLv4),
        ),
        TableModel(
          data: 'Check-In',
          textStyle: AppTextStyle.bold(context, color: AppColors.baseLv4),
        ),
      ];

      data = [
        ...List.generate(
          18,
          (index) => [
            TableModel(
              expanded: false,
              child: AppCheckbox(
                value: false,
                fillColor: AppColors.primary,
                padding: const EdgeInsets.only(left: AppSizes.padding / 2),
                onChanged: onSelect,
              ),
            ),
            TableModel(data: 'Data $index', textStyle: AppTextStyle.bold(context)),
            TableModel(data: 'Data $index'),
            TableModel(data: 'Data $index'),
            TableModel(data: 'Data $index'),
            TableModel(data: 'Data $index'),
            TableModel(data: 'Data $index', textStyle: AppTextStyle.bold(context)),
            TableModel(data: DateFormatter.slashDateShortedYearWithClock(DateTime.now().toIso8601String())),
          ],
        )
      ];

      setState(() {});
    });

    super.initState();
  }

  // TODO ADD RAW DATA
  void onSelectAll(bool? val) {
    if (val == null) {
      return;
    }

    if (val) {
    } else {}
  }

  void onSelect(bool? val) {
    if (val == null) {
      return;
    }

    if (val) {
    } else {}
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
    return SingleChildScrollView(
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
    );
  }

  Widget checkInTotalCard() {
    return CardProgram(
      iconProgram: Icons.person_outline,
      backgroundColorIcon: AppColors.white,
      backgroundColor: AppColors.primary,
      title: 'TOTAL CHECK-IN',
      contentText: '532',
      contentSubtext: 'ORANG',
      titleColor: AppColors.white.withOpacity(0.54),
      subtitleColor: AppColors.white,
      withButton: true,
      toolTipTitle: 'Lorem',
      toolTipsubtitle: 'Lorem ipsum dolor ',
      buttonText: "QR Scan",
      onTapButton: () {
        Navigator.pushNamed(context, QRCodeScannerView.routeName);
      },
    );
  }

  Widget unCheckInTotalCard() {
    return const CardProgram(
      iconProgram: Icons.person_outline,
      title: 'BELUM CHECK-IN',
      contentText: '37',
      contentSubtext: 'ORANG',
      bottomTitleColor: AppColors.baseLv4,
      toolTipTitle: 'Lorem',
      toolTipsubtitle: 'Lorem ipsum dolor ',
    );
  }

  Widget emptySeatTotalCard() {
    return const CardProgram(
      iconProgram: Icons.person_outline,
      title: 'KURSI KOSONG',
      contentText: '257',
      contentSubtext: 'KURSI',
      bottomTitleColor: AppColors.baseLv4,
      toolTipTitle: 'Lorem',
      toolTipsubtitle: 'Lorem ipsum dolor ',
    );
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
            refreshButton(),
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
            refreshButton(),
            const SizedBox(width: AppSizes.padding / 1.5),
            deleteButton(),
          ],
        ),
      ),
    );
  }

  Widget invitedGuestStatusDropDown() {
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
                  selectedCategory?.icon ?? const SizedBox.shrink(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: AppSizes.padding / 2),
                      child: Text(
                        selectedCategory?.text ?? '',
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
        selectedCategory = value as MenuItemModel;
        setState(() {});
      },
    );
  }

  Widget actionDropDown() {
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
                selectedAction?.text ?? '',
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
        selectedAction = value as MenuItemModel;
        setState(() {});
      },
    );
  }

  Widget searchField() {
    return AppTextField(
      type: AppTextFieldType.search,
      showSuffixButton: false,
      prefixIcon: const Icon(Icons.search),
      fillColor: AppColors.baseLv7,
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.padding / 2),
      hintText: 'Cari...',
      onChanged: (value) {
        // TODO
      },
    );
  }

  Widget refreshButton() {
    return AppIconButton(
      icon: Icons.refresh_rounded,
      iconSize: 22,
      backgroundColor: AppColors.baseLv7,
      borderRadius: AppSizes.radius,
      onPressed: () {},
    );
  }

  Widget deleteButton() {
    return AppIconButton(
      icon: Icons.delete_forever_outlined,
      iconSize: 22,
      backgroundColor: AppColors.baseLv7,
      borderRadius: AppSizes.radius,
      onPressed: () {
        final navigator = Navigator.of(context);
        AppDialog.show(
          navigator,
          title: "Hapus Data",
          text: "Apa anda yakin ingin menghapus 12 data ini?\nAnda tidak dapat memulihkan data yang telah dihapus!",
          rightButtonText: "Hapus (12)",
          leftButtonText: "Batal",
          rightButtonTextColor: AppColors.red,
        );
      },
    );
  }

  Widget table() {
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
      data: data,
    );
  }
}
