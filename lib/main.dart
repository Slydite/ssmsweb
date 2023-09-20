import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const SSMSWebView());
}

class SSMSWebView extends StatelessWidget {
  const SSMSWebView({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mess Menu',
      theme: ThemeData(
        primarySwatch: Colors.green,
        splashColor: Colors.black,
      ),
      home: const WebViewer(title: "Today's Menu"),
    );
  }
}

class WebViewer extends StatefulWidget {
  const WebViewer({super.key, required this.title});

  final String title;

  @override
  State<WebViewer> createState() => _WebViewerState();
}

class _WebViewerState extends State<WebViewer> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String day = DateFormat('EEEE').format(now).toLowerCase();
    String url = 'https://bppc-mess-menu.vercel.app/$day';

    var webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          body: WebViewWidget(
            controller: webController,
          )),
    );
  }
}
