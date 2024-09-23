import 'package:assessment/view/styles/main_progress.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view_model/home_vm.dart';
import 'filter_album_id.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    final TextEditingController albumIdController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo List'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Sort by ID (Descending)') {
                homeCubit.sortPhotosByIdDescending();
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Sort by ID (Descending)'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is PhotoLoading) {
            return const MainProgress();
          } else if (state is PhotoLoaded || state is PhotoLoadingMore) {
            final photos = (state is PhotoLoaded)
                ? state.photos
                : (state as PhotoLoadingMore).photos;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: albumIdController,
                          decoration: const InputDecoration(
                            labelText: 'Filter by Album ID',
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.filter_list),
                        onPressed: () {
                          if (albumIdController.text.isNotEmpty) {
                            int albumId = int.parse(albumIdController.text);
                       Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>FilteredPhotosPage(albumId: albumId,)));
                          }
                        },
                      ),


                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: photos.length + (homeCubit.isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == photos.length) {
                        return const MainProgress(); // Show loading indicator at the bottom
                      }
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
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('Album ID: ${photos[index].albumId}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('ID: ${photos[index].id}'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                if (!homeCubit.isLoadingMore)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: homeCubit.currentPage > 1
                              ? () {
                            homeCubit.getPreviousPage();
                          }
                              : null,
                          child: const Text('Previous'),
                        ),
                        ElevatedButton(
                          onPressed: photos.length == homeCubit.limit
                              ? () {
                            homeCubit.getNextPage();
                          }
                              : null,
                          child: const Text('Next'),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          } else if (state is PhotoError) {
            return Center(child: Text(state.message));
          } else {
            return const MainProgress(); // Show loading indicator
          }
        },
      ),
    );
  }
}
