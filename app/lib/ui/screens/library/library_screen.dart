import 'package:app/data/repositories/songs/song_repository.dart';
import 'package:app/ui/screens/library/library_content.dart';
import 'package:app/ui/screens/library/model/library_view_model.dart';
import 'package:app/ui/states/player_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final songRepository = context.read<SongRepository>();
    final playerState = context.read<PlayerState>();

    return ChangeNotifierProvider<LibraryViewModel>(
      create: (_) {
        final viewModel = LibraryViewModel(
          songRepository: songRepository,
          playerState: playerState,
        );
        viewModel.init();
        return viewModel;
      },
      child: const LibraryContent(),
    );
  }
}