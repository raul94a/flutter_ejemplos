import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase/profile_image_bloc/profile_image_bloc.dart';
import 'package:flutter_bloc_firebase/profile_image_bloc/profile_image_event.dart';
import 'package:flutter_bloc_firebase/repositories/firebase_storage_repository.dart';
import 'package:image_picker/image_picker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseStorageRepository =
        FirebaseStorageRepository(storage: FirebaseStorage.instance);
    return BlocProvider(
      create: (context) => ProfileImageBloc(
          firebaseStorageRepository: firebaseStorageRepository),
      child: Builder(builder: (ctx) {
        final bloc = ctx.watch<ProfileImageBloc>();
        return MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: bloc.state.loading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : null,
            ),
            body: Center(
                child: GestureDetector(
              onTap: () {
                ImagePicker()
                    .pickImage(
                        source: ImageSource.camera,
                        preferredCameraDevice: CameraDevice.rear)
                    .then((xFile) {
                  ctx
                      .read<ProfileImageBloc>()
                      .add(UploadProfileImage(file: xFile));
                });
              },
              child: CircleAvatar(
                radius: 150,
                backgroundColor: Colors.transparent,
                backgroundImage: bloc.state.url.isEmpty
                    ? null
                    : NetworkImage(bloc.state.url),
                child: bloc.state.url.isNotEmpty
                    ? const SizedBox.shrink()
                    : const  Icon(Icons.camera_alt_outlined),
              ),
            )),
          ),
        );
      }),
    );
  }
}
