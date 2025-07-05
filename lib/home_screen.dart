import 'package:flutter/material.dart';

import 'constant.dart';
import 'second_screen.dart';

class HomeScreen extends StatefulWidget {
  final titleText;
  const HomeScreen({super.key, required this.titleText});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color? maleColour = Colors.blue[100];
  Color? femaleColour = Colors.pink[100];

  imageResize(path) {
    return Image(
      image: AssetImage(path),
      height: 90,
      width: 90,
      fit: BoxFit.cover,
    );
  }

  void selectGender(bool gender) {
    if (gender) {
      setState(() {
        maleColour = selectedColor;
        femaleColour = femaleColourr;
      });
    } else {
      setState(() {
        maleColour = maleColourr;
        femaleColour = selectedColor;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var titleText = RichText(
      text: TextSpan(
        style: titleTextStyle,
        // TextStyle(fontSize: 25.0, color: Colors.blue[400]),
        children: <TextSpan>[
          TextSpan(
            text: 'BMI',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue[400],
            ),
          ),
          TextSpan(
            text: ' Calculator',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.pinkAccent,
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: titleText,
        centerTitle: true,
        backgroundColor: Colors.white60,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              heightFactor: 2,
              child: Text(
                "Please choose your gender",
                style: instractionTextStyle,
              ),
            ),

            GestureDetector(
              onTap: () {
                setState(() {
                  selectGender(true);
                });
              },
              child: ReusableWidget(
                heightSize:150,
                color: maleColour,
                cardChild: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Male", style: maleTextStyle),
                    imageResize('assets/male.png'),
                  ],
                ),
                borderColor: Colors.blue,
              ),
            ),

            GestureDetector(
              onTap: () {
                setState(() {
                  selectGender(false);
                  print('Hello');
                });
              },
              child: ReusableWidget(
                color: femaleColour,
                heightSize: 150,
                borderColor: Colors.pinkAccent,
                cardChild: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Female", style: femaleTextStyle),
                    imageResize('assets/female.png'),
                  ],
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 150),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecondScreen(titleText: titleText)),
                  );
                },
                child: ReusableWidget(
                  heightSize: 50,
                  color: Colors.green,
                  borderColor: Colors.green,
                  cardChild: Center(
                    child: Text(
                      "Countinue",
                      style: TextStyle(fontSize: 20, color: Colors.green[100],
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReusableWidget extends StatelessWidget {
  ReusableWidget({
    required this.color,
    required this.cardChild,
    required this.borderColor,
    required this.heightSize,
  });

  Color? color;
  final Widget cardChild;
  Color borderColor;
  double heightSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightSize,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
        border: Border.all(color: borderColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
          ),
        ],
      ),
      child: cardChild,
    );
  }
}
