import 'package:flutter/material.dart';
import 'package:lancong/constants/style_constant.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StoryWidget extends StatelessWidget {
  final List list;
  StoryWidget({this.list});
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: list == null ? 0 : list.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(bottom: 16),
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(right: 10),
            width: MediaQuery.of(context).size.width - 150,
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: NetworkImage(list[index]['image']),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Positioned(
                        child: SvgPicture.asset(
                            'assets/svg/covidTRACKER-small.svg'),
                        right: 5,
                        top: 5,
                      ),
                      Positioned(
                        child: SvgPicture.asset(
                            'assets/svg/travlog_bottom_gradient.svg'),
                        bottom: 0,
                      ),
                      Positioned(
                        child: Text(
                          list[index]['title'],
                          style: mTravLogTitleStyle,
                        ),
                        bottom: 8,
                        left: 8,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  list[index]['content'],
                  style: mTravLogContentStyle,
                  maxLines: 5,
                ),
                Text(
                  'Category: ' + list[index]['category_name'],
                  style: mTravLogCategoryStyle,
                  maxLines: 5,
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
