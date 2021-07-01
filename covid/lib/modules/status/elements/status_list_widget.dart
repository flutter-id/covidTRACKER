import 'package:flutter/material.dart';
import 'package:covidtracker/constants/color_constant.dart';
import 'package:covidtracker/constants/style_constant.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StatusListWidget extends StatelessWidget {
  final List list;
  StatusListWidget({this.list});
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: list == null ? 0 : list.length,
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(bottom: 16),
        itemBuilder: (context, index) {
          return Card(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Container(
              padding: EdgeInsets.all(10),
              height: 145,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: mBorderColor, width: 1),
              ),
              child: Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: list[index]['status'] == 'Positive'
                          ? Center(
                              child:
                                  SvgPicture.asset('assets/svg/positive.svg'),
                            )
                          : Center(
                              child:
                                  SvgPicture.asset('assets/svg/negative.svg'),
                            ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              list[index]['status'].toUpperCase(),
                              style: list[index]['status'] == 'Positive'
                                  ? mPositiveTextStyle
                                  : mNegativeTextStyle,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              list[index]['type'],
                              style: mPopularDestinationTitleStyle,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              list[index]['date'],
                              style: mTitleStyle,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              list[index]['occupation'] +
                                  ' ' +
                                  list[index]['name'],
                              style: mTitleStyle,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              list[index]['institution'],
                              style: mTitleStyle,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
