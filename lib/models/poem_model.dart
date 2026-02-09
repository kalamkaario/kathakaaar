class PoemModel {
  final String id;
  final String authorId;
  final String authorName;
  final String? title;
  final String content; // Storing as single string for simplicity, or List<String>
  final int likes;
  final int commentCount;
  final String language;
  final List<String> tags;
  final DateTime createdAt;
  final bool isLikedByMe; // Helper for UI state

  PoemModel({
    required this.id,
    required this.authorId,
    required this.authorName,
    this.title,
    required this.content,
    this.likes = 0,
    this.commentCount = 0,
    required this.language,
    this.tags = const [],
    required this.createdAt,
    this.isLikedByMe = false,
  });

  PoemModel copyWith({
    String? id,
    String? authorId,
    String? authorName,
    String? title,
    String? content,
    int? likes,
    int? commentCount,
    String? language,
    List<String>? tags,
    DateTime? createdAt,
    bool? isLikedByMe,
  }) {
    return PoemModel(
      id: id ?? this.id,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      title: title ?? this.title,
      content: content ?? this.content,
      likes: likes ?? this.likes,
      commentCount: commentCount ?? this.commentCount,
      language: language ?? this.language,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      isLikedByMe: isLikedByMe ?? this.isLikedByMe,
    );
  }
}
