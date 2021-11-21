// import 'package:example/custom_orientation_player/controls.dart';
// import 'package:example/utils/mock_data.dart';
import 'package:dasgal/presentation/screens/main/plan/workout_detail/workout/video_player/controls.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:video_player/video_player.dart';

import 'controls.dart';
import 'data_manager.dart';

class CustomOrientationPlayer extends StatefulWidget {
  final FlickManager flickManager;
  final DataManager dataManager;
  final onClickNext;
  final onClickPrevious;
  CustomOrientationPlayer({Key? key,
    required this.flickManager,
    required this.dataManager,
    this.onClickNext,
    this.onClickPrevious}) : super(key: key);

  @override
  _CustomOrientationPlayerState createState() =>
      _CustomOrientationPlayerState();
}

class _CustomOrientationPlayerState extends State<CustomOrientationPlayer> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ObjectKey(widget.flickManager),
      onVisibilityChanged: (visibility) {
        if (visibility.visibleFraction == 0 && this.mounted) {
          widget.flickManager.flickControlManager?.autoPause();
        } else if (visibility.visibleFraction == 1) {
          widget.flickManager.flickControlManager?.autoResume();
        }
      },
      child: Column(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 4/3,
            child: FlickVideoPlayer(
              flickManager: widget.flickManager,
              flickVideoWithControls: FlickVideoWithControls(
                controls: CustomOrientationControls(dataManager: widget.dataManager),
              ),
              flickVideoWithControlsFullscreen: FlickVideoWithControls(
                videoFit: BoxFit.fitWidth,
                controls: CustomOrientationControls(dataManager: widget.dataManager),
              ),
            ),
          ),
        ],
      ),
    );
  }
}