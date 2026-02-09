import 'package:kathakaar/models/poem_model.dart';
import 'package:uuid/uuid.dart';

abstract class PoemRepository {
  Future<List<PoemModel>> getPoems();
  Future<PoemModel> getPoem(String id);
  Future<void> addPoem(PoemModel poem);
  Future<void> likePoem(String poemId, String userId);
  Future<void> unlikePoem(String poemId, String userId);
}

class MockPoemRepository implements PoemRepository {
  final List<PoemModel> _poems = [
    PoemModel(
      id: '1',
      authorId: 'mock_user_123',
      authorName: 'Kabir',
      content: 'Chalti Chakki Dekh Kar,\nDiya Kabira Roye\nDo Paatan Ke Beech Mein,\nSabut Bacha Na Koye',
      likes: 124,
      commentCount: 18,
      language: 'Hindi',
      tags: ['#spirituality', '#doha'],
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    PoemModel(
      id: '2',
      authorId: 'poet_2',
      authorName: 'Rumi',
      content: 'Out beyond ideas of wrongdoing and rightdoing,\nthere is a field. I’ll meet you there.\nWhen the soul lies down in that grass,\nthe world is too full to talk about.',
      likes: 89,
      commentCount: 12,
      language: 'English',
      tags: ['#love', '#soul'],
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    PoemModel(
      id: '3',
      authorId: 'poet_3',
      authorName: 'Mirza Ghalib',
      content: 'Ishq ne Ghalib nikamma kar diya\nWrna hum bhi aadmi thay kaam ke',
      likes: 245,
      commentCount: 42,
      language: 'Urdu',
      tags: ['#love', '#heartbreak'],
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ];

  @override
  Future<List<PoemModel>> getPoems() async {
    await Future.delayed(const Duration(milliseconds: 800)); // Simulate loading
    return _poems;
  }

  @override
  Future<PoemModel> getPoem(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _poems.firstWhere((p) => p.id == id);
  }

  @override
  Future<void> addPoem(PoemModel poem) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _poems.insert(0, poem);
  }

  @override
  Future<void> likePoem(String poemId, String userId) async {
    // In a real app, we'd update the likes count and add user to likedBy list
    // Here we just toggle for UI demo
    final index = _poems.indexWhere((p) => p.id == poemId);
    if (index != -1) {
      final poem = _poems[index];
      if (!poem.isLikedByMe) {
        _poems[index] = poem.copyWith(
          likes: poem.likes + 1,
          isLikedByMe: true,
        );
      }
    }
  }

  @override
  Future<void> unlikePoem(String poemId, String userId) async {
    final index = _poems.indexWhere((p) => p.id == poemId);
    if (index != -1) {
       final poem = _poems[index];
       if (poem.isLikedByMe) {
          _poems[index] = poem.copyWith(
            likes: poem.likes - 1,
            isLikedByMe: false,
          );
       }
    }
  }
}
