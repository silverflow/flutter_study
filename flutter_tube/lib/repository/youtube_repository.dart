import 'package:flutter_tube/const/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_tube/model/video_model.dart';

class YoutubeRepository {
  static Future<List<VideoModel>> getVideos() async {
    final resp = await Dio().get(
      YOUTUBE_API_BASE_URL,
      queryParameters: {
        'key': API_KEY,
        'channelId': CHANNEL_ID,
        'part': 'snippet',
        'order': 'date',
        // 'maxResults': 10,
      },
    );

    final listWithData = resp.data['items'].where(
      (item) =>
          item?['id']?['videoId'] != null && item?['snippet']?['title'] != null,
    ); // videoId와 title이 null이 아닌 값들만 필터링

    return listWithData
        .map<VideoModel>(
          (item) => VideoModel(
            id: item['id']['videoId'],
            title: item['snippet']['title'],
          ),
        )
        .toList();
  }
}
