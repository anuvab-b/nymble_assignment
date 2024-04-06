class MusicListModel {
  List<MusicModel> result;

  MusicListModel({
    required this.result,
  });

  factory MusicListModel.fromJson(Map<String, dynamic> json) => MusicListModel(
    result: List<MusicModel>.from(json["result"].map((x) => MusicModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class MusicModel {
  String title;
  String artist;
  String url;
  String coverUrl;
  String tags;

  MusicModel({
    required this.title,
    required this.artist,
    required this.url,
    required this.coverUrl,
    required this.tags
  });

  factory MusicModel.fromJson(Map<String, dynamic> json) => MusicModel(
    title: json["title"],
    artist: json["artist"],
    url: json["url"],
    coverUrl: json["coverUrl"],
    tags: json["tags"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "artist": artist,
    "url": url,
    "coverUrl": coverUrl,
    "tags": tags,
  };
}