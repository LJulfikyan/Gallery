import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc_album_cubit.dart';
import '../bloc/bloc_album_state.dart';
import '../bloc/bloc_photo_cubit.dart';
import '../bloc/bloc_photo_state.dart';
import '../models/album_model.dart';
import 'appBar.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  GalleryState createState() => GalleryState();
}

class GalleryState extends State<Gallery> {
  List<Album> albumList = [];
  late AlbumCubit _albumCubit;

  @override
  void didChangeDependencies() {
    _albumCubit = BlocProvider.of<AlbumCubit>(context);
    _albumCubit.fetchAlbums();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: appBar(),
        body: BlocBuilder<AlbumCubit, AlbumState>(builder: (context, state) {
          if (state is AlbumLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AlbumLoaded) {
            albumList.addAll(state.modelAlbums.albums!);
            BlocProvider.of<PhotoCubit>(context).fetchPhotos(albumList);

            return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  int albumId = albumList[index % 4].id!;

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(albumList[index % 4].title ?? 'Album'),
                        BlocBuilder<PhotoCubit, PhotoState>(
                            builder: (context, state) {
                          if (state is PhotoLoading) {
                            return const Center(
                                child:
                                    Center(child: CircularProgressIndicator()));
                          } else if (state is PhotoLoaded) {
                            return SizedBox(
                              height: 120,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      height: size.height / 4,
                                      width: size.width / 3.2,
                                      child: CachedNetworkImage(
                                        imageUrl: state
                                                .photoModels[albumId]![
                                                    index % 3]
                                                .thumbnailUrl ??
                                            '',
                                        height:
                                            MediaQuery.of(context).size.width /
                                                3.5,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3.5,
                                      ),
                                    );
                                  }),
                            );
                          } else {
                            return const Center(child: Text('No image data'));
                          }
                        }),
                      ],
                    ),
                  );
                });
          } else {
            return Center(child: Text((state as AlbumError).error));
          }
        }));
  }
}
