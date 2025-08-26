import 'package:flutter/material.dart';
import '../models/skill_model.dart';
import '../services/firebase_service.dart';

class SkillProvider with ChangeNotifier {
  List<SkillModel> _skills = [];
  final FirebaseService _firebaseService = FirebaseService();

  List<SkillModel> get skills => _skills;

  Future<void> fetchSkills() async {
    _skills = await _firebaseService.getSkills();
    notifyListeners();
  }

  Future<void> createSkill(SkillModel skill) async {
    await _firebaseService.createSkill(skill);
    _skills.insert(0, skill); // Add the new skill to the top of the list
    notifyListeners();
  }

  Future<void> updateSkill(SkillModel skill) async {
    await _firebaseService.updateSkill(skill);
    final index = _skills.indexWhere((s) => s.id == skill.id);
    if (index != -1) {
      _skills[index] = skill; // Update the skill in the list
      notifyListeners();
    }
  }

  Future<void> deleteSkill(String skillId) async {
    await _firebaseService.deleteSkill(skillId);
    _skills.removeWhere((skill) => skill.id == skillId);
    notifyListeners();
  }
}
