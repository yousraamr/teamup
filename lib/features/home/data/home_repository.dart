// provides a tasksStream(uid) and write actions (add/update/delete).
import 'package:cloud_firestore/cloud_firestore.dart';
import '../domain/models/task_model.dart';

class HomeRepository {
  final FirebaseFirestore _db;
  HomeRepository({FirebaseFirestore? firestore}) : _db = firestore ?? FirebaseFirestore.instance;

  Stream<List<TaskModel>> tasksStream(String uid) {
    final ref = _db.collection('users').doc(uid).collection('tasks').orderBy('dueDate');
    return ref.snapshots().map((snap) => snap.docs.map((d) => TaskModel.fromDoc(d)).toList());
  }

  Future<String> getUserName(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    final data = doc.data();
    if (data != null && data['name'] != null) {
      return data['name'] as String;
    }
    return 'User';
  }

  Future<List<String>> getUserTeams(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    final data = doc.data();
    if (data != null && data['teamId'] != null) {
      final List<dynamic> raw = data['teamId'] is List ? data['teamId'] : [data['teamId']];
      return raw.map((e) => e.toString()).toList();
    }
    return [];
  }

  Future<void> addTask(String uid, {required String title, String description = '', required DateTime due, String status = 'pending'}) {
    final ref = _db.collection('users').doc(uid).collection('tasks');
    return ref.add({
      'title': title,
      'description': description,
      'dueDate': Timestamp.fromDate(due),
      'status': status,
    });
  }

  Future<void> updateTaskStatus(String uid, String taskId, String newStatus) {
    return _db.collection('users').doc(uid).collection('tasks').doc(taskId).update({'status': newStatus});
  }

  Future<void> deleteTask(String uid, String taskId) {
    return _db.collection('users').doc(uid).collection('tasks').doc(taskId).delete();
  }
}
