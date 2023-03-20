// import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habits_tracker/data.dart';
import 'package:habits_tracker/main.dart';

import 'create_habit.dart';

enum Priority {
  low,
  avarage,
  high,
}
enum Period {
  day,
  week,
  month,
  year,
}

class Habit {
  late String _name;
  late String _description;
  late Priority _priority;
  late bool _isGood;
  late int _amount;
  late Period _period;
  late DateTime _dateOfCreate;

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
    _dateOfCreate = DateTime.now();
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

  DateTime get dateOfCreate => _dateOfCreate;

  set dateOfCreate(DateTime dateOfCreate) {
    _dateOfCreate = dateOfCreate;
  }

  void _onItemTapped() {
    // Navigator.of(context).pushNamed("/change", arguments: this);
    CreatePage(isChange: true, habit: this);
  }

  Widget habitsWidget(BuildContext context, bool isDescending) {
    return Container(
        height: 90,
        child: Row(
          children: [
            Container(
              width: 50,
              height: 90,
              color: _isGood ? (Colors.green) : (Colors.redAccent),
              child: IconButton(
                padding: const EdgeInsets.all(0.0),
                icon: Icon(
                  Icons.done,
                  size: 25.0,
                ),
                color: Colors.white,
                onPressed: () {
                  changeCount();
                  streamControllerSort.add(isDescending);
                },
              ),
            ),
            SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: () { ////////////////////////////////////////////////////////
                print('tappeded');
                streamControllerHabit.add(this);
                Navigator.pushNamed(context, '/change');
                // _onItemTapped();
              },
              child: Container(
                width: screenWidht - 60 - 100,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      _name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      makeKomm(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${count} / ${_amount}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                    ),
                  ),
                  Text(
                    _period == Period.day
                        ? ('day')
                        : (_period == Period.week
                            ? ('week')
                            : (_period == Period.month
                                ? ('month')
                                : (_period == Period.year
                                    ? ('year')
                                    : ('error')))),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Widget simpleHabitsWidget(bool isDescending) {
    return Container(
        height: 80,
        child: Row(
          children: [
            Container(
              width: 50,
              height: 80,
              color: _isGood ? (Colors.green) : (Colors.redAccent),
              child: IconButton(
                padding: const EdgeInsets.all(0.0),
                icon: Icon(
                  Icons.done,
                  size: 25.0,
                ),
                color: Colors.white,
                onPressed: () {
                  changeCount();
                  streamControllerSort.add(isDescending);
                },
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              width: screenWidht - 60 - 100,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    _name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    makeKomm(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
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
