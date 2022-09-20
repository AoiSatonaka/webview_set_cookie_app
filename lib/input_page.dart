import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:webview_set_cookie_app/webview_page.dart';

class CookieInfo {
  String key = '';
  String value = '';
  String domain = '';

  CookieInfo(this.key, this.value, this.domain);
}

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  String _targetURL = '';
  final List<CookieInfo> _cookies = [
    CookieInfo("dummy", 'dummy data', 'dummy domain')
  ];

  void _setTargetURL(String url) {
    setState(() {
      _targetURL = url;
    });
  }

  void _goToWebViewPage() {
    final props = WebViewPageProps(_targetURL, _cookies);
    Navigator.pushNamed(context, '/web', arguments: props);
  }

  DataRow generateRow(int index) {
    final cookie = _cookies[index];
    const decoration =
        InputDecoration(border: OutlineInputBorder(), isDense: true);

    final keyCell = DataCell(TextFormField(
        decoration: decoration,
        initialValue: cookie.key,
        onChanged: (key) => setState(() {
              cookie.key = key;
            })));
    final valueCell = DataCell(TextFormField(
      decoration: decoration,
      initialValue: cookie.value,
      onChanged: (value) => setState(() {
        cookie.value = value;
      }),
    ));
    final domainCell = DataCell(TextFormField(
      decoration: decoration,
      initialValue: cookie.value,
      onChanged: (domain) => setState(() {
        cookie.domain = domain;
      }),
    ));

    return DataRow(cells: [keyCell, valueCell, domainCell]);
  }

  void _addCookie() {
    setState(() {
      _cookies.add(CookieInfo('', '', _targetURL));
    });
  }

  @override
  Widget build(BuildContext context) {
    const List<DataColumn> tableHeaders = [
      DataColumn(label: Center(child: Text('key'))),
      DataColumn(label: Center(child: Text('value'))),
      DataColumn(label: Center(child: Text('domain')))
    ];

    return Scaffold(
        appBar: AppBar(title: const Text('WebViewSetCookieApp')),
        body: SingleChildScrollView(
            child: Center(
                child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(children: <Widget>[
            TextField(
                onChanged: _setTargetURL,
                decoration: const InputDecoration(hintText: 'url')),
            const Gap(20),
            DataTable(
                columns: tableHeaders,
                rows: List<DataRow>.generate(_cookies.length, generateRow)),
            const Gap(20),
            ElevatedButton(onPressed: _addCookie, child: const Text('行を追加')),
            const Gap(100),
            ElevatedButton(
              onPressed: _goToWebViewPage,
              style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 25),
                  fixedSize: const Size(500, 50)),
              child: const Text("WebViewを開く"),
            )
          ]),
        ))));
  }
}
