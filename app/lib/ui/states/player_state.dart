import 'package:flutter/widgets.dart';

import '../../model/songs/song.dart';

class PlayerState extends ChangeNotifier {
  Song? _currentSong;
  final Set<String> _favoriteSongIds = {};

  Song? get currentSong => _currentSong;
  Set<String> get favoriteSongIds => Set.unmodifiable(_favoriteSongIds);

  void start(Song song) {
    _currentSong = song;

    notifyListeners();
  }

  void stop() {
    _currentSong = null;

    notifyListeners();
  }

  bool isFavorite(Song song) => _favoriteSongIds.contains(song.id);

  void toggleFavorite(Song song) {
    if (_favoriteSongIds.contains(song.id)) {
      _favoriteSongIds.remove(song.id);
    } else {
      _favoriteSongIds.add(song.id);
    }

    notifyListeners();
  }
}
