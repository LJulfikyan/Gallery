import '../models/album_model.dart';

abstract class AlbumState {}

class AlbumLoading extends AlbumState {
  AlbumLoading();
}

class AlbumLoaded extends AlbumState {
  final ModelAlbum modelAlbums;
  bool deleteMode = false;

  AlbumLoaded(this.modelAlbums, {this.deleteMode = false});
}

class AlbumError extends AlbumState {
  String error;
  AlbumError(this.error);
}
