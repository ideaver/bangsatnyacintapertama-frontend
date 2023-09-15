import 'package:alvamind_library_two/app/theme/app_colors.dart';
import 'package:alvamind_library_two/app/theme/app_sizes.dart';
import 'package:alvamind_library_two/app/theme/app_text_style.dart';
import 'package:alvamind_library_two/model/chart_data.dart';
import 'package:alvamind_library_two/model/chart_legend_model.dart';
import 'package:alvamind_library_two/widget/atom/app_card_container.dart';
import 'package:alvamind_library_two/widget/atom/my_icon_button.dart';
import 'package:alvamind_library_two/widget/molecule/custom_app_bar.dart';
import 'package:alvamind_library_two/widget/organism/bar_chart/doughnut_bar_chart.dart/doughtnut_full_bar_chart.dart';
import 'package:alvamind_library_two/widget/organism/card_program/card_program.dart';
import 'package:flutter/material.dart';
import 'package:responsive_toolkit/responsive_toolkit.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  static const String routeName = '/dashboard';

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.baseLv7,
      appBar: const CustomAppBar(
        title: "Dashboard",
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
        children: [
          guestTotalCard(),
          const SizedBox(height: AppSizes.padding),
          presentTotalCard(),
          const SizedBox(height: AppSizes.padding),
          absentTotalCard(),
          const SizedBox(height: AppSizes.padding),
          chart1(),
          const SizedBox(height: AppSizes.padding),
          chart2(),
          const SizedBox(height: AppSizes.padding),
          chart3(),
          const SizedBox(height: AppSizes.padding),
          guestTotalCard(),
          const SizedBox(height: AppSizes.padding),
          presentTotalCard(),
          const SizedBox(height: AppSizes.padding),
          absentTotalCard(),
        ],
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
              Expanded(child: guestTotalCard()),
              const SizedBox(width: AppSizes.padding),
              Expanded(child: presentTotalCard()),
              const SizedBox(width: AppSizes.padding),
              Expanded(child: absentTotalCard()),
            ],
          ),
          const SizedBox(height: AppSizes.padding),
          Row(
            children: [
              Expanded(child: chart1()),
              const SizedBox(width: AppSizes.padding),
              Expanded(child: chart2()),
              const SizedBox(width: AppSizes.padding),
              Expanded(child: chart3()),
            ],
          ),
          const SizedBox(height: AppSizes.padding),
          Row(
            children: [
              Expanded(child: guestTotalCard()),
              const SizedBox(width: AppSizes.padding),
              Expanded(child: presentTotalCard()),
              const SizedBox(width: AppSizes.padding),
              Expanded(child: absentTotalCard()),
            ],
          )
        ],
      ),
    );
  }

  Widget guestTotalCard() {
    return CardProgram(
      iconProgram: Icons.person_outline,
      title: 'TOTAL TAMU',
      subtitle: '830',
      bottomTitle: 'ORANG',
      bottomTitleColor: AppColors.baseLv4,
      customWidgetRightIcon: AppIconButton(
        icon: Icons.info_outline,
        iconColor: AppColors.baseLv4,
        onPressed: () {},
      ),
    );
  }

  Widget presentTotalCard() {
    return CardProgram(
      iconProgram: Icons.person_outline,
      title: 'HADIR',
      subtitle: '23',
      bottomTitle: 'ORANG',
      bottomTitleColor: AppColors.baseLv4,
      customWidgetRightIcon: AppIconButton(
        icon: Icons.info_outline,
        iconColor: AppColors.baseLv4,
        onPressed: () {},
      ),
    );
  }

  Widget absentTotalCard() {
    return CardProgram(
      iconProgram: Icons.person_outline,
      title: 'TIDAK HADIR',
      subtitle: '23',
      bottomTitle: 'ORANG',
      bottomTitleColor: AppColors.baseLv4,
      customWidgetRightIcon: AppIconButton(
        icon: Icons.info_outline,
        iconColor: AppColors.baseLv4,
        onPressed: () {},
      ),
    );
  }

  Widget sendedTotalCard() {
    return const CardProgram(
      iconProgram: Icons.person_outline,
      title: 'TERKIRIM',
      subtitle: '327',
      bottomTitle: 'UNDANGAN',
      bottomTitleColor: AppColors.baseLv4,
    );
  }

  Widget failedSentTotalCard() {
    return const CardProgram(
      iconProgram: Icons.person_outline,
      title: 'GAGAL TERKIRIM',
      subtitle: '27',
      bottomTitle: 'UNDANGAN',
      bottomTitleColor: AppColors.baseLv4,
    );
  }

  Widget unRSVPTotalCard() {
    return const CardProgram(
      iconProgram: Icons.person_outline,
      title: 'BELUM RSVP',
      subtitle: '346',
      bottomTitle: 'UNDANGAN',
      bottomTitleColor: AppColors.baseLv4,
    );
  }

  Widget chart1() {
    return chartWidget(
      title: "UNDANGAN",
      centerTitle: 'TOTAL MEMBER',
      centersubtitle: '123.22',
      subtitle: "Persentase undangan yang telah konfirmasi dengan yang belum",
      chartData: [
        ChartData('Aktif', 75, AppColors.primary),
        ChartData('Tidak Aktif', 25, AppColors.primaryLv7),
      ],
      legends: [
        ChartLegendModel(
          title: "Telah Konfirmasi",
          color: AppColors.primary,
          value: '75%',
        ),
        ChartLegendModel(
          title: "Belum RSVP",
          color: AppColors.primaryLv7,
          value: '25%',
        ),
      ],
    );
  }

  Widget chart2() {
    return chartWidget(
      title: "UNDANGAN",
      centerTitle: 'TOTAL MEMBER',
      centersubtitle: '123.22',
      subtitle: "Persentase undangan yang telah konfirmasi dengan yang belum",
      chartData: [
        ChartData('Aktif', 75, AppColors.greenLv1),
        ChartData('Tidak Aktif', 25, AppColors.greenLv7),
      ],
      legends: [
        ChartLegendModel(
          title: "Telah Konfirmasi",
          color: AppColors.greenLv1,
          value: '75%',
        ),
        ChartLegendModel(
          title: "Belum RSVP",
          color: AppColors.greenLv7,
          value: '25%',
        ),
      ],
    );
  }

  Widget chart3() {
    return chartWidget(
      title: "UNDANGAN",
      centerTitle: 'TOTAL MEMBER',
      centersubtitle: '123.22',
      subtitle: "Persentase undangan yang telah konfirmasi dengan yang belum",
      chartData: [
        ChartData('Aktif', 75, AppColors.primary),
        ChartData('Tidak Aktif', 25, AppColors.primaryLv7),
      ],
      legends: [
        ChartLegendModel(
          title: "Telah Konfirmasi",
          color: AppColors.primary,
          value: '75%',
        ),
        ChartLegendModel(
          title: "Belum RSVP",
          color: AppColors.primaryLv7,
          value: '25%',
        ),
      ],
    );
  }

  Widget chartWidget({
    required String title,
    required String centerTitle,
    required String centersubtitle,
    required String subtitle,
    required List<ChartData> chartData,
    List<ChartLegendModel> legends = const [],
  }) {
    return AppCardContainer(
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          Text(
            title,
            style: AppTextStyle.bold(
              context,
              fontSize: 18,
            ),
          ),
          AppFullDoughnutBarChart(
            centerTitle: centerTitle,
            centersubtitle: centersubtitle,
            chartData: chartData,
          ),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: AppTextStyle.medium(
              context,
              fontSize: 14,
              color: AppColors.baseLv4,
            ),
          ),
          const SizedBox(height: AppSizes.padding * 2),
          ...List.generate(legends.length, (i) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSizes.padding / 1.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: legends[i].color,
                        size: 12,
                      ),
                      const SizedBox(width: AppSizes.padding / 2),
                      Text(
                        legends[i].title,
                        style: AppTextStyle.semiBold(
                          context,
                          fontSize: 12,
                          color: AppColors.baseLv4,
                        ),
                      )
                    ],
                  ),
                  Text(
                    legends[i].value,
                    style: AppTextStyle.bold(
                      context,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}
