import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase/profile_image_bloc/profile_image_event.dart';
import 'package:flutter_bloc_firebase/profile_image_bloc/profile_image_state.dart';
import 'package:flutter_bloc_firebase/repositories/firebase_storage_repository.dart';

class ProfileImageBloc extends Bloc<ProfileImageEvent, ProfileImageState> {
  final FirebaseStorageRepository firebaseStorageRepository;
  ProfileImageBloc({required this.firebaseStorageRepository})
      : super(ProfileImageState(loading: false, url: '')) {
    on<FetchProfileImage>(_fetchProfileImage);
    on<UploadProfileImage>(_uploadProfileImage);
  }

  _fetchProfileImage(FetchProfileImage event, Emitter emit) async {
    emit(state.copyWith(loading: true));
    final url = await firebaseStorageRepository.fetchProfileImage();
    emit(state.copyWith(loading: false, url: url));
  }

  _uploadProfileImage(UploadProfileImage event, Emitter emit) async {
    emit(state.copyWith(loading: true));
    final file = await firebaseStorageRepository.uploadFile(file: event.file);
    if (file != null) {
      print('success upload');
      add(FetchProfileImage());
    }
  }
}
