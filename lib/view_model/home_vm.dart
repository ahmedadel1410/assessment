import 'package:assessment/model/models/photo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../model/services/provider/provider_setup.dart';

class HomeCubit extends Cubit<HomeState> {
  final BuildContext context;
  List<Photo> photos = [];
  int currentPage = 1;
  int limit = 10;
  bool isLoadingMore = false;

  HomeCubit({required this.context}) : super(HomeInitial()) {
    getPhotos();
  }

  Future<void> getPhotos({bool isMore = false}) async {
    if (isMore) {
      isLoadingMore = true;
      emit(PhotoLoadingMore(photos));
    } else {
      photos = [];
      emit(PhotoLoading());
    }
    try {
      final res = await api.getPhotos(
        context,
        queryParams: {
          "_page": "$currentPage",
          "_limit": "$limit",
        },
      );
      List<Photo> newPhotos = res.map<Photo>((e) => Photo.fromJson(e)).toList();

      if (isMore) {
        photos.addAll(newPhotos);
      } else {
        photos = newPhotos;
      }
      emit(PhotoLoaded(photos));
    } catch (e) {
      emit(PhotoError('Failed to fetch photos'));
    } finally {
      isLoadingMore = false;
    }
  }

  void getNextPage() {
    currentPage++;
    getPhotos();
  }

  void getPreviousPage() {
    if (currentPage > 1) {
      currentPage--;
      getPhotos();
    }
  }

  void sortPhotosByIdDescending() {
    emit(PhotoLoading());
    photos.sort((a, b) => b.id!.compareTo(a.id!));
        emit(PhotoLoaded(photos));
  }
  void filterPhotosByAlbumId(int albumId) {
    emit(PhotoLoading());

    final filteredPhotos = photos.where((photo) => photo.albumId == albumId).toList();
    emit(PhotoLoaded(filteredPhotos));
  }

}

abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class PhotoLoading extends HomeState {}

class PhotoLoaded extends HomeState {
  final List<Photo> photos;

  PhotoLoaded(this.photos);
  @override
  List<Object> get props => [photos];
}

class PhotoLoadingMore extends HomeState {
  final List<Photo> photos;
  PhotoLoadingMore(this.photos);
  @override
  List<Object> get props => [photos];
}

class PhotoError extends HomeState {
  final String message;
  PhotoError(this.message);
  @override
  List<Object> get props => [message];
}
