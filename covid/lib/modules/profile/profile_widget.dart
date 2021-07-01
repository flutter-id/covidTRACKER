import 'package:flutter/material.dart';
import 'package:covidtracker/modules/layout/layout_notifier.dart';
import 'package:covidtracker/constants/style_constant.dart';
import 'package:covidtracker/modules/profile/profile_notifier.dart';
import 'package:provider/provider.dart';
import 'package:date_format/date_format.dart';
import 'package:covidtracker/global/global_function.dart' as GlobalFunction;
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key key}) : super(key: key);

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  String statusButton = 'Edit';
  bool readonly = true;

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
  String genderController = 'male';
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

  getProfile() async {
    var token = await GlobalFunction.getToken();
    var server = await GlobalFunction.getServer();
    var url = Uri.http(server, '/api/profile');
    final response = await http.get(
      url,
      headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $token',
      },
    );
    var result = json.decode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        this.nameController.text = result['data']['name'];
        this.emailController.text = result['data']['email'];
        this.addressController.text = result['data']['address'];
        this.birthPlaceController.text = result['data']['birth_place'];
        this.occupationController.text = result['data']['occupation'];
        this.birthDateController.text = formatDate(
            DateTime.parse(result['data']['birth_date']),
            [yyyy, '-', mm, '-', dd]);
        this.genderController = result['data']['gender'];
        this.provinceController = result['data']['province_id'];
        this.setRegency(result['data']['province_id']);
        this.regencyController = result['data']['regency_id'];
        this.setDistrict(result['data']['regency_id']);
        this.districtController = result['data']['district_id'];
        this.setVillage(result['data']['district_id']);
        this.villageIdController = result['data']['village_id'];
      });
    } else {
      print(result['message'].toString());
    }
  }

  initState() {
    setState(() {
      birthDateController.text =
          formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);
    });
    super.initState();
    this.setProvince();
    this.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    final ProfileNotifier profileNotifier =
        Provider.of<ProfileNotifier>(context);
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
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/images/avatar.png'),
                        minRadius: 80,
                      ),
                      IgnorePointer(
                        ignoring: readonly,
                        child: Column(
                          children: [
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
                                  borderSide: BorderSide(
                                      width: 0.0, style: BorderStyle.none),
                                ),
                                hintText: 'your full name',
                                // prefixIcon: Icon(Icons.mail_outline),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                profileNotifier.errorName,
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
                                  borderSide: BorderSide(
                                      width: 0.0, style: BorderStyle.none),
                                ),
                                hintText: 'example@domain.tld',
                                // prefixIcon: Icon(Icons.mail_outline),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                profileNotifier.errorEmail,
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
                                  borderSide: BorderSide(
                                      width: 0.0, style: BorderStyle.none),
                                ),
                                hintText: 'password',
                                // prefixIcon: Icon(Icons.mail_outline),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                profileNotifier.errorPassword,
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
                                  borderSide: BorderSide(
                                      width: 0.0, style: BorderStyle.none),
                                ),
                                hintText: 'retype password',
                                // prefixIcon: Icon(Icons.mail_outline),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                profileNotifier.errorPasswordConfirmation,
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
                                  borderSide: BorderSide(
                                      width: 0.0, style: BorderStyle.none),
                                ),
                                hintText: 'your address',
                                // prefixIcon: Icon(Icons.mail_outline),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                profileNotifier.errorAddress,
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
                                    value: 'male',
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
                                    value: 'female',
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
                                profileNotifier.errorGender,
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
                                  borderSide: BorderSide(
                                      width: 0.0, style: BorderStyle.none),
                                ),
                                hintText: 'birth place',
                                // prefixIcon: Icon(Icons.mail_outline),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                profileNotifier.errorBirthPlace,
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
                                            width: 0.0,
                                            style: BorderStyle.none),
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
                                profileNotifier.errorBirthDate,
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
                                  borderSide: BorderSide(
                                      width: 0.0, style: BorderStyle.none),
                                ),
                                hintText: 'your occupation',
                                // prefixIcon: Icon(Icons.mail_outline),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                profileNotifier.errorOccupation,
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
                                  side: BorderSide(
                                      width: 0.0, style: BorderStyle.none),
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
                            SizedBox(
                              height: 10,
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
                                  side: BorderSide(
                                      width: 0.0, style: BorderStyle.none),
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
                            SizedBox(
                              height: 10,
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
                                  side: BorderSide(
                                      width: 0.0, style: BorderStyle.none),
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
                            SizedBox(
                              height: 10,
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
                                  side: BorderSide(
                                      width: 0.0, style: BorderStyle.none),
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
                                profileNotifier.errorVillageId,
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
                                profileNotifier.errorUndefined,
                                style: mErrorTextStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: OutlinedButton(
                          child: Text(
                            statusButton,
                            style: mButtonFont,
                          ),
                          onPressed: () {
                            if (statusButton == 'Update') {
                              Future status = profileNotifier.update(
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
                              status.then(
                                (result) {
                                  if (result) {
                                    setState(() {
                                      readonly = true;
                                      statusButton = 'Edit';
                                      layoutNotifier.pageIndex = 7;
                                    });
                                  } else {
                                    setState(() {
                                      readonly = false;
                                      statusButton = 'Update';
                                    });
                                  }
                                },
                              );
                            } else if (statusButton == 'Edit') {
                              setState(() {
                                readonly = false;
                                statusButton = 'Update';
                              });
                            }
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
                      SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: OutlinedButton(
                          child: Text(
                            'Logout',
                            style: mButtonFont,
                          ),
                          onPressed: () {
                            Future status = profileNotifier.logout();
                            status.then(
                              (result) {
                                if (result) {
                                  setState(() {
                                    layoutNotifier.pageIndex = 7;
                                  });
                                }
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(15),
                            side: BorderSide(width: 2, color: Colors.white),
                            primary: Colors.blue,
                          ),
                        ),
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
