//Περιγραφή εφαρμογής: Αυτή είναι μια εφαρμογή αναπαραγωγής μουσικής. Ο χρήστης μπορεί να ακούσει τα τραγούδια που έχει στην συσκευή του. Μπορεί να πατήσει το κουμπί play για να ακούσει το τραγούδι που είναι επιλεγμένο. Μπορεί να πατήσει το κουμπί pause για να σταματήσει το τραγούδι που παίζει.
//Θέλω να ενσωματώσω στην εφαρμογή dark theme και Light theme. Θα δημιουργήσω μια κλάση ThemeData όπου θα ορίζω τα χρώματα για το Light Theme και το Dark Theme. Μετά θα φτιάξω ένα ThemeProvider στην Main που ανάλογα τις ρυθμίσεις της συσκευής θα επιστρέφει το Light Theme ή το Dark Theme.

//Εδώ φτιάχνω την κλάση ThemeData

import 'package:flutter/material.dart';

class MyThemeData {
  //Δημιουργία μεταβλητών για τα χρώματα
  static Color _lightPrimary = Color.fromARGB(255, 255, 255, 255);
  static Color _lightOnPrimary = Color(0xff000000);
  static Color _lightBackground = Color.fromARGB(255, 243, 243, 243);
  static Color _lightOnBackground = Color(0xff000000);
  static Color _lightSurface = Color.fromARGB(255, 116, 94, 158);
  static Color _lightOnSurface = Color(0xff000000);
  static Color _lightError = Color(0xffb00020);
  static Color _lightOnError = Color(0xffffffff);

  static Color _darkPrimary = Color.fromARGB(255, 37, 37, 37);
  static Color _darkOnPrimary = Color(0xffffffff);
  static Color _darkBackground = Color.fromARGB(255, 0, 0, 0);
  static Color _darkOnBackground = Color(0xffffffff);
  static Color _darkSurface = Color.fromARGB(255, 53, 43, 72);
  static Color _darkOnSurface = Color(0xffffffff);
  static Color _darkError = Color(0xffcf6679);
  static Color _darkOnError = Color(0xffffffff);

  //Δημιουργία μεθόδου για το Light Theme
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: _lightBackground,
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: _lightPrimary,
      onPrimary: _lightOnPrimary,
      background: _lightBackground,
      onBackground: _lightOnBackground,
      surface: _lightSurface,
      onSurface: _lightOnSurface,
      error: _lightError,
      onError: _lightOnError,
    ),
  );

  //Δημιουργία μεθόδου για το Dark Theme
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: _darkBackground,
    colorScheme: ColorScheme.dark(
      primary: _darkPrimary,
      onPrimary: _darkOnPrimary,
      background: _darkBackground,
      onBackground: _darkOnBackground,
      surface: _darkSurface,
      onSurface: _darkOnSurface,
      error: _darkError,
      onError: _darkOnError,
    ),
  );
}

//ΟΔΗΓΟΣ ΧΡΗΣΗΣ ΧΡΩΜΑΤΩΝ
//Το primary είναι ένα χρώμα που χρησιμοποιείτε για το background της εφαρμογής
//Το onPrimary είναι ένα χρώμα που χρησιμοποιείτε για το κείμενο που βρίσκεται πάνω από το primary χρώμα
//Το background είναι ένα χρώμα που χρησιμοποιείτε για το background των widgets
//Το onBackground είναι ένα χρώμα που χρησιμοποιείτε για το κείμενο που βρίσκεται πάνω από το background χρώμα
//Το surface είναι ένα χρώμα που χρησιμοποιείτε για το background των widgets
//Το onSurface είναι ένα χρώμα που χρησιμοποιείτε για το κείμενο που βρίσκεται πάνω από το surface χρώμα
