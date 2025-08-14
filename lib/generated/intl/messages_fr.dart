// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'fr';

  static String m0(temperature) => "Ressenti ${temperature}°C";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "arabic": MessageLookupByLibrary.simpleMessage("عربية"),
    "cancel": MessageLookupByLibrary.simpleMessage("Annuler"),
    "clearSky": MessageLookupByLibrary.simpleMessage("CIEL DÉGAGÉ"),
    "english": MessageLookupByLibrary.simpleMessage("English"),
    "enterCityName": MessageLookupByLibrary.simpleMessage(
      "Entrez le nom de la ville...",
    ),
    "feelsLike": m0,
    "french": MessageLookupByLibrary.simpleMessage("Français"),
    "gettingWeatherData": MessageLookupByLibrary.simpleMessage(
      "Récupération des données météo...",
    ),
    "humidity": MessageLookupByLibrary.simpleMessage("Humidité"),
    "maxTemp": MessageLookupByLibrary.simpleMessage("Temp. Max"),
    "minTemp": MessageLookupByLibrary.simpleMessage("Temp. Min"),
    "oops": MessageLookupByLibrary.simpleMessage("Oups!"),
    "search": MessageLookupByLibrary.simpleMessage("Rechercher"),
    "searchCity": MessageLookupByLibrary.simpleMessage("Rechercher une ville"),
    "sunrise": MessageLookupByLibrary.simpleMessage("Lever du soleil"),
    "sunset": MessageLookupByLibrary.simpleMessage("Coucher du soleil"),
    "today": MessageLookupByLibrary.simpleMessage("Aujourd\'hui"),
    "tryAgain": MessageLookupByLibrary.simpleMessage("Réessayer"),
    "weather": MessageLookupByLibrary.simpleMessage("Météo"),
    "windSpeed": MessageLookupByLibrary.simpleMessage("Vitesse du vent"),
  };
}
