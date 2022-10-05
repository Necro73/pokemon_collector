import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokemon_collector/globals/globals.dart';
import 'package:pokemon_collector/globals/helpers/size_config.dart';
import 'package:pokemon_collector/riverpod/animation/animation_provider.dart';
import 'package:pokemon_collector/riverpod/is_loading/is_loading_provider.dart';
import 'package:pokemon_collector/riverpod/load_store/load_store_provider.dart';
import 'package:pokemon_collector/screens/store/store_screen.dart';

class ButtonScreenStoreWidget extends ConsumerStatefulWidget {
  final bool isRightMove;

  const ButtonScreenStoreWidget({Key? key, this.isRightMove = false}) : super(key: key);

  @override
  ConsumerState<ButtonScreenStoreWidget> createState() => _ButtonScreensWidgetState();
}

class _ButtonScreensWidgetState extends ConsumerState<ButtonScreenStoreWidget> with SingleTickerProviderStateMixin {
  late Animation<Offset> _myAnimation;

  @override
  void initState() {
    super.initState();
    AnimationController controller;
    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _myAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(widget.isRightMove ? 1.5 : -1.5, 0.0),
    ).animate(CurvedAnimation(
      parent: ref.read(animationProvider.notifier).state ?? controller,
      curve: Curves.linear,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _myAnimation,
      child: SizedBox(
        width: double.infinity,
        height: getProportionateScreenWidth(50),
        child: DecoratedBox(
          decoration: BoxDecoration(color: mainColorLighten),
          child: MaterialButton(
            onPressed: () async {
              ref.read(animationProvider.notifier).state?.animateTo(1);
              ref.read(isLoadingProvider.notifier).setState(true);
              await ref.read(loadStoreProvider.notifier).loadDataPokemonList();
              ref.read(isLoadingProvider.notifier).setState(false);
              await Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return StoreScreen();
                  },
                  transitionDuration: const Duration(milliseconds: 500),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation.drive(
                        Tween(begin: 0.0, end: 1.0).chain(
                          CurveTween(curve: Curves.easeInExpo), //Curves.easeOutCubic
                        ),
                      ),
                      child: child,
                    );
                  }));
              ref.read(animationProvider.notifier).state?.value = 0;
            },
            child: const Text('Магазин покемонов'),
          ),
        ),
      ),
    );
  }
}
