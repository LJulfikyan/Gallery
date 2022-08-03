import 'package:hive/hive.dart';

class HiveData {
  static Box? _albumBox;
  static const String _openAlbum = 'albumBox';
  static Box? _photoBox;
  static const String _openPhoto = 'photoBox';

  static Future<List<dynamic>?> getAlbum() async {
    _albumBox = await Hive.openBox(_openAlbum);
    var albums = _albumBox!.get('albums');
    await _albumBox!.close();
    return albums;
  }

  static Future<void> putAlbum(List<dynamic>? albums) async {
    _albumBox = await Hive.openBox(_openAlbum);
    _albumBox!.put('albums', albums);
    await _albumBox!.close();
  }

  static Future<List<dynamic>?> getPhotos() async {
    _photoBox = await Hive.openBox(_openPhoto);
    var photos = _photoBox!.get('photos');
    await _photoBox!.close();
    return photos;
  }

  static Future<void> putPhotos(List<dynamic>? photos) async {
    _photoBox = await Hive.openBox(_openPhoto);
    _photoBox!.put('photos', photos);
    await _photoBox!.close();
  }
}
