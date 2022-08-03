import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:untitled2/ui/main_screen.dart';
import 'bloc/bloc_album_cubit.dart';
import 'bloc/bloc_photo_cubit.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AlbumCubit>(create: (context) => AlbumCubit()),
        BlocProvider<PhotoCubit>(create: (context) => PhotoCubit()),
      ],
      child: const MaterialApp(
        title: 'Gallery',
        home: Gallery(),
      ),
    );
  }
}
