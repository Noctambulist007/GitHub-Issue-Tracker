class User {
  final int id;
  final String url;
  final String? login;
  final String? name;
  final String? bio;
  final String? avatarUrl;
  final int? publicRepos;
  final int? publicGists;
  final int? totalPrivateRepos;

  User({
    required this.id,
    required this.url,
    this.login,
    this.name,
    this.bio,
    this.avatarUrl,
    this.publicRepos,
    this.publicGists,
    this.totalPrivateRepos,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      url: json['html_url'],
      login: json['login'] as String?,
      name: json['name'] as String?,
      bio: json['bio'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      publicRepos: json['public_repos'] as int?,
      publicGists: json['public_gists'] as int?,
      totalPrivateRepos: json['total_private_repos'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'html_url': url,
      'login': login,
      'name': name,
      'bio': bio,
      'avatar_url': avatarUrl,
      'public_repos': publicRepos,
      'public_gists': publicGists,
      'total_private_repos': totalPrivateRepos,
    };
  }
}
