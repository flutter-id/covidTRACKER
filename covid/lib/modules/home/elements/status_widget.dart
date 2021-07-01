import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lancong/constants/style_constant.dart';
import 'package:lancong/constants/color_constant.dart';

class StatusWidget extends StatelessWidget {
  final list;
  StatusWidget({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list.length,
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
      itemBuilder: (context, index) {
        return Card(
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Container(
            height: 250,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: mBorderColor, width: 1),
            ),
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      width: 50,
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
                  ),
                  Text(
                    list[index]['status'].toUpperCase(),
                    style: list[index]['status'] == 'Positive'
                        ? mPositiveTextStyle
                        : mNegativeTextStyle,
                  ),
                  Text(
                    list[index]['date'],
                    style: mPopularDestinationSubTitleStyle,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
