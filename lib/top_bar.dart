import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final settingsOpened = ref.watch(settingsState);
        return settingsOpened
            ? AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Column(
                  children: [
                    Text(
                      "Settings",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 60),
                    darkThemeSwitcher(context),
                  ],
                ),
              )
            : Center(
                child: Text(
                  "Music",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 20,
                  ),
                ),
              );
      },
    );
  }

  Widget darkThemeSwitcher(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final darkState = ref.watch(darkStateProvider);
        final pref = ref.watch(prefs);
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Dark Theme",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 16,
              ),
            ),
            Switch(
              value: darkState,
              onChanged: (value) {
                ref.read(darkStateProvider.notifier).state = value;
                _saveDarkThemePreference(value, pref);
              },
              activeColor: Theme.of(context).colorScheme.primary,
              activeTrackColor: Theme.of(context).colorScheme.error,
              inactiveThumbColor: const Color.fromARGB(255, 89, 89, 89),
              inactiveTrackColor: const Color.fromARGB(255, 225, 232, 243),
            ),
          ],
        );
      },
    );
  }

  void _saveDarkThemePreference(
      bool value, AsyncValue<SharedPreferences> pref) {
    if (pref is AsyncData<SharedPreferences>) {
      pref.value.setBool('darkMode', value);
    }
  }
}




// Expanded(
//               child: Container(
//                 width: 150,
//                 height: 40,
//                 alignment: Alignment.centerRight,
//                 child: CustomIconButton(
//                   onPressed: () {
//                     AppSettings.openAppSettings();
//                   },
//                   icon: SvgPicture.asset('assets/info.svg'),
//                 ),
//               ),
