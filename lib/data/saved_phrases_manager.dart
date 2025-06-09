import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SavedPhrasesManager extends ChangeNotifier {
  final Box _box = Hive.box('mybox');
  List<String> _phrases = [];

  SavedPhrasesManager() {
    _loadPhrases(); // تحميل العبارات عند التهيئة
  }

  List<String> get phrases => _phrases;

  void _loadPhrases() {
    final storedPhrases = _box.get('phrases');
    if (storedPhrases != null && storedPhrases is List) {
      _phrases = List<String>.from(storedPhrases);
    } else {
      _phrases = ["بندورة", "فلفل", "بتنجان", "الاتصال بالأهل"];
      _savePhrases(); // حفظها كافتراضية أول مرة
    }
    notifyListeners();
  }

  void _savePhrases() {
    _box.put('phrases', _phrases);
  }

  void addPhrase(String phrase) {
    if (!_phrases.contains(phrase) && phrase.isNotEmpty) {
      _phrases.add(phrase);
      _savePhrases();
      notifyListeners();
    }
  }

  void removePhrase(String phrase) {
    _phrases.remove(phrase);
    _savePhrases();
    notifyListeners();
  }
}
