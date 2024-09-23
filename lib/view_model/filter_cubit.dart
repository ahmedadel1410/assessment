import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/models/photo.dart';
import '../model/services/provider/provider_setup.dart';

class FilterCubit extends Cubit<FilterState> {
  final BuildContext context;
  List<Photo> allPhotos = [];


  FilterCubit({required this.context}) : super(FilterInitial()) {
    getAllPhotos();
  }
  getAllPhotos() async {
    final res = await api.getPhotos(
      context, queryParams: {},
    );
    for (var e in res){
      Photo photo=Photo.fromJson(e);
      allPhotos.add(photo);
    }
    emit(Photofiltered(allPhotos));

  }
}
abstract class FilterState extends Equatable {
  @override
  List<Object> get props => [];
}
class FilterInitial extends FilterState {}

class Photofiltered extends FilterState {
  final List<Photo> photos;

  Photofiltered(this.photos);
  @override
  List<Object> get props => [photos];
}
