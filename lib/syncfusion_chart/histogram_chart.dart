import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HistogramChart extends StatefulWidget {
  const HistogramChart({Key? key}) : super(key: key);

  @override
  State<HistogramChart> createState() => _HistogramChartState();
}

class _HistogramChartState extends State<HistogramChart> {
  final List<DataList> histogramData = <DataList>[
    DataList(1),
    DataList(110),
    DataList(21),
    DataList(34),
    DataList(22),
    DataList(08),
    DataList(11.9),
    DataList(55.7),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Histogram Chart",
                style: TextStyle(fontWeight: FontWeight.w500))),
        body: Center(
            child: SfCartesianChart(
              legend: Legend(isVisible: true),
              series: <ChartSeries>[

          HistogramSeries<DataList, double>(
            name: "ABC",
              dataSource: histogramData,
              showNormalDistributionCurve: true,
              curveColor: const Color.fromRGBO(192, 108, 132, 1),
              binInterval: 40,
              yValueMapper: (DataList data, _) => data.y)
        ],
            primaryXAxis: CategoryAxis(
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              title: AxisTitle(text: "Histogram ")
            ),
            )));
  }
}

class DataList {
  DataList(this.y);

  final double y;
}
