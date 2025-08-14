// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
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
  String get localeName => 'ar';

  static String m0(temperature) => "يبدو كـ ${temperature}°م";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "arabic": MessageLookupByLibrary.simpleMessage("عربية"),
    "cancel": MessageLookupByLibrary.simpleMessage("إلغاء"),
    "clearSky": MessageLookupByLibrary.simpleMessage("سماء صافية"),
    "english": MessageLookupByLibrary.simpleMessage("English"),
    "enterCityName": MessageLookupByLibrary.simpleMessage(
      "أدخل اسم المدينة...",
    ),
    "feelsLike": m0,
    "french": MessageLookupByLibrary.simpleMessage("Français"),
    "gettingWeatherData": MessageLookupByLibrary.simpleMessage(
      "جاري الحصول على بيانات الطقس...",
    ),
    "humidity": MessageLookupByLibrary.simpleMessage("الرطوبة"),
    "maxTemp": MessageLookupByLibrary.simpleMessage("أقصى حرارة"),
    "minTemp": MessageLookupByLibrary.simpleMessage("أدنى حرارة"),
    "oops": MessageLookupByLibrary.simpleMessage("عذراً!"),
    "search": MessageLookupByLibrary.simpleMessage("بحث"),
    "searchCity": MessageLookupByLibrary.simpleMessage("البحث عن مدينة"),
    "sunrise": MessageLookupByLibrary.simpleMessage("شروق الشمس"),
    "sunset": MessageLookupByLibrary.simpleMessage("غروب الشمس"),
    "today": MessageLookupByLibrary.simpleMessage("اليوم"),
    "tryAgain": MessageLookupByLibrary.simpleMessage("حاول مرة أخرى"),
    "weather": MessageLookupByLibrary.simpleMessage("الطقس"),
    "windSpeed": MessageLookupByLibrary.simpleMessage("سرعة الرياح"),
  };
}
