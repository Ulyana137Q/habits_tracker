// @dart=2.9
import 'package:flutter/material.dart';
import 'package:habits_tracker/data.dart';
import 'package:habits_tracker/main.dart';

import 'habits.dart';

final TextEditingController nameController = TextEditingController();

class CreatePage extends StatefulWidget {
  bool isChange;
  Habit habit;
  bool isDescending;
  Stream stream;
  CreatePage({this.isDescending, this.isChange, this.habit,this.stream, Key key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  void refresh() => setState(() {});

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String new_name = '';
  String new_description = '';
  Priority new_priority = Priority.values.first;
  bool new_isGood = true;
  int new_amount = 0;
  Period new_period = Period.values.first;

  List<DropdownMenuItem<Priority>> get dropdownPriority {
    List<DropdownMenuItem<Priority>> menuItems = [
      DropdownMenuItem(
          child: Text("высокий", style: mainTextStyle), value: Priority.high),
      DropdownMenuItem(
          child: Text("средний", style: mainTextStyle),
          value: Priority.avarage),
      DropdownMenuItem(
          child: Text("низкий", style: mainTextStyle), value: Priority.low),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<Period>> get dropdownPeriod {
    List<DropdownMenuItem<Period>> menuItems = [
      DropdownMenuItem(
          child: Text("день", style: mainTextStyle), value: Period.day),
      DropdownMenuItem(
          child: Text("неделя", style: mainTextStyle), value: Period.week),
      DropdownMenuItem(
          child: Text("месяц", style: mainTextStyle), value: Period.month),
      DropdownMenuItem(
          child: Text("год", style: mainTextStyle), value: Period.year)
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isChange) {
      widget.stream.listen((habit) => widget.habit = habit);
      return modificationHabit();}
    else {return newHabit();};
  }

  Widget modificationHabit(){
    widget.habit = h2;
    return Scaffold(
        appBar: AppBar(

          title: Text('Отредактировать'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Название:', style: mainTextStyle),
                    SizedBox(width: 20),
                    SizedBox(
                      width: 250,
                      height: 80,
                      child: TextFormField(
                          initialValue: widget.habit.name,
                          validator: (value) {
                          if (value.isNotEmpty) {
                            return null;
                          } else {
                            return 'обязательное поле';
                          }
                        },
                        onChanged: (value) {
                          widget.habit.name = value;
                        },
                        style: mainTextStyle,
                        obscureText: false,
                        autofocus: true,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Описание:', style: mainTextStyle),
                    SizedBox(width: 20),
                    SizedBox(
                      width: 250,
                      //height: 80,
                      child: TextFormField(
                        initialValue: widget.habit.description,
                        style: mainTextStyle,
                        onChanged: (value) {
                          widget.habit.description = value;
                        },
                        obscureText: false,
                      ),
                    ),
                  ],
                ),
                Row(children: [
                  Text('Приоритет:', style: mainTextStyle),
                  SizedBox(
                    width: 20,
                  ),
                  DropdownButton(
                      value: widget.habit.priority,
                      items: dropdownPriority,
                      onChanged: (Priority newPrior) {
                        setState(() {
                          widget.habit.priority = newPrior;
                        });
                      }),
                ]),
                Row(children: [
                  Text('Тип:', style: mainTextStyle),
                  Column(
                    children: [
                      Row(
                        children: [
                          Radio<bool>(
                            value: widget.habit.isGood,
                            groupValue: new_isGood,
                            onChanged: (value) {
                              setState(() {
                                widget.habit.isGood = true;
                                goodHabits.add(widget.habit);
                                badHabits.remove(widget.habit);
                              });
                            },
                            activeColor: Colors.green,
                          ),
                          Text('хорошая', style: mainTextStyle),
                          Radio<bool>(
                            value: !widget.habit.isGood,
                            groupValue: new_isGood,
                            onChanged: (value) {
                              setState(() {
                                widget.habit.isGood = false;
                                goodHabits.remove(widget.habit);
                                badHabits.add(widget.habit);
                              });
                            },
                            activeColor: Colors.green,
                          ),
                          Text('плохая', style: mainTextStyle),
                        ],
                      ),
                    ],
                  ),
                ]),
                Row(
                  children: [
                    Text('Частота:', style: mainTextStyle),
                    SizedBox(width: 20),
                    SizedBox(
                      width: 250,
                      height: 80,
                      child: TextFormField(
                        initialValue: widget.habit.amount.toString(),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'обязательное поле';
                          }
                          ;
                          try {
                            widget.habit.amount = int.parse(value);
                          } catch (e) {
                            widget.habit.amount = null;
                            return 'введите число';
                          }
                          return null;
                        },
                        style: mainTextStyle,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          widget.habit.amount = int.parse(value);
                        },
                        obscureText: false,
                      ),
                    ),
                  ],
                ),
                Row(children: [
                  Text('Период:', style: mainTextStyle),
                  SizedBox(
                    width: 20,
                  ),
                  DropdownButton(
                      value: widget.habit.period,
                      items: dropdownPeriod,
                      onChanged: (Period newPeriod) {
                        setState(() {
                          widget.habit.period = newPeriod;
                        });
                      }),
                ]),
                SizedBox(
                  height: 40,
                ),
                TextButton(
                  child: Text(
                    "Сохранить",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                    ),
                  ),
                  onPressed: () {
                    if (!_formkey.currentState.validate()) {
                      return;
                    } else {
                      streamControllerSort.add(widget.isDescending);
                      Navigator.pushNamed(context, '/');
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(primaryColor),
                    foregroundColor:
                    MaterialStateProperty.all<Color>(Colors.white),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget newHabit(){
    return Scaffold(
        appBar: AppBar(

          title: Text('Новая привычка'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Название:', style: mainTextStyle),
                    SizedBox(width: 20),
                    SizedBox(
                      width: 250,
                      height: 80,
                      child: TextFormField(
                        validator: (value) {
                          if (value.isNotEmpty) {
                            return null;
                          } else {
                            return 'обязательное поле';
                          }
                        },
                        onChanged: (value) {
                          new_name = value;
                        },
                        style: mainTextStyle,
                        obscureText: false,
                        autofocus: true,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Описание:', style: mainTextStyle),
                    SizedBox(width: 20),
                    SizedBox(
                      width: 250,
                      //height: 80,
                      child: TextField(
                        style: mainTextStyle,
                        onChanged: (value) {
                          new_description = value;
                        },
                        obscureText: false,
                      ),
                    ),
                  ],
                ),
                Row(children: [
                  Text('Приоритет:', style: mainTextStyle),
                  SizedBox(
                    width: 20,
                  ),
                  DropdownButton(
                      value: new_priority,
                      items: dropdownPriority,
                      onChanged: (Priority newPrior) {
                        setState(() {
                          new_priority = newPrior;
                        });
                      }),
                ]),
                Row(children: [
                  Text('Тип:', style: mainTextStyle),
                  Column(
                    children: [
                      Row(
                        children: [
                          Radio<bool>(
                            value: true,
                            groupValue: new_isGood,
                            onChanged: (value) {
                              setState(() {
                                new_isGood = value;
                              });
                            },
                            activeColor: Colors.green,
                          ),
                          Text('хорошая', style: mainTextStyle),
                          Radio<bool>(
                            value: false,
                            groupValue: new_isGood,
                            onChanged: (value) {
                              setState(() {
                                new_isGood = value;
                              });
                            },
                            activeColor: Colors.green,
                          ),
                          Text('плохая', style: mainTextStyle),
                        ],
                      ),
                    ],
                  ),
                ]),
                Row(
                  children: [
                    Text('Частота:', style: mainTextStyle),
                    SizedBox(width: 20),
                    SizedBox(
                      width: 250,
                      height: 80,
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'обязательное поле';
                          }
                          ;
                          try {
                            new_amount = int.parse(value);
                          } catch (e) {
                            new_amount = null;
                            return 'введите число';
                          }
                          return null;
                        },
                        style: mainTextStyle,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          new_amount = int.parse(value);
                        },
                        obscureText: false,
                      ),
                    ),
                  ],
                ),
                Row(children: [
                  Text('Период:', style: mainTextStyle),
                  SizedBox(
                    width: 20,
                  ),
                  DropdownButton(
                      value: new_period,
                      items: dropdownPeriod,
                      onChanged: (Period newPeriod) {
                        setState(() {
                          new_period = newPeriod;
                        });
                      }),
                ]),
                SizedBox(
                  height: 40,
                ),
                TextButton(
                  child: Text(
                    "Сохранить",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                    ),
                  ),
                  onPressed: () {
                    if (!_formkey.currentState.validate()) {
                      return;
                    } else {
                      Habit nh = Habit(new_name, new_description, new_priority,
                          new_isGood, new_amount, new_period);
                      habits.add(nh);
                      new_isGood? goodHabits.add(nh) : badHabits.add(nh);
                      streamControllerSort.add(widget.isDescending);
                      Navigator.pushNamed(context, '/');
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(primaryColor),
                    foregroundColor:
                    MaterialStateProperty.all<Color>(Colors.white),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  bool checkHabit() {
    bool isOk = true;
    if (new_name.isEmpty ||
        new_priority == null ||
        new_amount == 0 ||
        new_period == null) {
      isOk = false;
    }
    ;
    return isOk;
  }
}
