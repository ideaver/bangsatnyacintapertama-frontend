import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_toolkit/responsive_toolkit.dart';

import '../../app/service/locator/service_locator.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_sizes.dart';
import '../../app/theme/app_text_style.dart';
import '../../model/chart_data.dart';
import '../../model/chart_legend_model.dart';
import '../../view_model/dashboard_view_model.dart';
import '../../widget/atom/app_card_container.dart';
import '../../widget/molecule/card_program.dart';
import '../../widget/molecule/doughtnut_full_bar_chart.dart';
import '../../widget/organism/app_bar_widget.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  static const String routeName = '/dashboard';

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  void initState() {
    final dashboardViewModel = locator<DashboardViewModel>();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      dashboardViewModel.initDashboardView();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    return Scaffold(
      backgroundColor: AppColors.baseLv7,
      appBar: appBarWidget(navigator: navigator, title: "Dashboard"),
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
          sendedTotalCard(),
          const SizedBox(height: AppSizes.padding),
          failedSentTotalCard(),
          const SizedBox(height: AppSizes.padding),
          unRSVPTotalCard(),
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
              Expanded(child: sendedTotalCard()),
              const SizedBox(width: AppSizes.padding),
              Expanded(child: failedSentTotalCard()),
              const SizedBox(width: AppSizes.padding),
              Expanded(child: unRSVPTotalCard()),
            ],
          )
        ],
      ),
    );
  }

  Widget guestTotalCard() {
    return Consumer<DashboardViewModel>(builder: (context, model, _) {
      return CardProgram(
        iconProgram: Icons.person_outline,
        title: 'TOTAL TAMU',
        contentText: '${model.totalGuest}',
        contentSubtext: 'ORANG',
        bottomTitleColor: AppColors.baseLv4,
        toolTipTitle: 'Total Tamu',
        toolTipsubtitle: 'Total semua tamu yang diundang',
      );
    });
  }

  Widget presentTotalCard() {
    return Consumer<DashboardViewModel>(builder: (context, model, _) {
      return CardProgram(
        iconProgram: Icons.person_outline,
        title: 'HADIR',
        contentText: '${model.totalGuestConfirmed}',
        contentSubtext: 'ORANG',
        bottomTitleColor: AppColors.baseLv4,
        toolTipTitle: 'Lorem',
        toolTipsubtitle: 'Lorem ipsum dolor ',
      );
    });
  }

  Widget absentTotalCard() {
    return Consumer<DashboardViewModel>(builder: (context, model, _) {
      return CardProgram(
        iconProgram: Icons.person_outline,
        title: 'TIDAK HADIR',
        contentText: '${model.totalGuestRejected}',
        contentSubtext: 'ORANG',
        bottomTitleColor: AppColors.baseLv4,
        toolTipTitle: 'Lorem',
        toolTipsubtitle: 'Lorem ipsum dolor ',
      );
    });
  }

  Widget sendedTotalCard() {
    return Consumer<DashboardViewModel>(builder: (context, model, _) {
      return CardProgram(
        iconProgram: Icons.person_outline,
        title: 'TERKIRIM',
        contentText: '${model.totalGuestInvitationSent}',
        contentSubtext: 'UNDANGAN',
        bottomTitleColor: AppColors.baseLv4,
      );
    });
  }

  Widget failedSentTotalCard() {
    return Consumer<DashboardViewModel>(builder: (context, model, _) {
      return CardProgram(
        iconProgram: Icons.person_outline,
        title: 'GAGAL TERKIRIM',
        contentText: '${model.totalGuestInvitationFailedSent}',
        contentSubtext: 'UNDANGAN',
        bottomTitleColor: AppColors.baseLv4,
      );
    });
  }

  Widget unRSVPTotalCard() {
    return Consumer<DashboardViewModel>(builder: (context, model, _) {
      return CardProgram(
        iconProgram: Icons.person_outline,
        title: 'BELUM RSVP',
        contentText: '${model.totalGuestInvitationUnconfirmed}',
        contentSubtext: 'UNDANGAN',
        bottomTitleColor: AppColors.baseLv4,
      );
    });
  }

  Widget chart1() {
    return Consumer<DashboardViewModel>(builder: (context, model, _) {
      return chartWidget(
        title: "KEHADIRAN",
        centerTitle: 'TOTAL',
        centersubtitle: '${model.totalGuestConfirmed + model.totalGuestInvitationUnconfirmed}',
        subtitle: "Persentase undangan yang telah konfirmasi dengan yang belum",
        chartData: [
          ChartData('Telah Konfirmasi', model.totalGuestConfirmed.toDouble(), AppColors.primary),
          ChartData('Belum RSVP', model.totalGuestInvitationUnconfirmed.toDouble(), AppColors.primaryLv7),
        ],
        legends: [
          ChartLegendModel(
            title: "Telah Konfirmasi",
            color: AppColors.primary,
            value:
                '${(model.totalGuestConfirmed / (model.totalGuestConfirmed + model.totalGuestInvitationUnconfirmed) * 100).toStringAsFixed(0)}%',
          ),
          ChartLegendModel(
            title: "Belum RSVP",
            color: AppColors.primaryLv7,
            value:
                '${(model.totalGuestInvitationUnconfirmed / (model.totalGuestConfirmed + model.totalGuestInvitationUnconfirmed) * 100).toStringAsFixed(0)}%',
          ),
        ],
      );
    });
  }

  Widget chart2() {
    return Consumer<DashboardViewModel>(builder: (context, model, _) {
      return chartWidget(
        title: "PENGIRIMAN",
        centerTitle: 'TOTAL',
        centersubtitle: '${model.totalGuestInvitationSent + model.totalGuestInvitationFailedSent}',
        subtitle: "Persentase undangan yang telah terkirim dengan yang gagal",
        chartData: [
          ChartData('Terkirim', model.totalGuestInvitationSent.toDouble(), AppColors.greenLv1),
          ChartData('Gagal Terkirim', model.totalGuestInvitationFailedSent.toDouble(), AppColors.greenLv7),
        ],
        legends: [
          ChartLegendModel(
            title: "Terkirim",
            color: AppColors.greenLv1,
            value:
                '${(model.totalGuestInvitationSent / (model.totalGuestInvitationSent + model.totalGuestInvitationFailedSent) * 100).toStringAsFixed(0)}%',
          ),
          ChartLegendModel(
            title: "Gagal Terkirim",
            color: AppColors.greenLv7,
            value:
                '${(model.totalGuestInvitationFailedSent / (model.totalGuestInvitationSent + model.totalGuestInvitationFailedSent) * 100).toStringAsFixed(0)}%',
          ),
        ],
      );
    });
  }

  Widget chart3() {
    return Consumer<DashboardViewModel>(builder: (context, model, _) {
      return chartWidget(
        title: "PENOLAKAN",
        centerTitle: 'TOTAL',
        centersubtitle: '${model.totalGuestRejected + model.totalGuestConfirmed}',
        subtitle: "Persentase undangan yang ditolak dengan yang diterima (dikonfirmasi)",
        chartData: [
          ChartData('Ditolak', model.totalGuestRejected.toDouble(), AppColors.red),
          ChartData('Diterima', model.totalGuestConfirmed.toDouble(), AppColors.redLv7),
        ],
        legends: [
          ChartLegendModel(
            title: "Telah Ditolak",
            color: AppColors.red,
            value:
                '${(model.totalGuestRejected / (model.totalGuestRejected + model.totalGuestConfirmed) * 100).toStringAsFixed(0)}%',
          ),
          ChartLegendModel(
            title: "Telah Dikonfirmasi",
            color: AppColors.redLv7,
            value:
                '${(model.totalGuestConfirmed / (model.totalGuestRejected + model.totalGuestConfirmed) * 100).toStringAsFixed(0)}%',
          ),
        ],
      );
    });
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
