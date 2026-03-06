import 'package:app/data/repositories/songs/song_repository.dart';
import 'package:app/model/songs/song.dart';
import 'package:app/ui/states/player_state.dart';
import 'package:flutter/foundation.dart';


class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final PlayerState playerState;

  List<Song> _songs = [];
  bool _initialized = false;
  LibraryViewModel({required this.songRepository, required this.playerState});

  List<Song> get songs => _songs;
  Song? get currentSong => playerState.currentSong;

  void init() {
    if (_initialized) return;
    _songs = songRepository.fetchSongs();

    _initialized = true;
    notifyListeners();
  }

  bool isPlaying(Song song) {
    return currentSong?.id == song.id;
  }

  void onSongTap(Song song) {
    if (isPlaying(song)) {
      playerState.stop();
      return;
    }

    playerState.start(song);
  }
}