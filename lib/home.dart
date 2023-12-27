import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicgnk/main.dart';
import 'package:musicgnk/screen.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final theme = ref.watch(themeProvider);
    final settingsOpened = ref.watch(settingsState);
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 460),
        margin: const EdgeInsets.all(0),
        padding: settingsOpened
            ? const EdgeInsets.fromLTRB(0, 30, 0, 0)
            : const EdgeInsets.fromLTRB(10, 30, 10, 10),
        child: Column(
          children: [Screen()],
        ),
      ),
    );
  }
}
