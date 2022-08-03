class ModelAlbum {
  List<Album>? albums;

  ModelAlbum.fromJson(List<dynamic>? json) {
    if (json != null) {
      albums = [];
      for (var e in json) {
        albums!.add(Album.fromJson(e));
      }
    }
  }
}

class Album {
  Album({
    this.userId,
    this.id,
    this.title,
  });

  Album.fromJson(dynamic json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
  }
  int? userId;
  int? id;
  String? title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['id'] = id;
    map['title'] = title;
    return map;
  }
}
