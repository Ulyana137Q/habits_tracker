// @dart=2.9
import 'package:flutter/material.dart';
import 'package:habits_tracker/create_habit.dart';
import 'package:habits_tracker/data.dart';
import 'package:habits_tracker/habits.dart';

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
        '/': (BuildContext context) => MyHomePage(),
        '/create': (BuildContext context) => CreatePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void refresh() => setState(() {});

  int _selectedIndex = 0;
  static List<List<Habit>> habitsList = [
    habits,
    goodHabits,
    badHabits,
  ];

  void _onItemTapped(int index) {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        actions: <Widget>[
          IconButton(onPressed: () {
            showSearch(context: context, delegate: HabitsSearch());
          }, icon: Icon(Icons.search)),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          //child: Expanded(
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
                  child: GestureDetector(child: habitsWidget(habit)),
                ))
                .toList(),
          ),
        ),
      ),
      // ),
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
        onTap: _onItemTapped,
      ),
    );
  }


  Widget habitsWidget(Habit habit) {
    return Container(
        height: 80,
        child: Row(
          children: [
            Container(
              width: 50,
              height: 80,
              color: habit.isGood ? (Colors.green) : (Colors.redAccent),
              child: IconButton(
                padding: const EdgeInsets.all(0.0),
                icon: Icon(
                  Icons.done,
                  size: 25.0,
                ),
                color: Colors.white,
                onPressed: () {
                  habit.changeCount();
                  refresh();
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
                    habit.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    habit.makeKomm(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${habit.count} / ${habit.amount}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                    ),
                  ),
                  Text(
                    habit.period == Period.day
                        ? ('day')
                        : (habit.period == Period.week
                        ? ('week')
                        : (habit.period == Period.month
                        ? ('month')
                        : (habit.period == Period.year
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
}


class HabitsSearch extends SearchDelegate<Habit> {

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
          return habitsWidget(thabit);
        });
  }


  Widget habitsWidget(Habit habit) {
    return Container(
        height: 80,
        child: Row(
          children: [
            Container(
              width: 50,
              height: 80,
              color: habit.isGood ? (Colors.green) : (Colors.redAccent),
              child: IconButton(
                padding: const EdgeInsets.all(0.0),
                icon: Icon(
                  Icons.adjust,
                  size: 25.0,
                ),
                color: Colors.white,
                onPressed: () {
                  habit.changeCount();
                  //refresh();
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
                    habit.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    habit.makeKomm(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   width: 80,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text(
            //         '${habit.count} / ${habit.amount}',
            //         style: const TextStyle(
            //           color: Colors.black,
            //           fontSize: 30.0,
            //         ),
            //       ),
            //       Text(
            //         habit.period == Period.day
            //             ? ('day')
            //             : (habit.period == Period.week
            //             ? ('week')
            //             : (habit.period == Period.month
            //             ? ('month')
            //             : (habit.period == Period.year
            //             ? ('year')
            //             : ('error')))),
            //         style: const TextStyle(
            //           color: Colors.black,
            //           fontSize: 18.0,
            //         ),
            //       ),
            //     ],
            //   ),
            // )
          ],
        ));
  }
}