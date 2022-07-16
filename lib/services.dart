import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';

class DataHome {
  final urlSite = Uri.parse('https://hqdragon.com/');

  Future getHome() async {
    http.Response response = await http.get(urlSite);
    updatedHQ(response.body);
  }

  void updatedHQ(String body) {
    dom.Document htm = parse(body);
    dom.Element? tbody = htm.getElementById('lista-hqs');
    List<HQ> hqs = [];

    if (tbody != null) {
      for (dom.Element? tr in tbody.getElementsByTagName('tr')) {
        List<dom.Element> td = tr!.getElementsByTagName('td');

        String cap = td[1].getElementsByTagName('em')[0].text;
        String title = td[1]
            .getElementsByTagName('a')[0]
            .text
            .split('\n')[1]
            .replaceAll(cap, '')
            .trim();

        hqs.add(HQ(
            img: td[0].getElementsByTagName('img')[0].attributes.values.first,
            url: td[1].getElementsByTagName('a')[0].attributes.values.first,
            cap: cap,
            date: td[1].getElementsByTagName('em')[1].text,
            title: title));

      }
    }
  }
}

class HQ {
  HQ(
      {required this.img,
      required this.url,
      required this.cap,
      required this.date,
      required this.title});

  HQ.fromJson(Map<String, dynamic> json)
      : img = json['img'],
        url = json['url'],
        cap = json['cap'],
        date = json['date'],
        title = json['title'];

  String img;
  String url;
  String cap;
  String date;
  String title;
}
