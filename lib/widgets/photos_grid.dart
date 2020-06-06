import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:unsplashgallery/api.dart';
import 'package:unsplashgallery/models/photo.dart';
import 'package:unsplashgallery/pages/photo_page.dart';

class PhotosGrid extends StatefulWidget {

  final List<Photo> photos;
  int page;

  PhotosGrid({Key key, this.photos, this.page}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PhotosGridState();
}

class PhotosGridState extends State<PhotosGrid> {

  PhotoLoadMoreStatus loadMoreStatus = PhotoLoadMoreStatus.STABLE;
  final ScrollController scrollController = new ScrollController();
  List<Photo> photos;
  int currentPageNumber;
  CancelableOperation photoOperation;

  @override
  void initState() {
    super.initState();

    photos = widget.photos;
    currentPageNumber = widget.page;

  }
  @override
  void dispose() {
    scrollController.dispose();
    if(photoOperation != null) photoOperation.cancel();
    super.dispose();
  }

  bool onNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (scrollController.position.maxScrollExtent > scrollController.offset &&
          scrollController.position.maxScrollExtent - scrollController.offset <=
              50) {
        if (loadMoreStatus != null &&
            loadMoreStatus == PhotoLoadMoreStatus.STABLE) {
          loadMoreStatus = PhotoLoadMoreStatus.LOADING;

          photoOperation = CancelableOperation.fromFuture(PhotoAPI().fetchPhotos(currentPageNumber+1)
              .then((moviesObject) {
            currentPageNumber = currentPageNumber + 1;
            loadMoreStatus = PhotoLoadMoreStatus.STABLE;
            setState(() => photos.addAll(moviesObject));
          }));
        }
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {

    return NotificationListener(
      onNotification: onNotification,
      child: new GridView.builder(
        padding: EdgeInsets.all(5),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 5.0,
        ),
        controller: scrollController,
        itemCount: photos.length,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailPage(url: photos[index].urls.full,)),
              );
            },
            child: GridTile(
              footer: Material(
                color: Colors.transparent,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(4)),
                ),
                clipBehavior: Clip.antiAlias,
                child: GridTileBar(
                  backgroundColor: Colors.black45,
                  title: _GridTitleText(photos[index].user.name),
                  subtitle: photos[index].description!=null ? _GridTitleText(photos[index].description):_GridTitleText(""),
                ),
              ),
              child: Material(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  photos[index].urls.thumb,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),  // GridView.builder
    );
  }
}

enum PhotoLoadMoreStatus { LOADING, STABLE }

class _GridTitleText extends StatelessWidget {
  const _GridTitleText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {

    return Flexible(
      child: Container(
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}