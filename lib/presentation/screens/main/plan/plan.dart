import 'package:dasgal/core/constants/colors.dart';
import 'package:dasgal/core/constants/sizes.dart';
import 'package:dasgal/core/constants/strings.dart';
import 'package:dasgal/core/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    Widget _buildDayWidget(DateTime dateTime, bool isChecked, bool isToday) {
      return Container(
        width: 56,
        height: 60,
        decoration: BoxDecoration(
            color: isToday ? AppColors.primary : AppColors.surfaceSoft,
            borderRadius: BorderRadius.all(Radius.circular(14))
        ),
        padding: EdgeInsets.only(left: 9, right: 9),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(daysShort[dateTime.weekday-1], style: AppStyle.textCaption.copyWith(color: isToday ? Colors.white : AppColors.textColor),),
                if(isChecked) Icon(FeatherIcons.check, size: 12, color: AppColors.feedbackSuccess,)
              ],
            ),
            SizedBox(height: 4,),
            Text(dateTime.day.toString(), style: AppStyle.textSubtitle1.copyWith(color: isToday ? Colors.white : null),),
          ],
        ),
      );
    }

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.containerMargin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "Таны \nхөтөлбөрүүд 💪",
                    style: AppStyle.textHeader5.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 55, width: 85,
                  child: Stack(
                    children: [
                      Positioned(
                          left: 15,
                          top: 0,
                          child: SizedBox(
                              height: 46,
                              width: 32,
                              child: Text("3", textAlign: TextAlign.right,
                                style: AppStyle.textHeader4.copyWith(fontWeight: FontWeight.bold),))),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Text("хоног\nтасалдаагүй", textAlign: TextAlign.right, style: AppStyle.textCaption.copyWith(color: AppColors.textColor),)),
                    ],
                  ),)
              ],
            ),
          ),
          const SizedBox(height: 42,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.containerMargin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDayWidget(DateTime.now().subtract(Duration(days: 2)), false, false),
                _buildDayWidget(DateTime.now().subtract(Duration(days: 1)), true, false),
                _buildDayWidget(DateTime.now(), false, true),
                _buildDayWidget(DateTime.now().add(Duration(days: 1)), false, false),
                _buildDayWidget(DateTime.now().add(Duration(days: 2)), false, false),
              ],
            ),
          ),
          const SizedBox(height: 33,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.containerMargin),
            child: Text("Үндсэн хөтөлбөр", style: AppStyle.textSubtitle1.copyWith(fontWeight: FontWeight.bold),),
          ),
          const SizedBox(height: 24,),
          Expanded(child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.containerMargin),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          child: SizedBox(
                            height: 70,
                            width: 70,
                            child: Image.network("https://1.bp.blogspot.com/-aITtexE5Ij4/YRZip3oFwZI/AAAAAAAACEQ/XypBsTkn9J81mcD63FoYc1lfaYmy0gjcQCNcBGAsYHQ/s1600/images%2B%252827%2529.jpeg", fit: BoxFit.fitWidth,),
                          ),
                        ),
                        SizedBox(width: 16,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Өглөөний дасгал", style: AppStyle.textSubtitle2.copyWith(fontWeight: FontWeight.bold),),
                            SizedBox(height: 4,),
                            Text("Өглөөг угтахуй - 7 мин", style: AppStyle.textCaption.copyWith(color: AppColors.textColor))
                          ],
                        )
                      ],
                    ),

                    Container(
                      width: 35,
                      height: 70,
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight3,
                        borderRadius: BorderRadius.all(Radius.circular(8))
                      ),
                      child: Icon(FeatherIcons.chevronRight, color: AppColors.primary,),
                    )

                  ],
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
