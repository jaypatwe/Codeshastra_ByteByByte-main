import 'package:flareline/themes/global_colors.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChartWidget extends StatelessWidget {
  LineChartWidget({super.key});

  ValueNotifier<int> selectedOption = ValueNotifier(1);

  @override
  Widget build(BuildContext context) {
    return _lineChart(context);
  }

  _lineChart(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12),
        child: Column(

          children: [
            const Row(
              children: [
                Text('Correct and Incorrect Spray trend over a year',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)
              ],
            ),
            // SizedBox(
            //   width: double.maxFinite,
            //   height: 60,
            //   child: Row(children: [
            //     const Spacer(),
            //     Container(
            //       padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 8),
            //       color: gray,
            //       child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            //       MaterialButton(
            //         color:Colors.white,
            //         onPressed: () {},
            //         child: const Text('Day'),
            //       ),
            //       MaterialButton(
            //         onPressed: () {},
            //         child: const Text('Week'),
            //       ),
            //       MaterialButton(
            //         onPressed: () {},
            //         child: const Text('Month'),
            //       )
            //     ]),)
            //   ]),
            // ),
            Expanded(
                child: ChangeNotifierProvider(
              create: (context) => _LineChartProvider(),
              builder: (ctx, child) => _buildDefaultLineChart(ctx),
            ))
          ],
        ));
  }

  SfCartesianChart _buildDefaultLineChart(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: const ChartTitle(text: ''),
      legend: const Legend(
          isVisible: true, position: LegendPosition.top),
      primaryXAxis: const NumericAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          interval: 1,
          majorGridLines: MajorGridLines(width: 1)),
      primaryYAxis: const NumericAxis(
          labelFormat: '{value}',
          axisLine: AxisLine(width: 0),
          majorTickLines: MajorTickLines(color: Colors.transparent)),
      series: _getDefaultLineSeries(context),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  /// The method returns line series to chart.
  List<LineSeries<_ChartData, num>> _getDefaultLineSeries(
      BuildContext context) {
    List<_ChartData> chartData =
        context.watch<_LineChartProvider>().chartData ?? [];
    return <LineSeries<_ChartData, num>>[
      LineSeries<_ChartData, num>(
          dataSource: chartData,
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y,
          name: 'Correct Pumps',
          // isVisibleInLegend: false,
          markerSettings: const MarkerSettings(isVisible: true)),
      LineSeries<_ChartData, num>(
          dataSource: chartData,
          name: 'Incorrect Pumps',
          // isVisibleInLegend: false,
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y2,
          markerSettings: const MarkerSettings(isVisible: true))
    ];
  }
}

class _ChartData {
  _ChartData(this.x, this.y, this.y2);

  final double x;
  final double y;
  final double y2;
}

class _LineChartProvider extends ChangeNotifier {
  List<_ChartData>? chartData = <_ChartData>[
    _ChartData(01, 21, 35),
    _ChartData(02, 24, 20),
    _ChartData(03, 36, 18),
    _ChartData(04, 38, 15),
    _ChartData(05, 54, 16),
    _ChartData(06, 57, 13),
    _ChartData(07, 70, 13),
    _ChartData(08, 70, 12),
    _ChartData(09, 70, 14),
    _ChartData(10, 70, 10),
    _ChartData(11, 70, 6),
    _ChartData(12, 70, 4),
  ];

  void init() {}

  @override
  void dispose() {
    chartData?.clear();
    super.dispose();
  }
}
