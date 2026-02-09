class UserModel {
  final String id;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final String? bio;
  final List<String> languages;
  final int followersCount;
  final int followingCount;

  UserModel({
    required this.id,
    required this.email,
    this.displayName,
    this.photoUrl,
    this.bio,
    this.languages = const [],
    this.followersCount = 0,
    this.followingCount = 0,
  });

  UserModel copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photoUrl,
    String? bio,
    List<String>? languages,
    int? followersCount,
    int? followingCount,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      bio: bio ?? this.bio,
      languages: languages ?? this.languages,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
    );
  }
}
