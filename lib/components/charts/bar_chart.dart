import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChartWidget extends StatelessWidget {
  BarChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return _lineChart(context);
  }

  ValueNotifier<int> selectedOption = ValueNotifier(1);

  _lineChart(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(12),child: Column(
      children: [
        const Row(
          children: [
            Text('Visualizing Perfect vs Imperfect Sprays',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)
          ],
        ),
        const SizedBox(height: 16,),
        Expanded(
            child: ChangeNotifierProvider(
              create: (context) => _BarChartProvider(),
              builder: (ctx, child) => _buildDefaultLineChart(ctx),
            ))
      ],
    ),);
  }

  Widget _buildDefaultLineChart(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      enableSideBySideSeriesPlacement: true,
      title: const ChartTitle(text: ''),
      legend: const Legend(
          isVisible: true, position: LegendPosition.top),
      primaryXAxis: const CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
      ),
      primaryYAxis: const NumericAxis(
          axisLine: AxisLine(width: 0),
          labelFormat: '{value}',
          majorTickLines: MajorTickLines(size: 0),
          majorGridLines: MajorGridLines(width: 1),
          rangePadding: ChartRangePadding.additional),
      series: _getDefaultColumnSeries(context),
      tooltipBehavior: context.read<_BarChartProvider>().tooltipBehavior,
    );
  }

  List<ColumnSeries<_ChartData, String>> _getDefaultColumnSeries(
      BuildContext context) {
    List<_ChartData> chartData =
        context.watch<_BarChartProvider>().chartData ?? [];

    return <ColumnSeries<_ChartData, String>>[
      ColumnSeries<_ChartData, String>(
        dataSource: chartData,
        xValueMapper: (_ChartData sales, _) => sales.x,
        yValueMapper: (_ChartData sales, _) => sales.y,
        dataLabelSettings: const DataLabelSettings(
            isVisible: true, textStyle: TextStyle(fontSize: 10)),
      ),
      ColumnSeries<_ChartData, String>(
        dataSource: chartData,
        xValueMapper: (_ChartData sales, _) => sales.x,
        yValueMapper: (_ChartData sales, _) => sales.y2,
        dataLabelSettings: const DataLabelSettings(
            isVisible: true, textStyle: TextStyle(fontSize: 10)),
      )
    ];
  }
}

class _ChartData {
  _ChartData(this.x, this.y, this.y2);
  final String x;
  final double y;
  final double y2;
}

class _BarChartProvider extends ChangeNotifier {
  List<_ChartData>? chartData = <_ChartData>[
    _ChartData('Mon', 50, 16),
    _ChartData('Tus', 34, 28),
    _ChartData('Wen', 44, 31),
    _ChartData('Thr', 38, 31),
    _ChartData('Fri', 60, 45),
    _ChartData('Sat', 57, 63),
    _ChartData('Sun', 45, 22)
  ];

  TooltipBehavior tooltipBehavior =
      TooltipBehavior(enable: true, header: '', canShowMarker: false);

  void init() {}

  @override
  void dispose() {
    chartData?.clear();
    super.dispose();
  }
}
