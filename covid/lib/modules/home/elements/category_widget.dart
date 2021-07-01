import 'package:flutter/material.dart';
import 'package:covidtracker/constants/color_constant.dart';
import 'package:covidtracker/constants/style_constant.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:basic_utils/basic_utils.dart';

class CategoryWidget extends StatelessWidget {
  final list;
  CategoryWidget({this.list});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: MediaQuery.of(context).size.width - 32,
          childAspectRatio: 3 / 1,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
        ),
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(right: 8, top: 8),
            padding: EdgeInsets.only(left: 16),
            // height: 64,
            decoration: BoxDecoration(
              color: mFillColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: mBorderColor, width: 1),
            ),
            child: Expanded(
              child: Row(
                children: [
                  // ,
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                        height: 30,
                        width: 30,
                        child: SvgPicture.asset('assets/svg/category.svg')),
                  ),
                  Expanded(
                    flex: 8,
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, top: 16),
                      child: Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              StringUtils.capitalize(list[index]['name']),
                              style: mTitleStyle,
                            ),
                            // Expanded(
                            //   child: Text(
                            //     list[index]['description'],
                            //     style: mServiceSubTitleStyle,
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  // Widget build(BuildContext context) {
  //   return
  // }
}
