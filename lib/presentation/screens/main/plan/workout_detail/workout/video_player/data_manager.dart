import 'dart:async';

import 'package:dasgal/models/plan_model.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';

class DataManager {
  DataManager({
    required this.flickManager,
    required this.models,
    this.onChangeIndex
    });

  final onChangeIndex;
  final FlickManager flickManager;
  final List<WorkoutModel> models;

  int currentPlaying = 0;

  String getNextVideo() {
    currentPlaying++;
    return models[currentPlaying].video;
  }

  bool hasNextVideo() {
    return currentPlaying != models.length - 1;
  }

  bool hasPreviousVideo() {
    return currentPlaying != 0;
  }

  skipToNextVideo([Duration? duration]) {
    if (hasNextVideo()) {
      VideoPlayerController controller = VideoPlayerController.network(models[currentPlaying + 1].video);
      controller.setLooping(true);
      flickManager.handleChangeVideo(
          controller,
          videoChangeDuration: duration);
      currentPlaying++;
      onChangeIndex(currentPlaying);
    }
  }

  skipToPreviousVideo() {
    if (hasPreviousVideo()) {
      VideoPlayerController controller = VideoPlayerController.network(models[currentPlaying - 1].video);
      controller.setLooping(true);
      currentPlaying--;
      onChangeIndex(currentPlaying);
      flickManager.handleChangeVideo(
          controller);
    }
  }
}