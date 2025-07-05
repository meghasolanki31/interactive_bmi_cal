import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:interactive_bmi_cal/constant.dart';
import 'package:flutter_scale_ruler/flutter_scale_ruler.dart';

class SecondScreen extends StatefulWidget {
  final RichText titleText;

  const SecondScreen({super.key, required this.titleText});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final myController = TextEditingController();
  int age = 15;
  int weight = 30;
  int defaultHeight = 100;
  String strweightt = "Weight";
  ScaleValue? _scaleValueCms;
  int heightToM = 0;
  var bmi;

  var bmiColor1 = Colors.white;
  var bmiColor2=Colors.white;
  var bmiText = "Normal";

  // var imagePath="normal";

  void calculateBMI() {
    heightToM = int.tryParse(_scaleValueCms?.cms!.toString() ?? "0")!;

    var heightInMeter = heightToM / 100;
    var bmiResult = weight / (heightInMeter * heightInMeter);
    bmi = bmiResult.round();
    print(bmi.round());

    /* Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResultScreen(bmiResult: bmi.round(),)),
    );*/
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    setState(() {
      if (bmi != null) {
        calculateBMI();
        UpdateUI();
        print("BMI result::$bmi");
      } else {
        print("BMI result::$bmi");
      }
    });
  }

  void UpdateUI() {
    // var bmi=widget.bmiResult;
    if (bmi < 18) {
      setState(() {
        bmiColor1 = Colors.red;
        bmiColor2=Color(0xFFE57373);

        bmiText = "Underweight";
      });
    } else if (bmi >= 18 && bmi < 25) {
      setState(() {
        bmiColor1 = Colors.green;
        bmiColor2=Color(0xFF81C784);
        bmiText = "Normal";
      });
    } else if (bmi >= 25 && bmi < 30) {
      setState(() {
        bmiColor1 = Colors.orange;
        bmiColor2=Color(0xFFFFB74D);
        bmiText = "Overweight";
      });
    } else {
      setState(() {
        bmiColor1 = Color(0xFFB71C1C);
        bmiColor2= Color(0xFFE53935);
        bmiText = "Obese";
        // imagePath="obese";
      });
    }
  }

  void addSubAge(bool AgeAdd) {
    if (AgeAdd) {
      setState(() {
        age++;
      });
    } else {
      setState(() {
        if (age > 1) {
          age--;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var SecondtitleText = widget.titleText;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: SecondtitleText, centerTitle: true),
      body: Center(
        child: GestureDetector(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    "Please Modify the values",
                    style: instractionTextStyle,
                  ),
                ),
              ),
              Expanded(
                flex: 18,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //age
                        Expanded(
                          flex: 3,
                          child: ReusableWidget(
                            heightSize: 150,
                            widthSize: 150,
                            color: weightColor,
                            borderColor: weightBorderColor,
                            cardChild: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Age", style: heightTxtStyle),
                                Container(
                                  margin: EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RoundButton(
                                        icon: FontAwesomeIcons.plus,
                                        onPressed: () {
                                          addSubAge(true);
                                          calculateBMI();
                                          UpdateUI();
                                        },
                                      ),
                                      Text("$age", style: ansTxtStyle),
                                      RoundButton(
                                        icon: FontAwesomeIcons.minus,
                                        onPressed: () {
                                          addSubAge(false);
                                          calculateBMI();
                                          UpdateUI();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        //weight
                        Expanded(
                          flex: 2,
                          child: ReusableWidget(
                            color: weightColor,
                            heightSize: 100,
                            widthSize: 150,
                            borderColor: weightBorderColor,
                            cardChild: Container(
                              margin: EdgeInsets.all(10.0),
                              child: Center(
                                child: TextField(
                                  controller: myController,
                                  obscureText: false,
                                  keyboardType: TextInputType.number,
                                  maxLines: 1,
                                  style: ansTxtStyle,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: strweightt,
                                    labelStyle: heightTxtStyle,
                                    hintText: strweightt,
                                    hintStyle: TextStyle(
                                      fontSize: 20,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      weight = int.parse(value);
                                      // print("Weight::${myController.text}");
                                      print("value::${value}");

                                      if ("Weight" != value) {
                                        print("Weight::$weight");
                                        calculateBMI();
                                        UpdateUI();
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        //bmi result
                        Expanded(
                          flex: 3,
                          child: ReusableWidget(
                            heightSize: 150,
                            widthSize: 150,
                            color: bmiColor1,
                            borderColor: weightBorderColor,
                            cardChild: Container(
                              height: 140,
                              width: 140,
                              decoration: BoxDecoration(
                                gradient: RadialGradient(
                                  // stops: [0.0,0.27,1.0],
                                 center: Alignment.center,
                                  radius: 1
                                  ,
                                  colors: [Colors.white,bmiColor1],
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("BMI", style: BMITitle),
                                  Text("$bmi", style: BMIResultStyle),
                                  Text(bmiText, style: BMITypeResultStyle),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //height
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Height(cm)", style: heightTxtStyle),
                              const SizedBox(height: 15.0),
                              ScaleRuler.lengthMeasurement(
                                fontSize: 10,
                                maxValue: 200,
                                minValue: 0,
                                initialValue: defaultHeight,
                                axis: Axis.vertical,
                                backgroundColor: Color(0xFFFBF6EE),
                                sliderActiveColor: Color(0xFFCE922A),
                                sliderInactiveColor: Color(0xFFC4C4C4),
                                onChanged: (ScaleValue? scaleValue) {
                                  if (mounted) {
                                    setState(() {
                                      _scaleValueCms = scaleValue;
                                      calculateBMI();
                                      UpdateUI();
                                    });
                                    debugPrint("${scaleValue?.cms} cms");
                                  }
                                },
                              ),
                              const SizedBox(height: 20.0),
                              Text(
                                "${_scaleValueCms?.cms ?? "0"} cms",
                                style: const TextStyle(fontSize: 18.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
                child: Container(
                  // margin: EdgeInsets.only(top: 150),
                  child: GestureDetector(
                    onTap: () {
                      age = 15;
                      defaultHeight = 100;
                      weight = 30;
                      strweightt = "Weight";
                      _scaleValueCms?.cms = 100;
                      myController.text = 30.toString();
                      calculateBMI();
                      UpdateUI();
                    },
                    child: ReusableWidget(
                      heightSize: 50,
                      color: Colors.green,
                      borderColor: Colors.green,
                      cardChild: Center(
                        child: Text(
                          "Reset",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.green[100],
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      widthSize: MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
              ),
            ],
          ),
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
    required this.widthSize,
  });

  Color? color;
  final Widget cardChild;
  Color borderColor;
  double heightSize;
  double widthSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightSize,
      width: widthSize,
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

class RoundButton extends StatelessWidget {
  const RoundButton({super.key, required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(icon, color: ageIconColor),
      onPressed: onPressed,
      elevation: 6.0,
      constraints: BoxConstraints(minWidth: 30, minHeight: 30),
      shape: CircleBorder(),
      fillColor: Colors.white,
    );
  }
}
