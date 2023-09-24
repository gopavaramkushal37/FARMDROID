import 'package:flutter/material.dart';
import 'res_pool.dart';
import 'schemes.dart';
import 'members.dart';
import 'res_req.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/page1': (context) => Page3(),
        '/page2': (context) => Page2(),
        '/page3': (context) => Page1(),
        '/page4': (context) => Page4(),
      },
      home: Scaffold(
        appBar: AppBar(
          title: Text('HOME'),
        ),
        body: GridView.count(
          crossAxisCount: 2, // Adjust the number of columns as needed
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          padding: EdgeInsets.all(20),
          children: [
            SquareButton(text: 'Resource Request', routeName: '/page1'),
            SquareButton(text: 'Scheme', routeName: '/page2'),
            SquareButton(text: 'Resource Pool', routeName: '/page3'),
            SquareButton(text: 'Members', routeName: '/page4'),
          ],
        ),
      ),
    );
  }
}

class SquareButton extends StatelessWidget {
  String text;
  String routeName;

  SquareButton({required this.text, required this.routeName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, routeName);
        },
        child: Text(text),
      ),
    );
  }
}

