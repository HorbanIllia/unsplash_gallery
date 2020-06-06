import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';


class DetailPage extends StatelessWidget {

  final String url;

  DetailPage({Key key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(child: CircularProgressIndicator()),
          Center(
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: url,
            ),
          ),
        ],
      ),
    );
  }
}