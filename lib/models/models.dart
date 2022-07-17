class TopHQ {
  TopHQ({required this.img, required this.link, required this.title});

  TopHQ.fromJson(Map<String, dynamic> json)
      : img = json["img"],
        link = json["link"],
        title = json["title"];

  String img;
  String link;
  String title;
}

class ReleasesHQ {
  ReleasesHQ(
      {required this.img,
      required this.link,
      required this.title,
      required this.cap});

  ReleasesHQ.fromJson(Map<String, dynamic> json)
      : img = json['img'],
        link = json['link'],
        title = json['title'],
        cap = json['cap'];

  String img;
  String link;
  String title;
  String cap;
}

class ListHome {
  ListHome({required this.top, required this.releases});

  List<TopHQ> top;
  List<ReleasesHQ> releases;
}

class SearchHQ {
  SearchHQ(
      {required this.img,
      required this.title,
      required this.slug,
      required this.editora,
      required this.year,
      required this.chapters});

  SearchHQ.fromJson(Map<String, dynamic> json)
      : img = json['imagem'],
        title = json['titulo'],
        slug = json['url'],
        editora = json['editora'],
        year = json['ano'],
        chapters = json['capitulo'];

  String img;
  String title;
  String slug;
  String editora;
  String year;
  String chapters;
}

class ContentHQ {
  ContentHQ(
      {required this.title,
      required this.img,
      required this.titleAlter,
      required this.editora,
      required this.year,
      required this.status,
      required this.sinopse});

  String title;
  String img;
  String titleAlter;
  String editora;
  String year;
  String status;
  String sinopse;
}

class Chapters {
  Chapters({required this.img, required this.link, required this.cap});

  String img;
  String link;
  String cap;
}

class HQ {
  HQ({required this.content, required this.chapters});

  ContentHQ content;
  List<Chapters> chapters;
}

class ImageChapter {
  ImageChapter({required this.link});

  String link;
}

class Chapter {
  Chapter({required this.chapters, required this.images});

  List chapters;
  List<ImageChapter> images;
}