import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokemon_collector/globals/globals.dart';
import 'package:pokemon_collector/globals/helpers/size_config.dart';
import 'package:pokemon_collector/riverpod/animation/animation_provider.dart';
import 'package:pokemon_collector/riverpod/is_loading/is_loading_provider.dart';
import 'package:pokemon_collector/screens/menu/components/button_screen_basket_widget.dart';
import 'package:pokemon_collector/screens/menu/components/button_screen_store_widget.dart';

class MenuScreen extends ConsumerStatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends ConsumerState<MenuScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    AnimationController controller;
    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    ref.read(animationProvider.notifier).setState(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: mainColor,
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: getProportionateScreenWidth(100),
                right: getProportionateScreenWidth(16),
                left: getProportionateScreenWidth(16),
              ),
              child: Column(
                children: [
                  const ButtonScreenStoreWidget(isRightMove: true),
                  SizedBox(height: getProportionateScreenWidth(8)),
                  const ButtonScreenBasketWidget(),
                ],
              ),
            ),
            (ref.watch(isLoadingProvider.select((value) => value)))
                ? const Center(child: CircularProgressIndicator())
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
