import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsView extends StatefulWidget {
 String url="";
 NewsView (this.url);

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  final Completer<WebViewController> controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
      title: Text('HMZ NewZ',
        style: TextStyle(
          fontFamily: 'Neucha',
          fontWeight: FontWeight.bold,
          fontSize: 32,
        ),),
      centerTitle: true,
      backgroundColor: Colors.black87,
      ),
      body: Container(
        child: WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webviewcontroller) {
            setState(() {
              controller.complete(webviewcontroller);
            });
          },
        ),
      )
    );

    }
  }

