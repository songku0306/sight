import 'package:flutter/material.dart';
import 'package:newpracto/screens/countscreen.dart';
import 'package:newpracto/screens/screen_one.dart';
import 'package:newpracto/screens/screen_two.dart';
import 'package:newpracto/widgets/butttons.dart';

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
                  child: const ButtonMain(
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
                        builder: (context) => const ScreenOne(),
                      ),
                    );
                  },
                  child: const ButtonMain(
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
                        builder: (context) => const ScreenTwo(),
                      ),
                    );
                  },
                  child: const ButtonMain(
                    colors: Colors.blueGrey,
                    wd: 100,
                    ht: 100,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
