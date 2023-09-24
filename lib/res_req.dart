import 'package:flutter/material.dart';
import 'data_input.dart';
import 'database.dart'; // Import DatabaseHelper
import 'res.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CardListPage(),
    );
  }
}

class CardListPage extends StatelessWidget {
  final List<String> imageUrls = [
    'assets/images/cotton.jpg',
    'assets/images/paddy.jpg',
    'assets/images/wheat.jpg',
    'assets/images/millets.jpg',
    'assets/images/groundnut.jpg',
    'assets/images/waterpipes.jpg',
    'assets/images/sprinkler.jpg',
    'assets/images/motorpump.jpg',
    'assets/images/weeder.jpg',
    'assets/images/plough.jpg',
    'assets/images/harvester.jpg',
    'assets/images/cultivator.jpg',
    'assets/images/seeder.jpg',
  ];
  final List<String> buttonTexts = [
    'cotton seeds',
    'paddy seeds',
    'wheat seeds',
    'millets',
    'groundnut seeds',
    'waterpipes',
    'sprinklers',
    'motorpump',
    'weeder',
    'plough',
    'harvester',
    'cultivator',
    'seeder',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Farmdroid'),
      ),
      body: ListView.builder(
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return CardItem(
            imageUrl: imageUrls[index],
            buttonText: buttonTexts[index],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PincodeFilteredDisplayPage(buttonTexts[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final String imageUrl;
  final String buttonText;
  final VoidCallback onTap;

  CardItem({
    required this.imageUrl,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 4,
      child: Column(
        children: [
          Image.asset(imageUrl,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: onTap,
              child: Text(buttonText),
            ),
          ),
        ],
      ),
    );
  }
}
