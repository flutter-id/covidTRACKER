import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:lancong/constants/style_constant.dart';
import 'package:lancong/global/global_function.dart' as GlobalFunction;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

class GraphScreen extends StatefulWidget {
  @override
  _GraphScreenState createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  List<charts.Series<Task, String>> _seriesPieData;
  List<dynamic> dataRegency = [];
  List<Task> data = [];

  setData() async {
    var server = await GlobalFunction.getServer();
    if (server != null) {
      var url = Uri.http(server, '/api/graph/province');
      final response = await http.get(
        url,
        headers: {"Accept": "application/json"},
      );
      var result = json.decode(response.body);
      if (response.statusCode == 200) {
        List<Task> temp = [];
        for (var index = 0; index < result['data'].length; index++) {
          this.setState(() {
            temp.add(
              new Task(
                result['data'][index]['name'].toString(),
                result['data'][index]['total'].toDouble(),
                Colors.primaries[Random().nextInt(Colors.primaries.length)],
              ),
            );
          });
        }
        this.setState(() {
          data = temp;
          _seriesPieData = <charts.Series<Task, String>>[];
          _generateData();
        });
      }
    }
  }

  _generateData() {
    _seriesPieData.add(
      charts.Series(
        data: this.data,
        domainFn: (Task task, _) => task.task,
        measureFn: (Task task, _) => task.taskvalue,
        colorFn: (Task task, _) =>
            charts.ColorUtil.fromDartColor(task.colorval),
        id: 'Graph',
        labelAccessorFn: (Task row, _) => '${row.taskvalue}',
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _seriesPieData = <charts.Series<Task, String>>[];
    _generateData();
    setData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              'COVID STATISTICS',
              style: mTitleStyle,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: charts.PieChart(
              _seriesPieData,
              animate: true,
              animationDuration: Duration(seconds: 3),
              behaviors: [
                new charts.DatumLegend(
                  outsideJustification: charts.OutsideJustification.endDrawArea,
                  horizontalFirst: false,
                  desiredMaxRows: 2,
                  cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
                  entryTextStyle: charts.TextStyleSpec(
                      color: charts.MaterialPalette.purple.shadeDefault,
                      fontFamily: 'Georgia',
                      fontSize: 11),
                )
              ],
              defaultRenderer: new charts.ArcRendererConfig(
                arcWidth: 100,
                arcRendererDecorators: [
                  new charts.ArcLabelDecorator(
                      labelPosition: charts.ArcLabelPosition.inside)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Task {
  String task;
  double taskvalue;
  Color colorval;
  Task(this.task, this.taskvalue, this.colorval);
}
