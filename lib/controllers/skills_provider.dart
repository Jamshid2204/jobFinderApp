import 'package:flutter/material.dart';

class SkillsNotifier extends ChangeNotifier {

  bool _addSkills = false;
  bool get addSkills => _addSkills;
  set setSkills(bool newState){
    _addSkills = newState;
    notifyListeners();
  }

  String _addSkillsId = '';
  String get addSkillsId => _addSkillsId;
  set setSkillsId(String newState){
    _addSkillsId = newState;
    if(_addSkillsId == newState){
    notifyListeners();
    }
  }
}
