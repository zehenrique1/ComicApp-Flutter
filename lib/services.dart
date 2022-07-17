import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';

class DataHome {
  final Uri urlHome = Uri.parse('https://hqultimate.site/home');

  Future getData() async {
    http.Response response = await http.get(urlHome);
    getLast(response.body);
  }

  void getTop(String body) {
    List<dom.Element> rowReleases =
        parse(body).getElementsByClassName('lancamento-linha');
    for (dom.Element releases in rowReleases) {
      String img =
          releases.getElementsByTagName('img')[0].attributes.values.first;
      String link = releases
          .getElementsByClassName('link-titulo')[0]
          .attributes
          .values
          .last;
      String title =
          releases.getElementsByClassName('link-titulo')[0].text.trim();
    }
  }

  void getLast(String body){
    List<dom.Element> lasts = parse(body).getElementsByClassName('link-titulo');
    lasts.length = lasts.length - 10;

    for(dom.Element last in lasts){
      String img = last.getElementsByTagName('img')[0].attributes.values.first;
      String link = last.attributes.values.first;
      String cap = last.getElementsByTagName('small')[0].text.trim();
      String title = last.getElementsByTagName('h3')[0].text.replaceAll(cap, '').trim();
    }
  }
}

class DataSearch{
  Future getSearch(String search) async{
    Uri urlSearch = Uri.parse('https://hqultimate.site/assets/busca.php?q=$search');
    http.Response response = await http.get(urlSearch);
    Map jsonMap = json.decode(response.body);
  }
}

class DataHQ{
  Future getHQ() async {
    Uri urlHQ = Uri.parse('https://hqultimate.site/perfil/invencivel');
    http.Response response = await http.get(urlHQ);
    getChapters(response.body);

  }

  void getContentHQ(String body){
    dom.Document htm = parse(body);

    String title = htm.getElementsByClassName('col-md-12')[0].text;
    String img = htm.getElementsByClassName('img-thumbnail')[0].attributes.values.first;
    String titleAltern = htm.getElementsByClassName('manga-perfil')[0].text.replaceAll('Título(s) Alternativo(s): ', '').trim();
    String editora = htm.getElementsByClassName('manga-perfil')[1].text.replaceAll('Editora: ', '').trim();
    String year = htm.getElementsByClassName('manga-perfil')[2].text.replaceAll('Ano de Lançamento: ', '').trim();
    String status = htm.getElementsByClassName('manga-perfil')[4].text.replaceAll('Status: ', '').trim();
    String sinop = htm.getElementsByClassName('panel-body')[0].text.trim();
  }

  void getChapters(String body){
    List<dom.Element> chapters = parse(body).getElementsByClassName('link-titulo');
    chapters.length = chapters.length - 10;

    for(dom.Element chapter in chapters){
      String img = chapter.getElementsByTagName('img')[0].attributes.values.first;
      String cap = chapter.getElementsByTagName('h3')[0].text.trim().replaceAll('Cap. ', '');
      String link = chapter.attributes.values.first;
    }
  }
}

class DataChapter {
  Future getChapter() async {
    Uri urlChapter = Uri.parse('https://hqultimate.site/leitor/Invencivel/00');
    http.Response response = await http.get(urlChapter);
    getChapters(response.body);
  }

  void getImages(String body) {
    List<dom.Element> images = parse(body).getElementsByClassName(
        'img-responsive');
    for (dom.Element image in images) {
      String img = image.attributes.values.firstWhere((e) =>
          e.contains('http'));
    }
  }

  void getChapters(String body){
    List<dom.Element> chapters = parse(body).getElementById('cap_manga1')!.getElementsByTagName('option');

    for(dom.Element option in chapters){
      String chapter = option.attributes.values.first;
    }
  }
}
