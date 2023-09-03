import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'main.dart';

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final settingsOpened = ref.watch(settingsState);
        return settingsOpened
            ? AnimatedContainer(
                duration: Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Column(
                  children: [
                    Text(
                      "Ρυθμίσεις",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 60),
                    DarkThemeSwitcher(context),
                  ],
                ),
              )
            : Center(
                child: Text(
                  "Μουσική",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 20,
                  ),
                ),
              );
      },
    );
  }

  //widget for
  Widget DarkThemeSwitcher(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final darkstate = ref.watch(darkStateProvider);
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Σκοτεινό θέμα",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 16,
              ),
            ),
            Switch(
              value: darkstate,
              onChanged: (value) {
                ref.read(darkStateProvider.notifier).state = value;
              },
              activeColor: Theme.of(context).colorScheme.primary,
              activeTrackColor: Theme.of(context).colorScheme.error,
              inactiveThumbColor: Color.fromARGB(255, 89, 89, 89),
              inactiveTrackColor: Color.fromARGB(255, 231, 225, 243),
            ),
          ],
        );
      },
    );
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
