import 'package:flutter/material.dart';
import 'package:unsplashgallery/api.dart';
import 'package:unsplashgallery/models/photo.dart';
import 'package:unsplashgallery/widgets/photos_grid.dart';

class MainPage extends StatelessWidget {

  final String title;

  MainPage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Photo>>(
        future: PhotoAPI().fetchPhotos(1),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          debugPrint("snap="+snapshot.data.toString());
          return snapshot.hasData
              ? PhotosGrid(photos: snapshot.data,page: 1,)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}