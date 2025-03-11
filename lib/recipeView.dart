import 'package:flutter/material.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecipeView extends StatefulWidget {
  final String url; // Use 'final' keyword for better practice

  const RecipeView(this.url, {Key? key}) : super(key: key);

  @override
  State<RecipeView> createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    final Uri? uri = Uri.tryParse(widget.url);
    if (uri != null && (uri.isScheme('http') || uri.isScheme('https'))) {
      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(uri);
    } else {
      // Handle invalid URL case
      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(Uri.parse('https://example.com')); // Default URL
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        gradient: const LinearGradient(
          colors: [
            Color(0xff071938),
            Color(0xff213A50),
          ],
        ),
        title: const Text(
          "Your Kitchen",
          style: TextStyle(
            fontFamily: "AsapCondensed",
            fontSize: 30,
          ),
        ),
      ),
      body: SafeArea(
        child: WebViewWidget(controller: controller),
      ),
    );
  }
}
