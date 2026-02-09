import 'package:flutter/material.dart';
import 'package:kathakaar/models/poem_model.dart';
import 'package:kathakaar/repositories/poem_repository.dart';

class PoemProvider with ChangeNotifier {
  final PoemRepository _poemRepository;
  List<PoemModel> _poems = [];
  bool _isLoading = false;

  PoemProvider(this._poemRepository);

  List<PoemModel> get poems => _poems;
  bool get isLoading => _isLoading;

  Future<void> fetchPoems() async {
    _isLoading = true;
    notifyListeners();
    try {
      _poems = await _poemRepository.getPoems();
    } catch (e) {
      debugPrint('Error fetching poems: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addPoem(PoemModel poem) async {
    try {
      await _poemRepository.addPoem(poem);
      // Optimistically add to list or refetch
      _poems.insert(0, poem);
      notifyListeners();
    } catch (e) {
      debugPrint('Error adding poem: $e');
      rethrow;
    }
  }

  Future<void> toggleLike(String poemId, String userId) async {
    final index = _poems.indexWhere((p) => p.id == poemId);
    if (index == -1) return;

    final poem = _poems[index];
    final originalPoem = poem;

    // Optimistic update
    if (poem.isLikedByMe) {
      _poems[index] = poem.copyWith(likes: poem.likes - 1, isLikedByMe: false);
    } else {
      _poems[index] = poem.copyWith(likes: poem.likes + 1, isLikedByMe: true);
    }
    notifyListeners();

    try {
      if (originalPoem.isLikedByMe) {
        await _poemRepository.unlikePoem(poemId, userId);
      } else {
        await _poemRepository.likePoem(poemId, userId);
      }
    } catch (e) {
      // Revert if error
      _poems[index] = originalPoem;
      notifyListeners();
      debugPrint('Error toggling like: $e');
    }
  }
}
