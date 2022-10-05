import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokemon_collector/globals/globals.dart';
import 'package:pokemon_collector/globals/helpers/size_config.dart';
import 'package:pokemon_collector/riverpod/is_loading/is_loading_notifier.dart';
import 'package:pokemon_collector/riverpod/is_loading/is_loading_provider.dart';
import 'package:pokemon_collector/riverpod/load_store/load_store_notifier.dart';
import 'package:pokemon_collector/riverpod/load_store/load_store_provider.dart';

class PageButtonWidget extends ConsumerWidget {
  final bool isRight;

  const PageButtonWidget({Key? key, this.isRight = false}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    LoadStoreNotifier loadStoreread = ref.read(loadStoreProvider.notifier);
    IsLoadingNotifier isLoadingRead = ref.read(isLoadingProvider.notifier);
    return Expanded(
      child: SizedBox(
        height: getProportionateScreenWidth(48),
        child: DecoratedBox(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          child: MaterialButton(
            onPressed: () async {
              if (isRight) {
                isLoadingRead.setState(true);
                await loadStoreread.nextPage();
                isLoadingRead.setState(false);
              } else {
                isLoadingRead.setState(true);
                await loadStoreread.previousPage();
                isLoadingRead.setState(false);
              }
            },
            color: mainColorLighten,
            child: Icon(
              isRight ? Icons.keyboard_arrow_right : Icons.keyboard_arrow_left,
              color: mainColor,
              size: getProportionateScreenWidth(28),
            ),
          ),
        ),
      ),
    );
  }
}
