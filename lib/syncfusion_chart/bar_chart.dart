import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChart extends StatefulWidget {
  const BarChart({Key? key}) : super(key: key);

  @override
  State<BarChart> createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  List<String> data = <String>['Jan', 'Feb', 'March', 'APR', 'Mat'];
  List data2 = [200,10,151,858,1223];


  late List<GDPData> _chartData;
  late TooltipBehavior _tooltipBehavior;
  //List<GDPData> getChartData() {
    final List<GDPData> chartData = [
      GDPData('Oceania', 1600),
      GDPData('Africa', 2490),
      GDPData('S America', 29000),
      GDPData('Europe', 23050),
      GDPData('N America', 24880),
      GDPData('Asia', 34390),
    ];
    //return chartData;
 // }

  @override
  void initState() {
    _chartData = chartData;
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
              title: const Text(
                'Bar Chart',
                style: TextStyle(fontWeight: FontWeight.w500),
              )),
          body: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SfCartesianChart(
                  title: ChartTitle(text: 'Continent wise GDP - 2022',),
                  legend: Legend(isVisible: true),
                  tooltipBehavior: _tooltipBehavior,
                  series: <ChartSeries>[
                    BarSeries<GDPData, String>(
                        name: 'GDP',
                        dataSource: _chartData,
                        xValueMapper: (GDPData gdp, _) => gdp.continent,
                        yValueMapper: (GDPData gdp, _) => gdp.gdp,
                        color: Colors.deepPurpleAccent,
                        width: 0.8,
                        dataLabelSettings: const DataLabelSettings(isVisible: true),
                        enableTooltip: true)
                  ],
                  primaryXAxis: CategoryAxis(

                  ),
                  primaryYAxis: NumericAxis(
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                      title: AxisTitle(text: 'GDP in billions of U.S. Dollars')),
                ),
              ),
            ),
          ),
        ));

  }

}
class GDPData {
  GDPData(this.continent, this.gdp);
  final String continent;
  final double gdp;
}


