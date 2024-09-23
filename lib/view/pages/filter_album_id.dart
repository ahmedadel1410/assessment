import 'package:assessment/view/styles/main_progress.dart';
import 'package:assessment/view_model/filter_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilteredPhotosPage extends StatelessWidget {
  final int albumId;

  const FilteredPhotosPage({super.key, required this.albumId});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Photos in Album $albumId'),
      ),
      body: BlocBuilder<FilterCubit, FilterState>(
        builder: (context, state) {
           if (state is Photofiltered) {
            final photos = state.photos
                .where((photo) => photo.albumId == albumId)
                .toList();

            return ListView.builder(
              itemCount: photos.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        imageUrl: photos[index].thumbnailUrl ?? "",
                        placeholder: (context, url) => const MainProgress(),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          photos[index].title ?? "",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
   else {
            return const MainProgress();
          }
        },
      ),
    );
  }
}
