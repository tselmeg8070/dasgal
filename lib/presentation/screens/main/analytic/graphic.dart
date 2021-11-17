import 'package:dasgal/core/constants/colors.dart';
import 'package:dasgal/core/constants/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DataModel {
  double x;
  double y;
  String text;

  DataModel({required this.x, required this.y, required this.text});
}


class CustomMountainTopGraph extends StatelessWidget {

  final double yMin;
  final double yMax;
  final String yTitle;
  final String xTitle;
  final List<List<DataModel>> chartData;

  const CustomMountainTopGraph({Key? key,
    this.yMax = 0, this.yMin = 0,
    required this.xTitle, required this.yTitle,
    required this.chartData
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RotatedBox(
                quarterTurns: 3,
                child: SizedBox(
                  width: 320,
                  child: Text(
                    yTitle,
                    textAlign: TextAlign.center,
                    style: AppStyle.textCaption.copyWith(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ) //your text
            ),
            const SizedBox(
              width: 2,
            ),
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 320,
                    child: SfCartesianChart(
                        palette: const <Color>[
                          AppColors.primary
                        ],
                        margin: const EdgeInsets.all(0),
                        plotAreaBorderWidth: 0,
                        primaryXAxis: NumericAxis(
                          // X axis is hidden now
                            isVisible: true,
                            minimum: 0,
                          labelStyle: AppStyle.textCaptionSmall.copyWith(color: AppColors.textColor),

                        ),
                        primaryYAxis: NumericAxis(
                            isVisible: true,
                            maximum: yMax,
                            minimum: yMin,
                          labelStyle: AppStyle.textCaptionSmall.copyWith(color: AppColors.textColor),
                        ),
                        series: chartData.map<SplineSeries<DataModel, double>>((chart) {
                          return  SplineSeries(
                            width: chartData.last == chart ? 1 : 0.5,
                            color: AppColors.primary,
                            dashArray: chartData.last == chart ? null : <double>[5,5],
                            splineType: SplineType.monotonic,
                            cardinalSplineTension: 1,
                            markerSettings: chartData.last == chart ? const MarkerSettings(isVisible: true, borderWidth: 1, width: 3, height: 3) : null,
                            xValueMapper: (data, int index) {
                              return data.x;
                            },
                            dataSource: chart,
                            yValueMapper: (data, int index) {
                              return data.y;
                            },
                          );
                        }
                        ).toList()),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 2,
                      ),
                      Text(xTitle,
                          style: AppStyle.textCaption.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textColor))
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}