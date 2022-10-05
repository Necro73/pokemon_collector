import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokemon_collector/riverpod/animation/animation_notifier.dart';

final StateNotifierProvider<AnimationNotifier, AnimationController?> animationProvider =
    StateNotifierProvider<AnimationNotifier, AnimationController?>((ref) {
  return AnimationNotifier();
});
