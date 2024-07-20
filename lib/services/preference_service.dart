import 'package:hive/hive.dart';
import 'package:news/utils/subtopic_navitem_controller.dart';

import '../models/subtopic.dart';

class PreferenceService {
  void saveSubtopic(Subtopic subtopic, ) async {
    final box = Hive.box('navbarBox');
    
    // box.putAt(index, subtopic);
    box.put(subtopic.subTopicId, subtopic);

    
  }

  void removeSubtopic(Subtopic subtopic) {
    final box = Hive.box('navbarBox');
    box.delete(subtopic.subTopicId);
    SubtopicNavController.to.getNavbarItems([]);
  }

  List<Subtopic> loadNavbarItems() {
    final box = Hive.box('navbarBox');
    return box.values.cast<Subtopic>().toList();
  }

  void boxCloseNavbarItems() {
    final box = Hive.box('navbarBox');
    box.clear();
  }

  void savedPreferencePage(bool pref) {
    Box box = Hive.box('settings');
    box.put('preference_page', pref);
  }

  bool isPreferencePageAllowed() {
    Box box = Hive.box('settings');
    return box.get('preference_page', defaultValue: false);
  }
}
