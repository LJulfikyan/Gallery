import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:untitled2/networking/call_API.dart';
import '../hive_data.dart';
import '../models/album_model.dart';
import '../models/photo_model.dart';
import '../networking/API_service.dart';
import 'bloc_photo_state.dart';

class PhotoCubit extends Cubit<PhotoState> {
  PhotoCubit() : super(PhotoLoading());

  fetchPhotos(List<Album> modelAlbums) async {
    BaseOptions options =
        BaseOptions(method: 'GET', baseUrl: ApiServices.baseURL);

    List<dynamic>? response = await HiveData.getPhotos();

    if (response == null) {
      response = await Future.wait([
        CallApi.call(
            url: '${ApiServices.photos}?albumId=${modelAlbums[0].id}',
            options: options)!,
        CallApi.call(
            url: '${ApiServices.photos}?albumId=${modelAlbums[1].id}',
            options: options)!,
        CallApi.call(
            url: '${ApiServices.photos}?albumId=${modelAlbums[2].id}',
            options: options)!,
        CallApi.call(
            url: '${ApiServices.photos}?albumId=${modelAlbums[3].id}',
            options: options)!,
      ]);
      HiveData.putPhotos(response);
    }
    if (response.isNotEmpty) {
      Map<int, List<Photo>> allPhotos = {};
      for (var album in response) {
        List<Photo> modelPhotos = [];
        for (var item in album) {
          modelPhotos.add(Photo.fromJson(item));
        }
        allPhotos[album[0]['albumId']] = modelPhotos;
      }
      emit(PhotoLoaded(allPhotos));
    } else {
      emit(PhotoError('An Error occurred'));
    }
  }
}
