import 'package:flutter/material.dart';
import 'package:newpracto/screens/count_saved.dart';
import 'package:newpracto/screens/count_screen.dart';
import 'package:newpracto/screens/layout_screen.dart';
import 'package:newpracto/screens/bank_screen.dart';
import 'package:newpracto/screens/tap_bottom.dart';
import 'package:newpracto/screens/tap_screen.dart';
import 'package:newpracto/screens/todo.dart';
import 'package:newpracto/widgets/tile_for_menu.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(
        title: 'Flutter practice Home Page',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'This is new practice',
            ),
            Text(
              'cnter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const CountScreen(),
                          ),
                        );
                      },
                      child: const TileForMenu(
                        colors: Colors.redAccent,
                        wd: 100,
                        ht: 100,
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const BankScreen(),
                          ),
                        );
                      },
                      child: const TileForMenu(
                        colors: Colors.greenAccent,
                        wd: 150,
                        ht: 100,
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => TodosScreen(
                              todos: List.generate(
                                20,
                                (i) => Todo(
                                  'Todo $i',
                                  'A description of what needs to be done for Todo $i',
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: const TileForMenu(
                        colors: Colors.blueGrey,
                        wd: 100,
                        ht: 100,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('count'),
                    Text('bank'),
                    Text('todo'),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const CountSaved(),
                          ),
                        );
                      },
                      child: const TileForMenu(
                        colors: Colors.yellow,
                        wd: 100,
                        ht: 100,
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const LayoutScreen(),
                          ),
                        );
                      },
                      child: const TileForMenu(
                        colors: Colors.pinkAccent,
                        wd: 150,
                        ht: 100,
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const TabBarPract(),
                          ),
                        );
                      },
                      child: const TileForMenu(
                        colors: Colors.lightBlue,
                        wd: 100,
                        ht: 100,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('savedcount'),
                    Text('layouts'),
                    Text('tap bar'),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const TapBottom(),
                          ),
                        );
                      },
                      child: const TileForMenu(
                        colors: Colors.blue,
                        wd: 100,
                        ht: 100,
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const LayoutScreen(),
                          ),
                        );
                      },
                      child: const TileForMenu(
                        colors: Colors.black87,
                        wd: 150,
                        ht: 100,
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const TabBarPract(),
                          ),
                        );
                      },
                      child: const TileForMenu(
                        colors: Colors.greenAccent,
                        wd: 100,
                        ht: 100,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('1'),
                    Text('2'),
                    Text('3'),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
