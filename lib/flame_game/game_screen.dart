import 'package:endless_runner/player_progress/inventory.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../level_selection/levels.dart';
import '../player_progress/player_progress.dart';
import 'endless_runner.dart';
import 'game_win_dialog.dart';
import 'game_inventory_dialog.dart';

/// This widget defines the properties of the game screen.
///
/// It mostly sets up the overlays (widgets shown on top of the Flame game) and
/// the gets the [AudioController] from the context and passes it in to the
/// [EndlessRunner] class so that it can play audio.
class GameScreen extends StatelessWidget {
  const GameScreen({required this.inventory, required this.level, super.key});

  final GameLevel level;
  final Inventory inventory;

  static const String winDialogKey = 'win_dialog';
  static const String backButtonKey = 'back_buttton';
  static const String inventoryKey = 'inventory';
  static const String invDialogKey = 'inv_dialog';

  @override
  Widget build(BuildContext context) {
    final audioController = context.read<AudioController>();
    return Scaffold(
      body: GameWidget<EndlessRunner>(
        key: const Key('play session'),
        game: EndlessRunner(
          inventory: inventory,
          level: level,
          playerProgress: context.read<PlayerProgress>(),
          audioController: audioController,
        ),
        overlayBuilderMap: {
          inventoryKey: (BuildContext context, EndlessRunner game) {
            return Positioned(
              bottom: 20,
              right: 10,
              child: NesButton(
                type: NesButtonType.normal,
                child: NesIcon(iconData: NesIcons.upperArmor),
                onPressed: () => game.overlays.add(invDialogKey),
              ),
            );
          },
          backButtonKey: (BuildContext context, EndlessRunner game) {
            return Positioned(
              top: 20,
              right: 10,
              child: NesButton(
                type: NesButtonType.normal,
                onPressed: GoRouter.of(context).pop,
                child: NesIcon(iconData: NesIcons.leftArrowIndicator),
              ),
            );
          },
          invDialogKey: (BuildContext context, EndlessRunner game) {
            return GameInventoryDialog(
              game: game,
            );
          },
          winDialogKey: (BuildContext context, EndlessRunner game) {
            return GameWinDialog(
              level: level,
              levelCompletedIn: game.world.levelCompletedIn,
            );
          },
        },
      ),
    );
  }
}
