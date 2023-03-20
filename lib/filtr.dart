// @dart=2.9
import 'package:flutter/material.dart';
import 'package:habits_tracker/data.dart';
import 'package:habits_tracker/habits.dart';
import 'package:habits_tracker/main.dart';



class HabitsSearch extends SearchDelegate<Habit> {
  bool boolStream;
  HabitsSearch(bool stream) {
    boolStream = stream;
  }
  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(onPressed: () {query = '';}, icon: Icon(Icons.clear)),];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(onPressed: () {close(context, null);}, icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }


  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Habit> thabits = query.isEmpty? habits : habits.where((habit) => habit.name.startsWith(query)).toList();
    return ListView.builder(
        itemCount: thabits.length,
        itemBuilder: (context, index) {
          final Habit thabit = thabits[index];
          return thabit.simpleHabitsWidget(boolStream);
        });
  }

}