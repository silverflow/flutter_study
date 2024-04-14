import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatelessWidget {
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse('https://blog.metafor.kr'));
  HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Blog Web App'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                controller.loadRequest(Uri.parse('https://blog.metafor.kr'));
              },
              icon: Icon(Icons.home))
        ],
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
