// import 'dart:async';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class WebView extends StatefulWidget {
//   @override
//   WebViewState createState() => WebViewState();
// }
//
// class WebViewState extends State<WebView> {
//   final Completer<WebViewController> _controller =
//   Completer<WebViewController>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.grey,
//         title: Text('log apps'),
//         leading: IconButton(
//           onPressed: (){
//             Navigator.pop(context);
//           },
//           icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.black),
//         ),
//       ),
//       body: WebView(
//         initialUrl: 'https://log-apps.com/',
//         javascriptMode: JavascriptMode.unrestricted,
//         onWebViewCreated: (WebViewController webViewController) {
//           _controller.complete(webViewController);
//         },
//         onProgress: (int progress) {
//           print('WebView is loading (progress : $progress%)');
//         },
//         navigationDelegate: (NavigationRequest request) {
//           if (request.url.startsWith('https://www.youtube.com/')) {
//             print('blocking navigation to $request}');
//             return NavigationDecision.prevent;
//           }
//           print('allowing navigation to $request');
//           return NavigationDecision.navigate;
//         },
//         onPageStarted: (String url) {
//           print('Page started loading: $url');
//         },
//         onPageFinished: (String url) {
//           print('Page finished loading: $url');
//         },
//         gestureNavigationEnabled: true,
//         backgroundColor: const Color(0x00000000),
//       ),
//     );
//   }
// }