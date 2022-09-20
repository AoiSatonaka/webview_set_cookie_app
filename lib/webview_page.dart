import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'input_page.dart';

class WebViewPageProps {
  final String targetURL;
  List<WebViewCookie> cookies = [];

  WebViewPageProps(this.targetURL, List<CookieInfo> infoList) {
    cookies = List<WebViewCookie>.generate(infoList.length, (index) {
      final info = infoList[index];
      return WebViewCookie(
          name: info.key, value: info.value, domain: info.domain);
    });
  }
}

class WebViewPage extends StatelessWidget {
  WebViewPage({super.key});

  WebViewController? _controller;
  final _cookieManager = CookieManager();

  @override
  Widget build(BuildContext context) {
    final props =
        ModalRoute.of(context)!.settings.arguments as WebViewPageProps;
    return Scaffold(
      appBar: AppBar(
        title: Text(props.targetURL),
      ),
      body: WebView(
        initialUrl: props.targetURL,
        javascriptMode: JavascriptMode.unrestricted,
        debuggingEnabled: true,
        onWebViewCreated: (controller) async {
          _controller = controller;
          // Cookieの初期化（ない場合は過去に保存したCookieがそのままになっている）
          // await _cookieManager.clearCookies();
        },
        onPageStarted: (_) async {
          props.cookies.forEach((cookie) async {
            await _cookieManager.setCookie(cookie);
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final cookie = await _controller
                ?.runJavascriptReturningResult('document.cookie');
            print('print cookie');
            print(props.cookies[0].value);
            print(cookie ?? 'naiyoooooo');
          },
          child: const Icon(Icons.web_outlined)),
    );
  }
}
