import 'package:flutter/material.dart';
import 'package:image_editor/component/main_app_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image_editor/component/footer.dart';
import 'package:image_editor/component/emotion_sticker.dart';
import 'package:image_editor/model/sticker_model.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'dart:typed_data';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? image;
  Set<StickerModel> stickers = {};
  String? selectedId;
  GlobalKey imgKey = GlobalKey();

  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand, // 자식 위젯들 최대 크기로 펼치기
      children: [
        renderBody(),
        // mainAppbar를 좌, 우, 위 끝에 정렬
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: MainAppBar(
            onPickImage: onPickImage,
            onSaveImage: onSaveImage,
            onDeleteItem: onDeleteItem,
          ),
        ),
        if (image != null)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Footer(
              onEmotionTap: onEmotionTap,
            ),
          ),
      ],
    ));
  }

  Widget renderBody() {
    if (image != null) {
      // Stack 크기의 최대 크기만큼 차지하기
      return RepaintBoundary(
          key: imgKey,
          child: Positioned.fill(
              // 위젯 확대 및 좌우 이동을 가능하게 하는 위젯
              child: InteractiveViewer(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.file(
                  File(image!.path),
                  fit: BoxFit.cover,
                ),
                ...stickers.map((sticker) => Center(
                        child: EmotionSticker(
                      key: ObjectKey(sticker.id),
                      onTransform: () {
                        onTransform(sticker.id);
                      },
                      imgPath: sticker.imgPath,
                      isSelected: selectedId == sticker.id,
                    )))
              ],
            ),
          )));
    } else {
      return Center(
        child: TextButton(
          style: TextButton.styleFrom(
            primary: Colors.grey,
          ),
          onPressed: onPickImage,
          child: Text('이미지 선택하기'),
        ),
      );
    }
  }

  void onTransform(String id) {
    setState(() {
      selectedId = id;
    });
  }

  void onEmotionTap(int index) async {
    setState(() {
      stickers = {
        ...stickers,
        StickerModel(
          id: Uuid().v4(), // 스티커의 고유 ID
          imgPath: 'asset/img/sticker_$index.png',
        )
      };
    });
  }

  void onPickImage() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery); // 갤러리에서 이미지 선택하기

    setState(() {
      this.image = image;
    });
  }

  void onSaveImage() async {
    RenderRepaintBoundary boundary =
        imgKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    ui.Image image = await boundary.toImage(); // 바운더리를 이미지로 변경
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    // byte data 혀앹로 형태 변경
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    // PNG 형태를 저장
    await ImageGallerySaver.saveImage(pngBytes, quality: 100);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('저장되었습니다!')),
    );
  }

  void onDeleteItem() async {
    setState(() {
      stickers = stickers.where((sticker) => sticker.id != selectedId).toSet();
    });
  }
}
