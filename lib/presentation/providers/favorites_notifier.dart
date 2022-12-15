import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../commons/preference_utils.dart';

class FavoritesNotifier extends ChangeNotifier {
  List<String> favorites = [];

  FavoritesNotifier() {
    _starSettings();
  }
  
  _starSettings() async {
    await _readFavorites();
  }
  
  _readFavorites() async {
    favorites = await PreferenceUtils.getListString('favorites');
    notifyListeners();
  }

  addFavoriteId(String id) async {
    favorites.add(id);
    PreferenceUtils.setStringList('favorites', favorites);
    notifyListeners();
  }

  removeFavoriteId(String id) async {
    favorites.remove(id);
    PreferenceUtils.setStringList('favorites', favorites);
    notifyListeners();
  }
}

final favoritesProvider = ChangeNotifierProvider<FavoritesNotifier>((ref) {
  return FavoritesNotifier();
});