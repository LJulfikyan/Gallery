import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../hive_data.dart';
import '../models/album_model.dart';
import '../networking/call_API.dart';
import '../networking/API_service.dart';
import 'bloc_album_state.dart';

class AlbumCubit extends Cubit<AlbumState> {
  AlbumCubit() : super(AlbumLoading());

  fetchAlbums() async {
    List<dynamic>? response;
    response = await HiveData.getAlbum();
    if (response == null) {
      BaseOptions options =
          BaseOptions(method: 'GET', baseUrl: ApiServices.baseURL);
      response = (await CallApi.call(url: ApiServices.albums, options: options))
          as List?;
      HiveData.putAlbum(response);
    }
    if (response != null) {
      emit(AlbumLoaded(ModelAlbum.fromJson(response)));
    } else {
      emit(AlbumError('An error occurred!'));
    }
  }
}
