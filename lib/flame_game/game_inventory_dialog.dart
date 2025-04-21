import 'package:endless_runner/flame_game/endless_runner.dart';
import 'package:endless_runner/player_progress/inventory.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:provider/provider.dart';

import '../style/palette.dart';

/// This dialog is shown when the inventory is opened.
class GameInventoryDialog extends StatelessWidget {
  const GameInventoryDialog({super.key, required this.game});
  final EndlessRunner game;

  @override
  Widget build(BuildContext context) {
    final palette = context.read<Palette>();
    return Center(
      child: AlertDialog(
        content: NesContainer(
          width: 420,
          height: 300,
          padding: const EdgeInsets.all(8.0),
          backgroundColor: palette.backgroundPlaySession.color,
          child: Column(
            children: [
              Text(
                'Inventory',
                style: TextStyle(
                  fontFamily: GoogleFonts.pressStart2p().fontFamily,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Consumer<Inventory>(
                  builder: (context, inventory, _) => ListView.builder(
                  itemCount: inventory.items.length,
                  itemBuilder: (context, index) => ListTile(
                    leading: Image.asset('assets/images/potion.png'),
                    title: Text('Potion ${index + 1}'),
                    trailing: NesButton(
                        onPressed: () =>
                            inventory.use(inventory.items[index]),
                        type: NesButtonType.normal,
                        child: const Icon(Icons.delete),
                      )
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
