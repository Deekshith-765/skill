import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/firebase_service.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  final FirebaseService _firebaseService = FirebaseService();

  UserModel? get user => _user;

  Future<void> fetchUser(String userId) async {
    _user = await _firebaseService.getUser(userId);
    notifyListeners();
  }

  Future<void> createUser(UserModel user) async {
    await _firebaseService.createUser(user);
    _user = user;
    notifyListeners();
  }

  Future<void> updateUser(UserModel user) async {
    await _firebaseService.updateUser(user);
    _user = user;
    notifyListeners();
  }
}
