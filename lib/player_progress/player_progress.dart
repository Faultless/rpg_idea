import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerProgress extends ChangeNotifier {
  PlayerProgress() {
    load();
  }

  static const _prefix = 'playerProgress_';
  static const _levelKey = '${_prefix}level';
  static const _strengthKey = '${_prefix}strength';
  static const _dexterityKey = '${_prefix}dexterity';
  static const _intelligenceKey = '${_prefix}intelligence';

  List _levels = [];
  int _level = 1;
  int _strength = 5;
  int _dexterity = 5;
  int _intelligence = 5;
  int highestLevelReached = 1;

  List get levels => _levels;
  int get level => _level;
  int get strength => _strength;
  int get dexterity => _dexterity;
  int get intelligence => _intelligence;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _level = prefs.getInt(_levelKey) ?? 1;
    _strength = prefs.getInt(_strengthKey) ?? 5;
    _dexterity = prefs.getInt(_dexterityKey) ?? 5;
    _intelligence = prefs.getInt(_intelligenceKey) ?? 5;
    highestLevelReached = prefs.getInt('${_prefix}highestLevelReached') ?? 1;
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_levelKey, _level);
    await prefs.setInt(_strengthKey, _strength);
    await prefs.setInt(_dexterityKey, _dexterity);
    await prefs.setInt(_intelligenceKey, _intelligence);
    await prefs.setInt('${_prefix}highestLevelReached', highestLevelReached);
  }

  void reset() {
    _level = 1;
    _strength = 5;
    _dexterity = 5;
    _intelligence = 5;
    highestLevelReached = 1;
  }

  void setLevelFinished(int number, int levelCompletedIn) {
    if (number > highestLevelReached) {
      highestLevelReached = number;
    }

    _levels[number - 1] = levelCompletedIn;
    notifyListeners();
  }

  void setStrength(int strength) {
    _strength = strength;
    notifyListeners();
  }

  void setDexterity(int dexterity) {
    _dexterity = dexterity;
    notifyListeners();
  }

  void setIntelligence(int intelligence) {
    _intelligence = intelligence;
    notifyListeners();
  }
}
