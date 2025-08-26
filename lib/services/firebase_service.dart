import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/user_model.dart';
import '../models/skill_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // User Operations
  Future<void> createUser(UserModel user) async {
    await _firestore.collection('users').doc(user.id).set(user.toMap());
  }

  Future<UserModel?> getUser(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data()!, doc.id);
    }
    return null;
  }

  Future<void> updateUser(UserModel user) async {
    await _firestore.collection('users').doc(user.id).update(user.toMap());
  }

  // Skill Operations
  Future<String> createSkill(SkillModel skill) async {
    final docRef = await _firestore.collection('skills').add(skill.toMap());
    return docRef.id;
  }

  Future<List<SkillModel>> getSkills() async {
    final snapshot = await _firestore.collection('skills')
        .where('isAvailable', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .get();
    
    return snapshot.docs.map((doc) => 
        SkillModel.fromMap(doc.data(), doc.id)).toList();
  }

  Future<List<SkillModel>> getSkillsByUser(String userId) async {
    final snapshot = await _firestore.collection('skills')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .get();
    
    return snapshot.docs.map((doc) => 
        SkillModel.fromMap(doc.data(), doc.id)).toList();
  }

  Future<SkillModel?> getSkill(String skillId) async {
    final doc = await _firestore.collection('skills').doc(skillId).get();
    if (doc.exists) {
      return SkillModel.fromMap(doc.data()!, doc.id);
    }
    return null;
  }

  Future<void> updateSkill(SkillModel skill) async {
    await _firestore.collection('skills').doc(skill.id).update(skill.toMap());
  }

  Future<void> deleteSkill(String skillId) async {
    await _firestore.collection('skills').doc(skillId).delete();
  }

  // Image Upload
  Future<String> uploadImage(String path, Uint8List bytes) async {
    final ref = _storage.ref().child('skills/$path');
    final uploadTask = ref.putData(bytes);
    final snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  // Search Skills
  Future<List<SkillModel>> searchSkills(String query) async {
    final snapshot = await _firestore.collection('skills')
        .where('isAvailable', isEqualTo: true)
        .get();
    
    return snapshot.docs
        .map((doc) => SkillModel.fromMap(doc.data(), doc.id))
        .where((skill) => 
            skill.title.toLowerCase().contains(query.toLowerCase()) ||
            skill.description.toLowerCase().contains(query.toLowerCase()) ||
            skill.categories.any((category) => 
                category.toLowerCase().contains(query.toLowerCase())) ||
            skill.tags.any((tag) => 
                tag.toLowerCase().contains(query.toLowerCase())))
        .toList();
  }
}
