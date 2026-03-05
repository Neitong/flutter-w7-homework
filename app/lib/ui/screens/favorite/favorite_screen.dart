import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/songs/song_repository.dart';
import '../../../model/songs/song.dart';
import '../../states/player_state.dart';
import '../../states/settings_state.dart';
import '../../theme/theme.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1- Read the globbal song repository
    SongRepository songRepository = context.read<SongRepository>();
    PlayerState playerState = context.watch<PlayerState>();
    List<Song> songs = songRepository
        .fetchSongs()
        .where((song) => playerState.favoriteSongIds.contains(song.id))
        .toList();

    AppSettingsState settingsState = context.watch<AppSettingsState>();

    // 3 - Watch the globbal player state
    // PlayerState playerState = context.read<PlayerState>();

    return Container(
      color: settingsState.theme.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text(
            "Favorite",
            style: AppTextStyles.heading,
          ),

          SizedBox(height: 50),

          Expanded(
            child: songs.isEmpty
                ? Center(
                    child: Text(
                      "No favorite songs yet",
                      style: AppTextStyles.label,
                    ),
                  )
                : ListView.builder(
                    itemCount: songs.length,
                    itemBuilder: (context, index) => SongTile(
                      song: songs[index],
                      isPlaying: playerState.currentSong == songs[index],
                      onTap: () {
                        playerState.start(songs[index]);
                      },
                      onUnfavoriteTap: () {
                        playerState.toggleFavorite(songs[index]);
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.song,
    required this.isPlaying,
    required this.onTap,
    required this.onUnfavoriteTap,
  });

  final Song song;
  final bool isPlaying;
  final VoidCallback onTap;
  final VoidCallback onUnfavoriteTap;


  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(song.title),
      subtitle: Text(song.artist),
      leading: IconButton(
        onPressed: onUnfavoriteTap,
        icon: const Icon(
          Icons.favorite,
          color: Colors.red,
        ),
      ),
      trailing: Text(
        isPlaying ? "Playing" : "",
        style: TextStyle(color: Colors.amber),
      ),
    );
  }
}
