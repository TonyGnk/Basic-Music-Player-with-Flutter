import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:musicgnk/home.dart';
import 'package:musicgnk/theme_data.dart';

class AdaptiveRoot extends StatefulWidget {
  const AdaptiveRoot({
    required this.appTitle,
    this.savedThemeMode,
    super.key,
    this.debugShowFloatingThemeButton = false,
  });

  final String appTitle;
  final AdaptiveThemeMode? savedThemeMode;
  final bool debugShowFloatingThemeButton;

  @override
  State<AdaptiveRoot> createState() => _AdaptiveRootState();
}

class _AdaptiveRootState extends State<AdaptiveRoot> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => rootConfig(
        context,
        widget.savedThemeMode,
        widget.appTitle,
        widget.debugShowFloatingThemeButton,
      );
}

Widget rootConfig(
  BuildContext context,
  AdaptiveThemeMode? savedThemeMode,
  String appTitle,
  bool debugShowFloatingThemeButton,
) =>
    AdaptiveTheme(
      light: MaterialThemeData().light(),
      dark: MaterialThemeData().dark(),
      debugShowFloatingThemeButton: debugShowFloatingThemeButton,
      initial: savedThemeMode ?? AdaptiveThemeMode.system,
      builder: (theme, darkTheme) => MaterialApp(
          onGenerateTitle: (context) => appTitle,
          theme: theme,
          darkTheme: darkTheme,
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: theme.colorScheme.background,
            body: const MyApp(),
          )),
    );
