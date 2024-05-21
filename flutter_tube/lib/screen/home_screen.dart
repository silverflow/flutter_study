import 'package:flutter/material.dart';
import 'package:flutter_tube/component/custom_youtube_player.dart';
import 'package:flutter_tube/model/video_model.dart';
import 'package:flutter_tube/repository/youtube_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('뉴진스'),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<List<VideoModel>>(
        future: YoutubeRepository.getVideos(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              setState(() {});
            },
            child: ListView(
              // 아래로 당겨서 스크롤할 때 튕기는 애니메이션 추가
              physics: BouncingScrollPhysics(),
              children: snapshot.data!
                  .map((e) => CustomYoutubePlayer(videoModel: e))
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
