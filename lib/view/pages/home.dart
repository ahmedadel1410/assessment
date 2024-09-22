import 'package:assessment/view/styles/main_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view_model/home_vm.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Photo List')),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is PhotoLoading ) {
            return const MainProgress();
          } else if (state is PhotoLoaded || state is PhotoLoadingMore) {
            final photos = (state is PhotoLoaded)
                ? state.photos
                : (state as PhotoLoadingMore).photos;
            return NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent &&
                    !homeCubit.isLoadingMore) {
                  homeCubit.getPhotos(isMore: true); // Load more photos when reaching the bottom
                }
                return false;
              },
              child: ListView.builder(
                controller: homeCubit.scrollController,
                itemCount: photos.length + (homeCubit.isLoadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == photos.length) {
                    return const MainProgress(); // Show loading indicator at the bottom
                  }
                  return ListTile(
                    title: Text(photos[index].title ?? ""),
                    subtitle: Image.network(photos[index].thumbnailUrl ?? ""),
                    leading: Text(photos[index].id.toString()),
                  );
                },
              ),
            );
          } else if (state is PhotoError) {
            return Center(child: Text(state.message));
          } else {
            return MainProgress(); // Show loading indicator
          }
        },
      ),
    );
  }
}
