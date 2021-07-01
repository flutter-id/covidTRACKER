import 'package:flutter/material.dart';
import 'package:lancong/modules/layout/layout_notifier.dart';
import 'package:lancong/constants/style_constant.dart';
import 'package:lancong/modules/story_form/story_form_notifier.dart';
import 'package:provider/provider.dart';
import 'package:lancong/global/global_function.dart' as GlobalFunction;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class StoryFormWidget extends StatefulWidget {
  const StoryFormWidget({Key key}) : super(key: key);

  @override
  _StoryFormWidgetState createState() => _StoryFormWidgetState();
}

class _StoryFormWidgetState extends State<StoryFormWidget> {
  List<dynamic> dataType = [];

  String categoryIdController;
  TextEditingController titleController = TextEditingController();
  TextEditingController slugController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController summaryController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  String statusController;
  bool featuredController = false;

  setCategory() async {
    var server = await GlobalFunction.getServer();
    var url = Uri.http(server, '/api/category');
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

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }

  File imageController;

  Future getImage(ImageSource media) async {
    ImagePicker image = ImagePicker();
    var img = await image.getImage(source: media);
    setState(() {
      imageController = File(img.path);
    });
    return img;
  }

  initState() {
    super.initState();
    this.setCategory();
  }

  @override
  Widget build(BuildContext context) {
    final StoryFormNotifier storyFormNotifier =
        Provider.of<StoryFormNotifier>(context);
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
                          'ADD NEW STORY',
                          style: mTitleStyle,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: imageController == null
                            ? Text('No image selected')
                            : Image.file(imageController),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 60,
                              width: double.infinity,
                              child: OutlinedButton(
                                child: Text(
                                  'Gallery',
                                  style: mButtonFont,
                                ),
                                onPressed: () {
                                  getImage(ImageSource.gallery);
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(15),
                                  side:
                                      BorderSide(width: 2, color: Colors.white),
                                  primary: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 60,
                              width: double.infinity,
                              child: OutlinedButton(
                                child: Text(
                                  'Camera',
                                  style: mButtonFont,
                                ),
                                onPressed: () {
                                  getImage(ImageSource.camera);
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(15),
                                  side:
                                      BorderSide(width: 2, color: Colors.white),
                                  primary: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          storyFormNotifier.errorImage,
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
                          'Category',
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
                          hint: Text('choose categori'),
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
                              categoryIdController = value.toString();
                            });
                          },
                          value: categoryIdController,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          storyFormNotifier.errorCategoryId,
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
                          'Title',
                          style: mTitleStyle,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0.0, style: BorderStyle.none),
                          ),
                          hintText: 'title story',
                          // prefixIcon: Icon(Icons.mail_outline),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          storyFormNotifier.errorTitle,
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
                          'Slug',
                          style: mTitleStyle,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: slugController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0.0, style: BorderStyle.none),
                          ),
                          hintText: 'slug story',
                          // prefixIcon: Icon(Icons.mail_outline),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          storyFormNotifier.errorSlug,
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
                        ),
                      ),
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
                          hintText: 'description story',
                          // prefixIcon: Icon(Icons.mail_outline),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          storyFormNotifier.errorDescription,
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
                          'Summary',
                          style: mTitleStyle,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: summaryController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0.0, style: BorderStyle.none),
                          ),
                          hintText: 'summary story',
                          // prefixIcon: Icon(Icons.mail_outline),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          storyFormNotifier.errorSummary,
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
                          'Content',
                          style: mTitleStyle,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: contentController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0.0, style: BorderStyle.none),
                          ),
                          hintText: 'content story',
                          // prefixIcon: Icon(Icons.mail_outline),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          storyFormNotifier.errorContent,
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
                          'Status',
                          style: mTitleStyle,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        height: 5,
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
                          items: <String>[
                            'Draft',
                            'Publish',
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
                          storyFormNotifier.errorStatus,
                          style: mErrorTextStyle,
                          textAlign: TextAlign.right,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Status',
                          style: mTitleStyle,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Row(
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor:
                                MaterialStateProperty.resolveWith(getColor),
                            value: featuredController,
                            onChanged: (bool value) {
                              setState(() {
                                featuredController = value;
                              });
                            },
                          ),
                          Text('show on home page')
                        ],
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          storyFormNotifier.errorFeatured,
                          style: mErrorTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          storyFormNotifier.errorUndefined,
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
                            Future story = storyFormNotifier.storyStore(
                              categoryIdController.toString(),
                              imageController,
                              titleController.text,
                              slugController.text,
                              descriptionController.text,
                              summaryController.text,
                              contentController.text,
                              statusController.toString(),
                              // photoController.text,
                              featuredController,
                            );
                            story.then((result) {
                              if (result) {
                                layoutNotifier.pageIndex = 3;
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
