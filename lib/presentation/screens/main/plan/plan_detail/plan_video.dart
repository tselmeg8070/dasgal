import 'package:dasgal/presentation/screens/main/plan/workout_detail/workout/video_player/custom_orientation_player.dart';
import 'package:dasgal/presentation/screens/main/plan/workout_detail/workout/video_player/data_manager.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlanVideo extends StatefulWidget {
  final String url;
  const PlanVideo({Key? key, required this.url}) : super(key: key);

  @override
  _PlanVideoState createState() => _PlanVideoState();
}

class _PlanVideoState extends State<PlanVideo> {

  late FlickManager flickManager;
  late DataManager dataManager;

  @override
  void initState() {
    VideoPlayerController videoPlayerController = VideoPlayerController.network(
        widget.url, videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true)
    );
    flickManager = FlickManager(
        videoPlayerController: videoPlayerController,
        onVideoEnd: () {
        }
    );
    dataManager = DataManager(
        flickManager: flickManager,
        models: [],
        onChangeIndex: (int index) {

        },
        onEnd: () async {

        }
    );
    super.initState();
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomOrientationPlayer(
      dataManager: dataManager,
      flickManager: flickManager,
    );
  }
}
