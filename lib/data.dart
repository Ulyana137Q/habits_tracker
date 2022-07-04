import 'package:flutter/material.dart';
import 'package:habits_tracker/habits.dart';

const primaryColor = Colors.deepPurple;
const lightColor = Color(0xFF9FA8DA);
const mainTextStyle = TextStyle(color: Colors.black, fontSize: 25.0,);

double screenWidht = 400.0;
Habit h1 = Habit('покушать', 'важно хорошо питаться', Priority.high, true, 3, Period.day);
Habit h2 = Habit('унывать', 'не стоит много унывать', Priority.avarage, false, 1, Period.week);
List<Habit> habits = [
  h1, h2,
];
List<Habit> goodHabits = [
  h1,
];
List<Habit> badHabits = [
  h2,
];

List<Habit> getHabits(){
  return habits;
}
