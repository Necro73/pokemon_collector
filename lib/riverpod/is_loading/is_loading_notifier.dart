import 'package:hooks_riverpod/hooks_riverpod.dart';

class IsLoadingNotifier extends StateNotifier<bool> {
  IsLoadingNotifier() : super(false);

  setState(bool value) {
    if (state != value) {
      state = value;
    }
  }
}
