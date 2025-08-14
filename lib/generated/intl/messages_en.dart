// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(temperature) => "Feels like ${temperature} °C";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "arabic": MessageLookupByLibrary.simpleMessage("عربية"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "clearSky": MessageLookupByLibrary.simpleMessage("CLEAR SKY"),
    "english": MessageLookupByLibrary.simpleMessage("English"),
    "enterCityName": MessageLookupByLibrary.simpleMessage("Enter city name..."),
    "feelsLike": m0,
    "french": MessageLookupByLibrary.simpleMessage("Français"),
    "gettingWeatherData": MessageLookupByLibrary.simpleMessage(
      "Getting weather data...",
    ),
    "humidity": MessageLookupByLibrary.simpleMessage("Humidity"),
    "maxTemp": MessageLookupByLibrary.simpleMessage("Max Temp"),
    "minTemp": MessageLookupByLibrary.simpleMessage("Min Temp"),
    "oops": MessageLookupByLibrary.simpleMessage("Oops!"),
    "search": MessageLookupByLibrary.simpleMessage("Search"),
    "searchCity": MessageLookupByLibrary.simpleMessage("Search City"),
    "sunrise": MessageLookupByLibrary.simpleMessage("Sunrise"),
    "sunset": MessageLookupByLibrary.simpleMessage("Sunset"),
    "today": MessageLookupByLibrary.simpleMessage("Today"),
    "tryAgain": MessageLookupByLibrary.simpleMessage("Try Again"),
    "weather": MessageLookupByLibrary.simpleMessage("Weather"),
    "windSpeed": MessageLookupByLibrary.simpleMessage("Wind Speed"),
  };
}
