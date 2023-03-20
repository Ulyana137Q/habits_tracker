// @dart=2.9
import 'package:flutter/material.dart';
import 'package:habits_tracker/create_habit.dart';
import 'package:habits_tracker/data.dart';
import 'package:habits_tracker/habits.dart';
import 'dart:async';
import 'filtr.dart';

StreamController<bool> streamControllerSort = StreamController.broadcast();
StreamController<Habit> streamControllerHabit = StreamController.broadcast();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // скрываем надпись debug
      title: 'Habits Demo',
      theme: ThemeData(
        primarySwatch: primaryColor,
      ),
      initialRoute: '/',
      // home: MyStatefulWidget(),
      routes: {
        '/': (BuildContext context) => MyHomePage(streamControllerSort.stream),
        '/create': (BuildContext context) => CreatePage(isChange: false,),
        '/change': (BuildContext context) => CreatePage(isChange: true,stream: streamControllerHabit.stream,)
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage(this.stream);
  final Stream<bool> stream;
  bool isDescending = false;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState(){
    super.initState();
    widget.stream.listen((sotType) => refresh(sotType));
  }

  void refresh(bool newSort) => setState(() {
    widget.isDescending = newSort;
  });

  int _selectedIndex = 0;
  static List<List<Habit>> habitsList = [
    habits,
    goodHabits,
    badHabits,
  ];

  void _onTypeTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    screenWidht = MediaQuery
        .of(context)
        .size
        .width;
    // final List<Habit> habitsList = habits.where((habit) {
    //     if (_selectedIndex == 1){habit.isGood;}
    //     else if (_selectedIndex == 2) {!habit.isGood;}
    //     else {habit.isGood || !habit.isGood;}}).toList();
    //
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        actions: <Widget>[
          IconButton(onPressed: () {
            showSearch(context: context, delegate: HabitsSearch(widget.isDescending));
          }, icon: Icon(Icons.search)),
          IconButton(onPressed: () {
            streamControllerSort.add(!widget.isDescending);
            (widget.isDescending) ? habits.sort((a, b) => a.dateOfCreate.compareTo(b.dateOfCreate)): habits.sort((a, b) => b.dateOfCreate.compareTo(a.dateOfCreate));
          }, icon: Icon(Icons.sort)),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.all(0.0),
              children: habitsList[_selectedIndex]
                  .map((habit) =>
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 0.0,
                      bottom: 5.0,
                      left: 5.0,
                      right: 3.0,
                    ),
                    child: GestureDetector(
                        child: habit.habitsWidget(context, widget.isDescending),
                        ), // добавить реакцию на нажатие
                  ))
                  .toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/create');
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'all',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'good',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.remove),
            label: 'bad',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: primaryColor,
        onTap: _onTypeTapped,
      ),
    );
  }

}