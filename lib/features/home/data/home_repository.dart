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

  Future<List<Map<String, String>>> getUserTeams(String uid) async {
    final userDoc = await _db.collection('users').doc(uid).get();
    final data = userDoc.data();
    if (data != null && data['teamId'] != null) {
      // Split the string by comma and trim spaces
      final List<String> teamIds = (data['teamId'] as String)
          .split(',')
          .map((e) => e.trim())
          .toList();

      List<Map<String, String>> teams = [];
      for (var id in teamIds) {
        final teamDoc = await _db.collection('teams').doc(id).get();
        if (teamDoc.exists) {
          final teamData = teamDoc.data()!;
          teams.add({
            'id': teamDoc.id,
            'name': teamData['name'] ?? 'Team',
            'initials': teamData['initials'] ?? '',
          });
        }
      }
      return teams;
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
