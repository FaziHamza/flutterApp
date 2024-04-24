import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SubtopicService {
  void subscribeToSubtopic(String subtopic) async{
    await Firebase.initializeApp();
    FirebaseMessaging.instance.subscribeToTopic(subtopic);
  }

  void unsubscribeToSubtopic(String subtopic) async{
    await Firebase.initializeApp();
    FirebaseMessaging.instance.unsubscribeFromTopic(subtopic);
  }
}
