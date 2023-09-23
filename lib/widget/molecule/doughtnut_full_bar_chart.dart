import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_style.dart';
import '../../model/chart_data.dart';

class AppFullDoughnutBarChart extends StatelessWidget {
  final List<ChartData> chartData;
  final bool isVisible;
  final String? centerTitle;
  final String? centersubtitle;
  final Color dataLabelColor;

  const AppFullDoughnutBarChart({
    super.key,
    this.isVisible = true,
    this.centerTitle,
    this.centersubtitle,
    this.dataLabelColor = AppColors.baseLv2,
    required this.chartData,
  });

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      annotations: <CircularChartAnnotation>[
        CircularChartAnnotation(
          verticalAlignment: ChartAlignment.far,
          widget: Text(
            centerTitle ?? '',
            style: AppTextStyle.bold(
              context,
              color: AppColors.baseLv5,
              fontSize: 11,
            ),
          ),
        ),
        CircularChartAnnotation(
          verticalAlignment: ChartAlignment.near,
          widget: Text(
            centersubtitle ?? '12.124',
            style: AppTextStyle.bold(
              context,
              color: AppColors.base,
              fontSize: 18,
            ),
          ),
        ),
      ],
      series: <CircularSeries>[
        DoughnutSeries<ChartData, String>(
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          pointColorMapper: (ChartData data, _) => data.color,
          startAngle: 0,
          endAngle: 360,
          dataLabelMapper: (ChartData data, _) => '${data.y}%',
          dataLabelSettings: DataLabelSettings(
            isVisible: isVisible,
            textStyle: AppTextStyle.bold(
              context,
              fontSize: 10,
              color: dataLabelColor,
            ),
          ),
        )
      ],
    );
  }
}
