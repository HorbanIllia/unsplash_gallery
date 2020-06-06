import 'package:unsplashgallery/models/urls.dart';
import 'package:unsplashgallery/models/user.dart';

class Photo {

  final String id;
  final String description;
  final Urls urls;
  final User user;

  Photo({this.id, this.description, this.urls, this.user,});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'] as String,
      description: json['description'] as String,
      urls: Urls.fromJson(json['urls']) as Urls,
      user: User.fromJson(json['user']) as User,
    );
  }
}