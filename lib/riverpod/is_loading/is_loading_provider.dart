import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokemon_collector/riverpod/is_loading/is_loading_notifier.dart';

final StateNotifierProvider<IsLoadingNotifier, bool> isLoadingProvider =
    StateNotifierProvider<IsLoadingNotifier, bool>((ref) {
  return IsLoadingNotifier();
});
