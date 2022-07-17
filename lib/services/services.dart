import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';
import '../models/models.dart';

class DataHome {
  final Uri urlHome = Uri.parse('https://hqultimate.site/home');

  Future<ListHome> getData() async {
    http.Response response = await http.get(urlHome);
    return ListHome(
        top: getTop(response.body), releases: getLast(response.body));
  }

  // Function to get all Top HQS
  List<TopHQ> getTop(String body) {
    List<dom.Element> rowReleases =
        parse(body).getElementsByClassName('lancamento-linha');
    List<TopHQ> topHQs = [];
    for (dom.Element releases in rowReleases) {
      topHQs.add(TopHQ(
          img: releases.getElementsByTagName('img')[0].attributes.values.first,
          link: releases
              .getElementsByClassName('link-titulo')[0]
              .attributes
              .values
              .last
              .replaceAll('https://hqultimate.site/perfil/', ''),
          title:
              releases.getElementsByClassName('link-titulo')[0].text.trim()));
    }
    return topHQs;
  }

  // Function to get all releases HQS
  List<ReleasesHQ> getLast(String body) {
    List<dom.Element> lasts = parse(body).getElementsByClassName('link-titulo');
    lasts.length = lasts.length - 10;
    List<ReleasesHQ> releases = [];

    for (dom.Element last in lasts) {
      String cap = last.getElementsByTagName('small')[0].text.trim();
      releases.add(ReleasesHQ(
          img: last.getElementsByTagName('img')[0].attributes.values.first,
          link: last.attributes.values.first
              .replaceAll('https://hqultimate.site/perfil/', ''),
          title: last
              .getElementsByTagName('h3')[0]
              .text
              .replaceAll(cap, '')
              .trim(),
          cap: cap));
    }
    return releases;
  }
}

class DataSearch {
  // Function to get a list search items
  Future<List<SearchHQ>> getSearch(String search) async {
    Uri urlSearch =
        Uri.parse('https://hqultimate.site/assets/busca.php?q=$search');
    http.Response response = await http.get(urlSearch);
    List jsonDataList = json.decode(response.body)['items'];
    return jsonDataList.map((e) => SearchHQ.fromJson(e)).toList();
  }
}

class DataHQ {
  Future<HQ> getHQ(slug) async {
    Uri urlHQ = Uri.parse('https://hqultimate.site/perfil/$slug');
    http.Response response = await http.get(urlHQ);

    return HQ(
        content: getContentHQ(response.body),
        chapters: getChapters(response.body));
  }

  // Function to get content from HQ
  ContentHQ getContentHQ(String body) {
    dom.Document htm = parse(body);
    return ContentHQ(
        title: htm.getElementsByClassName('col-md-12')[0].text,
        img: htm
            .getElementsByClassName('img-thumbnail')[0]
            .attributes
            .values
            .first,
        titleAlter: htm
            .getElementsByClassName('manga-perfil')[0]
            .text
            .replaceAll('Título(s) Alternativo(s): ', '')
            .trim(),
        editora: htm
            .getElementsByClassName('manga-perfil')[1]
            .text
            .replaceAll('Editora: ', '')
            .trim(),
        year: htm
            .getElementsByClassName('manga-perfil')[2]
            .text
            .replaceAll('Ano de Lançamento: ', '')
            .trim(),
        status: htm
            .getElementsByClassName('manga-perfil')[4]
            .text
            .replaceAll('Status: ', '')
            .trim(),
        sinopse: htm.getElementsByClassName('panel-body')[0].text.trim());
  }

  // Function to get all chapters from HQ
  List<Chapters> getChapters(String body) {
    List<dom.Element> chapters =
        parse(body).getElementsByClassName('link-titulo');
    chapters.length = chapters.length - 10;
    List<Chapters> listChapters = [];

    for (dom.Element chapter in chapters) {
      listChapters.add(Chapters(
          img: chapter.getElementsByTagName('img')[0].attributes.values.first,
          cap: chapter
              .getElementsByTagName('h3')[0]
              .text
              .trim()
              .replaceAll('Cap. ', ''),
          link: chapter.attributes.values.first
              .replaceAll('https://hqultimate.site/leitor/', '')));
    }
    return listChapters;
  }
}

class DataChapter {
  Future<Chapter> getChapter(slug) async {
    Uri urlChapter = Uri.parse('https://hqultimate.site/leitor/$slug');
    http.Response response = await http.get(urlChapter);
    return Chapter(
        chapters: getChapters(response.body), images: getImages(response.body));
  }

  // Function to get all images from chapter
  List<ImageChapter> getImages(String body) {
    List<dom.Element> images =
        parse(body).getElementsByClassName('img-responsive');
    List<ImageChapter> listImages = [];
    for (dom.Element image in images) {
      listImages.add(ImageChapter(
          link: image.attributes.values.firstWhere((e) => e.contains('http'))));
    }
    return listImages;
  }

  // Function to get all chapters from Read page
  List getChapters(String body) {
    List<dom.Element> chapters = parse(body)
        .getElementById('cap_manga1')!
        .getElementsByTagName('option');
    List chaptersList = [];
    for (dom.Element option in chapters) {
      chaptersList.add(option.attributes.values.first);
    }
    return chaptersList;
  }
}
