import '../models/photo_model.dart';

abstract class PhotoState {}

class PhotoError extends PhotoState {
  String error;
  PhotoError(this.error);
}

class PhotoLoading extends PhotoState {
  PhotoLoading();
}

class PhotoLoaded extends PhotoState {
  final Map<int, List<Photo>> photoModels;

  PhotoLoaded(this.photoModels);
}
