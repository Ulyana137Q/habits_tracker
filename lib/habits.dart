import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habits_tracker/data.dart';

enum Priority { low, avarage, high, }
enum Period { day, week, month, year, }

class Habit {
  late String _name;
  late String _description;
  late Priority _priority;
  late bool _isGood;
  late int _amount;
  late Period _period;

  int count = 0;
  String _komm = '';

  Habit(String name, String description, Priority priority, bool isGood,
      int amount, Period period) {
    _name = name;
    _description = description;
    _priority = priority;
    _isGood = isGood;
    _amount = amount;
    _period = period;
  }

  void changeCount({int i = 1}) => count += i;

  String makeKomm() {
    if (_isGood) {
      if (count >= _amount) {
        return 'хорошо справляешься!';
      } else {
        if (count < _amount) {
          int n = _amount - count;
          return 'Стоит выполнить еще $n раза';
        }
        ;
      }
      ;
    } else {
      if (count >= _amount) {
        return 'стоит прекратить это делать';
      } else {
        if (count < _amount) {
          int n = _amount - count;
          return 'Можно сделать еще $n раз';
        }
        ;
      }
      ;
    }
    ;
    return 'error';
  }


  String get name => _name;

  set name(String name) {
    _name = name;
  }

  String get description => _description;

  set description(String description) {
    _description = description;
  }

  Priority get priority => _priority;

  set priority(Priority priority) {
    _priority = priority;
  }

  bool get isGood => _isGood;

  set isGood(bool isGood) {
    _isGood = isGood;
  }

  int get amount => _amount;

  set amount(int amount) {
    _amount = amount;
  }

  Period get period => _period;

  set period(Period period) {
    _period = period;
  }

  @override
  void printHabiit() {
    print('наименование: $_name');
    print('описание: $_description');
    print('приоритет: $_priority');
    print('привычка хорошая? $_isGood');
    print('частота: $_amount');
    print('период: $_period');
  }
}
