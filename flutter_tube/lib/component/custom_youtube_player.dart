import 'package:flutter/material.dart';
import 'package:flutter_tube/model/video_model.dart';

// 유튜브 재생기를 사용하기 위해 패키지 불러오기
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// 유튜브 동영상 재생기가 될 위젯
class CustomYoutubePlayer extends StatefulWidget {
  // 상위 위젯에서 입력받을 동영상 정보
  final VideoModel videoModel;

  const CustomYoutubePlayer({Key? key, required this.videoModel})
      : super(key: key);

  @override
  State<CustomYoutubePlayer> createState() => _CustomYoutubePlayerState();
}

class _CustomYoutubePlayerState extends State<CustomYoutubePlayer> {
  YoutubePlayerController? controller;

  @override
  void initState() {
    super.initState();
    controller = YoutubePlayerController(
      initialVideoId: widget.videoModel.id,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 임시로 기본 컨테이너 반환
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        YoutubePlayer(
            controller: controller!, showVideoProgressIndicator: true),
        const SizedBox(height: 16.0),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              widget.videoModel.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
              ),
            )),
        const SizedBox(
          height: 16.0,
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller!.dispose();
  }
}
