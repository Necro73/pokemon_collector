import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AnimationNotifier extends StateNotifier<AnimationController?> {
  AnimationNotifier() : super(null);

  void setState(AnimationController value) {
    if (state != value) {
      state = value;
    }
  }
}