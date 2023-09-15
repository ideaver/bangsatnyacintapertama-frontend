import 'package:alvamind_library_two/app/theme/app_colors.dart';
import 'package:alvamind_library_two/app/theme/app_sizes.dart';
import 'package:alvamind_library_two/app/theme/app_text_style.dart';
import 'package:alvamind_library_two/widget/atom/app_card_container.dart';
import 'package:alvamind_library_two/widget/atom/app_text_field.dart';
import 'package:alvamind_library_two/widget/atom/my_icon_button.dart';
import 'package:alvamind_library_two/widget/molecule/custom_app_bar.dart';
import 'package:alvamind_library_two/widget/organism/card_program/card_program.dart';
import 'package:alvamind_library_two/widget/organism/table_content/table_content.dart';
import 'package:alvamind_library_two/widget/organism/table_wrapper/table_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:responsive_toolkit/responsive_toolkit.dart';

class InvitedGuestView extends StatefulWidget {
  const InvitedGuestView({Key? key}) : super(key: key);

  static const String routeName = '/invited-guest';

  @override
  State<InvitedGuestView> createState() => _InvitedGuestViewState();
}

class _InvitedGuestViewState extends State<InvitedGuestView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.baseLv7,
      appBar: const CustomAppBar(
        title: "Tamu Undangan",
      ),
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
        children: [],
      ),
    );
  }

  Widget wideBodyLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.padding),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: invitedGuestTotalCard()),
              const SizedBox(width: AppSizes.padding),
              Expanded(child: sendedTotalCard()),
              const SizedBox(width: AppSizes.padding),
              Expanded(child: failedSentTotalCard()),
            ],
          ),
          const SizedBox(height: AppSizes.padding),
          invitedGuestList(),
        ],
      ),
    );
  }

  Widget invitedGuestTotalCard() {
    return CardProgram(
      iconProgram: Icons.person_outline,
      backgroundColorIcon: AppColors.white,
      backgroundColor: AppColors.primary,
      title: 'TOTAL TAMU UNDANGAN',
      subtitle: '532',
      bottomTitle: 'ORANG',
      titleColor: AppColors.baseLv5,
      subtitleColor: AppColors.white,
      subtitleSize: 16,
      withButton: true,
      toolTipTitle: 'Lorem',
      toolTipsubtitle: 'Lorem ipsum dolor ',
      paddingToolTip: const EdgeInsets.only(right: AppSizes.padding * 12),
      onTapButton: () {
        // TODO
      },
    );
  }

  Widget sendedTotalCard() {
    return CardProgram(
      iconProgram: Icons.person_outline,
      title: 'UNDANGAN TERKIRIM',
      subtitle: '327',
      bottomTitle: 'UNDANGAN',
      bottomTitleColor: AppColors.baseLv4,
      customWidgetRightIcon: AppIconButton(
        icon: Icons.info_outline,
        iconColor: AppColors.baseLv4,
        onPressed: () {},
      ),
    );
  }

  Widget failedSentTotalCard() {
    return CardProgram(
      iconProgram: Icons.person_outline,
      title: 'UNDANGAN GAGAL TERKIRIM',
      subtitle: '27',
      bottomTitle: 'UNDANGAN',
      bottomTitleColor: AppColors.baseLv4,
      customWidgetRightIcon: AppIconButton(
        icon: Icons.info_outline,
        iconColor: AppColors.baseLv4,
        onPressed: () {},
      ),
    );
  }

  Widget invitedGuestList() {
    return AppCardContainer(
      child: Column(
        children: [
          header(),
          tableContent(),
        ],
      ),
    );
  }

  Widget header() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.padding,
        vertical: AppSizes.padding / 2,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'List Tamu Undangan',
                  style: AppTextStyle.medium(
                    context,
                    fontSize: 24,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: listInvitedGuestHeaderMenu(),
              ),
            ],
          ),
          ResponsiveLayout(
            Breakpoints(
              xs: Padding(
                padding: const EdgeInsets.only(top: AppSizes.padding),
                child: Row(
                  children: [
                    // invitedGuestStatusDropdwon(),
                    const SizedBox(width: AppSizes.padding / 1.5),
                    searchField(),
                  ],
                ),
              ),
              lg: const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }

  Widget listInvitedGuestHeaderMenu() {
    return ResponsiveLayout(
      Breakpoints(
        xs: Row(
          children: [
            // invitedGuestStatusDropdwon(),
            const SizedBox(width: AppSizes.padding / 1.5),
            searchField(),
            const SizedBox(width: AppSizes.padding / 1.5),
          ],
        ),
        lg: Row(
          children: [
            // invitedGuestStatusDropdwon(),
            const SizedBox(width: AppSizes.padding / 1.5),
            searchField(),
            const SizedBox(width: AppSizes.padding / 1.5),
          ],
        ),
      ),
    );
  }

  // Widget invitedGuestStatusDropdwon() {
  //   return AppDropDown(
  //     customButton: SizedBox(
  //       width: 120,
  //       child: AppCardContainer(
  //         margin: EdgeInsets.zero,
  //         borderRadius: BorderRadius.circular(100),
  //         backgroundColor: AppColors.baseLv7,
  //         padding: const EdgeInsets.all(AppSizes.padding / 1.1),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Row(
  //               children: [
  //                 Icon(
  //                   Icons.circle,
  //                   size: 12,
  //                   color: dropdownActivableColor,
  //                 ),
  //                 const SizedBox(width: AppSizes.padding / 2),
  //                 Text(
  //                   dropdownActivableText,
  //                   style: AppTextStyle.medium(
  //                     context,
  //                     fontSize: 12,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             const Icon(
  //               Icons.keyboard_arrow_down_sharp,
  //               size: 12,
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //     items: [
  //       ...MenuItems.activableDropdownItems.map(
  //         (item) => DropdownMenuItem<MenuItem>(
  //           value: item,
  //           child: MenuItems.buildItem(item),
  //         ),
  //       ),
  //     ],
  //     dropdownStyleData: DropdownStyleData(
  //       width: 200,
  //       padding: const EdgeInsets.symmetric(vertical: 6),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(AppSizes.radius * 2),
  //         color: Colors.white,
  //       ),
  //       offset: const Offset(-5, -10),
  //     ),
  //     menuItemStyleData: MenuItemStyleData(
  //       customHeights: [
  //         ...List<double>.filled(MenuItems.activableDropdownItems.length, 48),
  //       ],
  //       padding: const EdgeInsets.only(left: 16, right: 16),
  //     ),
  //     onChanged: (value) {
  //       // TODO
  //       // onChangedActivable(context, value as MenuItem);
  //     },
  //   );
  // }

  Widget searchField() {
    return Expanded(
      child: AppTextField(
        type: AppTextFieldType.search,
        showSuffixButton: false,
        prefixIcon: const Icon(Icons.search),
        fillColor: AppColors.baseLv7,
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.padding / 2),
        hintText: 'Cari Nama Program',
        onChanged: (value) {
          // TODO
        },
      ),
    );
  }

  Widget tableContent() {
    return TableWrapper(
      listTitle: const [
        'Invoice',
        'Transaksi',
        'Status',
        'Nominal',
        'Saldo',
      ],
      children: [
        Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            ...List.generate(15, (index) {
              return TableRow(
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(
                    color: AppColors.baseLv6,
                    width: index == 14 ? 0 : 1,
                  ),
                )),
                children: const [
                  TableContent(
                    title: 'TRX48239',
                    subtitle: 'Belum mendaftarkan member',
                  ),
                  TableContent(title: 'WithDraw'),
                  TableContent(
                    title: 'Gagal',
                    iconColor: AppColors.red,
                    subtitle: '20/05/2023',
                    withIcon: true,
                  ),
                  Center(
                    child: TableContent(title: 'Rp 21.442.321'),
                  ),
                  TableContent(title: 'Rp +2.000.456'),
                ],
              );
            })
          ],
        )
      ],
    );
  }
}
