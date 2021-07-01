import 'package:flutter/material.dart';
import 'package:covidtracker/modules/layout/layout_notifier.dart';
import 'package:covidtracker/constants/style_constant.dart';
import 'package:covidtracker/modules/register/register_notifier.dart';
import 'package:provider/provider.dart';
import 'package:date_format/date_format.dart';
import 'package:covidtracker/global/global_function.dart' as GlobalFunction;
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({Key key}) : super(key: key);

  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  List<dynamic> dataProvince = [];
  List<dynamic> dataRegency = [];
  List<dynamic> dataDistrict = [];
  List<dynamic> dataVillage = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController birthPlaceController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  String genderController = 'Male';
  String provinceController;
  String regencyController;
  String districtController;
  String villageIdController;

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
        birthDateController.text = formatDate(value, [yyyy, '-', mm, '-', dd]);
      });
    });
  }

  setProvince() {
    var data = GlobalFunction.getProvince();
    data.then((value) {
      setState(() {
        this.dataProvince = value;
      });
    });
  }

  setRegency(String id) async {
    var server = await GlobalFunction.getServer();
    var url = Uri.http(server, '/api/wilayah/regency/' + id);
    final response = await http.get(
      url,
      headers: {"Accept": "application/json"},
    );
    var result = json.decode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        this.dataRegency = result['data'];
      });
    }
  }

  setDistrict(String id) async {
    var server = await GlobalFunction.getServer();
    var url = Uri.http(server, '/api/wilayah/district/' + id);
    final response = await http.get(
      url,
      headers: {"Accept": "application/json"},
    );
    var result = json.decode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        this.dataDistrict = result['data'];
      });
    }
  }

  setVillage(String id) async {
    var server = await GlobalFunction.getServer();
    var url = Uri.http(server, '/api/wilayah/village/' + id);
    final response = await http.get(
      url,
      headers: {"Accept": "application/json"},
    );
    var result = json.decode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        this.dataVillage = result['data'];
      });
    }
  }

  initState() {
    setState(() {
      birthDateController.text =
          formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);
    });
    super.initState();
    this.setProvince();
  }

  @override
  Widget build(BuildContext context) {
    final RegisterNotifier registerNotifier =
        Provider.of<RegisterNotifier>(context);
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
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          'REGISTER',
                          style: mTitleStyle,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Name',
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
                          hintText: 'your full name',
                          // prefixIcon: Icon(Icons.mail_outline),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          registerNotifier.errorName,
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
                            'Email ID',
                            style: mTitleStyle,
                            textAlign: TextAlign.left,
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0.0, style: BorderStyle.none),
                          ),
                          hintText: 'example@domain.tld',
                          // prefixIcon: Icon(Icons.mail_outline),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          registerNotifier.errorEmail,
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
                            'Password',
                            style: mTitleStyle,
                            textAlign: TextAlign.left,
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0.0, style: BorderStyle.none),
                          ),
                          hintText: 'password',
                          // prefixIcon: Icon(Icons.mail_outline),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          registerNotifier.errorPassword,
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
                            'Retype Password',
                            style: mTitleStyle,
                            textAlign: TextAlign.left,
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: passwordConfirmationController,
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0.0, style: BorderStyle.none),
                          ),
                          hintText: 'retype password',
                          // prefixIcon: Icon(Icons.mail_outline),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          registerNotifier.errorPasswordConfirmation,
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
                          'Address',
                          style: mTitleStyle,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: addressController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0.0, style: BorderStyle.none),
                          ),
                          hintText: 'your address',
                          // prefixIcon: Icon(Icons.mail_outline),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          registerNotifier.errorAddress,
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
                          'Gender',
                          style: mTitleStyle,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Column(
                        children: <Widget>[
                          ListTile(
                            title: const Text('Male'),
                            leading: Radio(
                              value: 'Male',
                              groupValue: genderController,
                              onChanged: (value) {
                                setState(() {
                                  genderController = value;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text('Female'),
                            leading: Radio(
                              value: 'Female',
                              groupValue: genderController,
                              onChanged: (value) {
                                setState(() {
                                  genderController = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          registerNotifier.errorGender,
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
                          'Birth Place',
                          style: mTitleStyle,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: birthPlaceController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0.0, style: BorderStyle.none),
                          ),
                          hintText: 'birth place',
                          // prefixIcon: Icon(Icons.mail_outline),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          registerNotifier.errorBirthPlace,
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
                          'Birth Date',
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
                              controller: birthDateController,
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
                          registerNotifier.errorBirthDate,
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
                      TextField(
                        controller: occupationController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0.0, style: BorderStyle.none),
                          ),
                          hintText: 'your occupation',
                          // prefixIcon: Icon(Icons.mail_outline),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          registerNotifier.errorOccupation,
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
                          'Province',
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
                          hint: Text('your province'),
                          itemHeight: 60,
                          isExpanded: true,
                          items: dataProvince.map((item) {
                            return DropdownMenuItem(
                              child: Text(item['name'].toString()),
                              value: item['id'].toString(),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              if (value != null) {
                                provinceController = value.toString();
                                dataRegency = [];
                                setRegency(value.toString());
                              }
                            });
                          },
                          value: provinceController,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          registerNotifier.errorEmail,
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
                          'Regency',
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
                          hint: Text('your regency'),
                          itemHeight: 60,
                          isExpanded: true,
                          items: dataRegency.map((item) {
                            return DropdownMenuItem(
                              child: Text(item['name'].toString()),
                              value: item['id'].toString(),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              if (value != null) {
                                regencyController = value.toString();
                                setDistrict(value);
                              }
                            });
                          },
                          value: regencyController,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          registerNotifier.errorEmail,
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
                          'District',
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
                          hint: Text('your district'),
                          itemHeight: 60,
                          isExpanded: true,
                          items: dataDistrict.map((item) {
                            return DropdownMenuItem(
                              child: Text(item['name'].toString()),
                              value: item['id'].toString(),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              if (value != null) {
                                districtController = value.toString();
                                setVillage(value);
                              }
                            });
                          },
                          value: districtController,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          registerNotifier.errorEmail,
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
                          'Village',
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
                          hint: Text('your village'),
                          itemHeight: 60,
                          isExpanded: true,
                          items: dataVillage.map((item) {
                            return DropdownMenuItem(
                              child: Text(item['name'].toString()),
                              value: item['id'].toString(),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              villageIdController = value.toString();
                            });
                          },
                          value: villageIdController,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          registerNotifier.errorVillageId,
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
                          registerNotifier.errorUndefined,
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
                            'Register',
                            style: mButtonFont,
                          ),
                          onPressed: () {
                            Future status = registerNotifier.register(
                              nameController.text,
                              emailController.text,
                              passwordController.text,
                              passwordConfirmationController.text,
                              // photoController.text,
                              addressController.text,
                              genderController.toString(),
                              birthPlaceController.text,
                              birthDateController.text,
                              occupationController.text,
                              villageIdController.toString(),
                            );
                            status.then((result) {
                              if (result) {
                                layoutNotifier.pageIndex = 0;
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
