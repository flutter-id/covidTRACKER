import 'package:flutter/material.dart';
import 'package:lancong/modules/layout/layout_notifier.dart';
import 'package:lancong/constants/style_constant.dart';
import 'package:lancong/modules/status_form/status_form_notifier.dart';
import 'package:provider/provider.dart';
import 'package:date_format/date_format.dart';
import 'package:lancong/global/global_function.dart' as GlobalFunction;
import 'package:http/http.dart' as http;
import 'dart:convert';

class StatusFormWidget extends StatefulWidget {
  const StatusFormWidget({Key key}) : super(key: key);

  @override
  _StatusFormWidgetState createState() => _StatusFormWidgetState();
}

class _StatusFormWidgetState extends State<StatusFormWidget> {
  List<dynamic> dataType = [];

  TextEditingController dateController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController institutionController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String occupationController;
  String typeIdController;
  String statusController;

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        dateController.text = formatDate(value, [yyyy, '-', mm, '-', dd]);
      });
    });
  }

  setType() async {
    var server = await GlobalFunction.getServer();
    var url = Uri.http(server, '/api/type');
    final response = await http.get(
      url,
      headers: {
        "Accept": "application/json",
      },
    );
    var result = json.decode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        this.dataType = result['data'];
      });
    }
  }

  initState() {
    setState(() {
      dateController.text =
          formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);
    });
    super.initState();
    this.setType();
  }

  @override
  Widget build(BuildContext context) {
    final StatusFormNotifier statusFormNotifier =
        Provider.of<StatusFormNotifier>(context);
    final LayoutNotifier layoutNotifier = Provider.of<LayoutNotifier>(context);
    return Container(
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: <Widget>[
          Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 16, right: 16),
              width: MediaQuery.of(context).size.width,
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'ADD NEW STATUS',
                          style: mTitleStyle,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Date',
                          style: mTitleStyle,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: TextField(
                              controller: dateController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0.0, style: BorderStyle.none),
                                ),
                                hintText: '31/12/2021',
                                // prefixIcon: Icon(Icons.mail_outline),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: GestureDetector(
                              child: Icon(
                                Icons.calendar_today,
                              ),
                              onTap: () {
                                _showDatePicker();
                              },
                            ),
                          )
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          statusFormNotifier.errorDate,
                          style: mErrorTextStyle,
                          textAlign: TextAlign.right,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Medical Person Name',
                          style: mTitleStyle,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0.0, style: BorderStyle.none),
                          ),
                          hintText: 'medical person name',
                          // prefixIcon: Icon(Icons.mail_outline),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          statusFormNotifier.errorName,
                          style: mErrorTextStyle,
                          textAlign: TextAlign.right,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Occupation',
                          style: mTitleStyle,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      DecoratedBox(
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side:
                                BorderSide(width: 0.0, style: BorderStyle.none),
                          ),
                        ),
                        child: DropdownButton<String>(
                          itemHeight: 60,
                          isExpanded: true,
                          value: occupationController,
                          onChanged: (String value) {
                            setState(() {
                              occupationController = value;
                            });
                          },
                          items: <String>[
                            'Medical Person',
                            'Nurse',
                            'Doctor',
                            'Other'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          statusFormNotifier.errorOccupation,
                          style: mErrorTextStyle,
                          textAlign: TextAlign.right,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Institution',
                          style: mTitleStyle,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: institutionController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0.0, style: BorderStyle.none),
                          ),
                          hintText: 'your full institution',
                          // prefixIcon: Icon(Icons.mail_outline),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          statusFormNotifier.errorInstitution,
                          style: mErrorTextStyle,
                          textAlign: TextAlign.right,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Inspection Type',
                          style: mTitleStyle,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      DecoratedBox(
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side:
                                BorderSide(width: 0.0, style: BorderStyle.none),
                          ),
                        ),
                        child: DropdownButton(
                          hint: Text('your type'),
                          itemHeight: 60,
                          isExpanded: true,
                          items: dataType.map((item) {
                            return DropdownMenuItem(
                              child: Text(item['name'].toString()),
                              value: item['id'].toString(),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              typeIdController = value.toString();
                            });
                          },
                          value: typeIdController,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          statusFormNotifier.errorTypeId,
                          style: mErrorTextStyle,
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Status',
                          style: mTitleStyle,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      DecoratedBox(
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side:
                                BorderSide(width: 0.0, style: BorderStyle.none),
                          ),
                        ),
                        child: DropdownButton<String>(
                          itemHeight: 60,
                          isExpanded: true,
                          value: statusController,
                          onChanged: (String value) {
                            setState(() {
                              statusController = value;
                            });
                          },
                          items: <String>['Positive', 'Negative']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          statusFormNotifier.errorStatus,
                          style: mErrorTextStyle,
                          textAlign: TextAlign.right,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Description',
                            style: mTitleStyle,
                            textAlign: TextAlign.left,
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: descriptionController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0.0, style: BorderStyle.none),
                          ),
                          hintText: 'your full description',
                          // prefixIcon: Icon(Icons.mail_outline),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          statusFormNotifier.errorDescription,
                          style: mErrorTextStyle,
                          textAlign: TextAlign.right,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          statusFormNotifier.errorUndefined,
                          style: mErrorTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: OutlinedButton(
                          child: Text(
                            'Save',
                            style: mButtonFont,
                          ),
                          onPressed: () {
                            Future status = statusFormNotifier.statusStore(
                              dateController.text,
                              nameController.text,
                              occupationController.toString(),
                              institutionController.text,
                              // photoController.text,
                              typeIdController.toString(),
                              statusController.toString(),
                              descriptionController.text,
                            );
                            status.then((result) {
                              if (result) {
                                layoutNotifier.pageIndex = 1;
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(15),
                            side: BorderSide(width: 2, color: Colors.white),
                            primary: Colors.blue,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
