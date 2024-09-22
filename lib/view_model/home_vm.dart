import 'package:assessment/model/models/photo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../model/services/provider/provider_setup.dart';

class HomeCubit extends Cubit<HomeState> {
  final BuildContext context;
  List<Photo> photos = [];
  ScrollController scrollController = ScrollController();
  int start = 0;
  int limit = 10;
  bool isLoadingMore = false;

  HomeCubit({required this.context}) : super(HomeInitial()) {
    scrollController.addListener(_onScroll);
    getPhotos(); // Load initial photos
  }

  Future<void> getPhotos({bool isMore = false}) async {
    if (isMore) {
      isLoadingMore = true;
      emit(PhotoLoadingMore(photos));  // Emit a specific loading state for loading more data
    } else {
      photos = [];
      emit(PhotoLoading());
    }
    try {
      final res = await api.getPhotos(
        context,
        queryParams: {
          "_start": "$start",
          "_limit": "$limit",
        },
      );
      List<Photo> newPhotos = res.map<Photo>((e) => Photo.fromJson(e)).toList();
      if (isMore) {
        photos.addAll(newPhotos);
      } else {
        photos = newPhotos;
      }
      start += limit;
      emit(PhotoLoaded(photos));
    } catch (e) {
      emit(PhotoError('Failed to fetch photos'));
    } finally {
      isLoadingMore = false;
    }
  }

  void _onScroll() {
    if (scrollController.position.extentAfter < 200) {
      if (!isLoadingMore) {
        getPhotos(isMore: true);
      }
    }
  }

  @override
  Future<void> close() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    return super.close();
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
