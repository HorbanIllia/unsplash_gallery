class Urls{
  final String raw;
  final String full;
  final String regular;
  final String small;
  final String thumb;

  Urls({
    this.raw,
    this.full,
    this.regular,
    this.small,
    this.thumb
  });

  factory Urls.fromJson(Map<String, dynamic> json) => Urls(
    raw: json['raw'] as String,
    full: json['full'] as String,
    regular: json['regular'] as String,
    small: json['small'] as String,
    thumb: json['thumb'] as String,);
}