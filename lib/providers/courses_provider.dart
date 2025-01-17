import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:service_learning_website/modules/backend/course_chapter_data.dart';
import 'package:service_learning_website/modules/backend/course_data.dart';
import 'package:service_learning_website/modules/backend/course_participant_data.dart';
import 'package:service_learning_website/modules/random_id.dart';

class CoursesProvider with ChangeNotifier {
  CoursesProvider() {
    _load();
  }

  final _collection = FirebaseFirestore.instance.collection("courses");
  final _storage = FirebaseStorage.instance.ref("images/courses");

  Map<String, CourseData> _coursesData = {};
  Map<String, CourseData> get coursesData => _coursesData;

  void _load() {
    _collection.get().then((snapshot) {
      _coursesData = Map.fromIterable(
          snapshot.docs.map((doc) => CourseData.fromJson(doc.data())).toList(),
          key: (v) => (v as CourseData).id);
      if (kDebugMode) {
        print("courses_provider -> loaded");
      }
      notifyListeners();
    });
  }

  void createCourse() {
    final String id = RandomId.generate();
    final CourseData courseData = CourseData(id: id, title: id);
    _collection.doc(id).set(courseData.toJson()).then((_) {
      _coursesData[id] = courseData;
      if (kDebugMode) {
        print("courses_provider -> updated");
      }
      notifyListeners();
    });
  }

  void createChapter(String courseId) {
    final String id = RandomId.generate();
    final CourseChapterData chapterData = CourseChapterData(
        id: id, title: id, number: _coursesData[courseId]!.chapters.length);
    _collection
        .doc(courseId)
        .collection("chapters")
        .doc(id)
        .set(chapterData.toJson())
        .then((_) {
      _coursesData[courseId]!.chapters[id] = chapterData;
      notifyListeners();
    });
  }

  Future<void> loadCourse(String courseId) async {
    await _collection
        .doc(courseId)
        .collection("participants")
        .get()
        .then((snapshot) {
      _coursesData[courseId]!.participants = Map.fromIterable(
          snapshot.docs
              .map((doc) => CourseParticipantData.fromJson(doc.data()))
              .toList(),
          key: (v) => (v as CourseParticipantData).uid);
    });
    await _collection
        .doc(courseId)
        .collection("chapters")
        .get()
        .then((snapshot) {
      _coursesData[courseId]!.chapters = Map.fromIterable(
          snapshot.docs
              .map((doc) => CourseChapterData.fromJson(doc.data()))
              .toList(),
          key: (v) => (v as CourseChapterData).id);
    });
    notifyListeners();
  }

  Future<void> updateCourse(String courseId, {Uint8List? image}) async {
    if (image != null) {
      await _storage.child(courseId).putData(image);
      _coursesData[courseId]!.imageUrl =
          await _storage.child(courseId).getDownloadURL();
    }
    await _collection.doc(courseId).update(coursesData[courseId]!.toJson());
    notifyListeners();
  }

  Future<void> addParticipant(String courseId, String uid) async {
    _coursesData[courseId]!.participants[uid] = CourseParticipantData(uid: uid);
    await _collection
        .doc(courseId)
        .collection("participants")
        .doc(uid)
        .set(_coursesData[courseId]!.participants[uid]!.toJson());
    notifyListeners();
  }

  Future<void> updateChapter(String courseId, String chapterId) async {
    await _collection
        .doc(courseId)
        .collection("chapters")
        .doc(chapterId)
        .update(_coursesData[courseId]!.chapters[chapterId]!.toJson());
    notifyListeners();
  }
}
