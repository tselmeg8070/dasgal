import 'dart:async';

import 'package:dasgal/core/constants/colors.dart';
import 'package:dasgal/core/constants/sizes.dart';
import 'package:dasgal/core/constants/styles.dart';
import 'package:dasgal/models/plan_model.dart';
import 'package:dasgal/presentation/screens/main/plan/workout_detail/workout/start_time.dart';
import 'package:dasgal/presentation/screens/main/plan/workout_detail/workout/video_player/custom_orientation_player.dart';
import 'package:dasgal/presentation/screens/main/plan/workout_detail/workout/video_player/data_manager.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:video_player/video_player.dart';


class WorkoutScreen extends StatefulWidget {
  final PlanModel planModel;
  const WorkoutScreen({Key? key, required this.planModel}) : super(key: key);

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {

  int _currentIndex = 0;
  List<WorkoutModel> _workouts = [];

  late FlickManager flickManager;
  late DataManager dataManager;
  late DateTime startTime;

  int _seconds = 5;
  late Timer _timer;

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_seconds == 0) {
          setState(() {
            timer.cancel();
          });
          dataManager.skipToNextVideo();
        } else {
          setState(() {
            _seconds--;
          });
        }
      },
    );
  }


  @override
  void initState() {
    startTime = DateTime.now();
    _startTimer();

    List<WorkoutModel> models = [];
    for (var round in widget.planModel.rounds) {
      for (var workout in round.workouts) {
        models.add(workout);
      }
    }
    _workouts = models;
    _seconds = models.first.duration.inSeconds;

    VideoPlayerController videoPlayerController = VideoPlayerController.network(
      _workouts.first.video,
    );
    videoPlayerController.setLooping(true);
    flickManager = FlickManager(
      videoPlayerController: videoPlayerController,
    );
    flickManager.flickVideoManager!.addListener(_videoPlayingListener);
    dataManager = DataManager(
        flickManager: flickManager,
        models: _workouts,
        onChangeIndex: (int index) {
          setState(() {
            _currentIndex = index;
            _seconds = _workouts[index].duration.inSeconds;
          });
        }
    );
    super.initState();
  }

  _videoPlayingListener() async {
    if (!flickManager.flickVideoManager!.isPlaying) {
      setState(() {
        _timer.cancel();
      });
    } else {
      if(!_timer.isActive) {
        _startTimer();
      }
    }
  }


  @override
  void dispose() {
    _timer.cancel();
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            CustomOrientationPlayer(
              dataManager: dataManager,
              flickManager: flickManager,
            ),
            const Expanded(child: SizedBox()),
            Text(_workouts[_currentIndex].name, style: AppStyle.textHeader6.copyWith(fontWeight: FontWeight.normal),),
            const Expanded(child: SizedBox()),
            Text("${(_seconds~/60).toString().padLeft(2, "0")}:${(_seconds%60).toString().padLeft(2, "0")}", style: AppStyle.textHeader2.copyWith(color: AppColors.textColor),),
            StartTimeWidget(startTime: startTime),
            const Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.containerMargin),
              child: GestureDetector(
                onTap: () {
                  dataManager.skipToNextVideo();
                },
                child: SizedBox(
                  height: 74,
                  width: double.maxFinite,
                  child: Stack(
                    children: [
                      Positioned(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: AppColors.secondaryLight3,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 44,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(_currentIndex >= _workouts.length - 1
                                        ? "Сүүлийнх"
                                        : "Дараагийнх", style: AppStyle.textCaption.copyWith(color: AppColors.textColor),),
                                    Text(_currentIndex >= _workouts.length - 1
                                        ? "Дуусгах"
                                        : _workouts[_currentIndex + 1].name,
                                      style: AppStyle.textSubtitle2.copyWith(color: AppColors.textColorHigh, fontWeight: FontWeight.normal),),
                                  ],
                                ),
                              ),
                              const Padding(padding: EdgeInsets.only(right: 8),
                                child: Icon(FeatherIcons.chevronRight, size: 18, color: AppColors.primary,),)
                            ],
                          ),
                        ),
                      )),
                      Padding(
                        padding: const EdgeInsets.only(top: 13.0),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(12)),
                          child: SizedBox(
                            height: 48,
                            width: 48,
                            child: Image.network(_currentIndex >= _workouts.length - 1
                                ? "https://images.unsplash.com/photo-1519681393784-d120267933ba?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80"
                                : _workouts[_currentIndex + 1].image, fit: BoxFit.cover,),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.containerMargin),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: _workouts.map<Widget>((workout) =>
                  Expanded( child: Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Container(
                      height: 6,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(2)),
                          color: _workouts.indexOf(workout) > _currentIndex
                              ? AppColors.primaryLight3
                              : AppColors.primary
                      ),
                    ),
                  ),)
              ).toList(),
            ),
          ),
          IconButton(
            icon: const Icon(FeatherIcons.x, color: AppColors.textColorHigh,),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
