class User{
  final String id;
  final String username;
  final String name;

  User({
    this.id,
    this.username,
    this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'] as String,
    username: json['username'] as String,
    name: json['name'] as String,);
}