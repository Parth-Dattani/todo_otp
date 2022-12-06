import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChart extends StatefulWidget {
  const LineChart({Key? key}) : super(key: key);

  @override
  State<LineChart> createState() => _LineChartState();
}

class _LineChartState extends State<LineChart> {
  late List<SaleData> sale;
  late TooltipBehavior tooltipBehavior;

  List<SaleData> getData() {
    List<SaleData> saleData = [
      SaleData('Samsung M32', 100),
      SaleData('Redmi 10', 25),
      SaleData('Vivo Y21', 75),
      SaleData('Oppo A53', 10),
      SaleData('Nokia 153', 05),
    ];
    return saleData;
  }

  @override
  void initState() {
    sale = getData();
    tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Line Chart",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SfCartesianChart(
              enableAxisAnimation: true,
              title: ChartTitle(text: ' ABC Shop Sales - 2022'),
              legend: Legend(
                  isVisible: true,
                  backgroundColor: Colors.cyanAccent,
                  iconBorderColor: Colors.deepOrange),
              tooltipBehavior: tooltipBehavior,
              series: <ChartSeries>[
                LineSeries<SaleData, String>(
                  name: "ABC",
                  dataSource: sale,
                  xValueMapper: (SaleData, _) => SaleData.product,
                  yValueMapper: (SaleData, _) => SaleData.price,
                )
              ],
              primaryXAxis: CategoryAxis(
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                title: AxisTitle(
                    text: 'Product Name',
                    alignment: ChartAlignment.center,
                    textStyle: const TextStyle(fontWeight: FontWeight.w500)),
                majorTickLines: MajorTickLines(color: Colors.deepOrange,width: 5,size: 3),
                labelIntersectAction: AxisLabelIntersectAction.rotate45,
                minorTicksPerInterval: 4,
                  minorTickLines: MinorTickLines(color: Colors.green,width: 20,size: 3)
              ),
              primaryYAxis: NumericAxis(
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                title: AxisTitle(text: 'Sale Price'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Container(
                color: Colors.deepPurple,
                height: 10,
              ),
            ),
            SfCartesianChart(
              title: ChartTitle(text: ' ABC Shop Dashed-Line Sales - 2022'),
              legend: Legend(
                isVisible: true,
                backgroundColor: Colors.cyanAccent,
                iconBorderColor: Colors.deepOrange,
              ),
              tooltipBehavior: tooltipBehavior,
              series: <ChartSeries>[
                LineSeries<SaleData, String>(
                    name: "ABC",
                    dataSource: sale,
                    xValueMapper: (SaleData, _) => SaleData.product,
                    yValueMapper: (SaleData, _) => SaleData.price,
                    dashArray: [25, 15])
              ],
              primaryXAxis: CategoryAxis(
                labelIntersectAction: AxisLabelIntersectAction.wrap,
              ),
              primaryYAxis: NumericAxis(
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SaleData {
  SaleData(this.product, this.price);

  final String product;
  final double price;
}
