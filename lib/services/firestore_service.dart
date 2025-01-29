import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getSlides() async {
    final doc = await _db.collection('home').doc('sales').get();

    if (!doc.exists) return [];

    return List<Map<String, dynamic>>.from(doc.data()?['slides'] ?? []);
  }

  Stream<List<Map<String, dynamic>>> slidesStream() {
    return _db.collection('home').doc('sales').snapshots().map((doc) {
      if (!doc.exists) return [];
      return List<Map<String, dynamic>>.from(doc.data()?['slides'] ?? []);
    });
  }
}
