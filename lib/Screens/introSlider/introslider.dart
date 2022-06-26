import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intro_slider/intro_slider.dart';

import 'package:translationchat/Screens/auth/login.dart';
import 'package:translationchat/constants/colors.dart';

import 'package:translationchat/shared/text_global.dart';
import 'package:translationchat/utils/sharedprefence.dart';



class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);



  @override
  IntroScreenState createState() => new IntroScreenState();
}


class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = [];
  List <String> text=["communicate with the world by you language  تواصل مع العالم  بلغتك ",
    "write in your language and send their language                       اكتب بلغتك وارسلها بلغتهم",
    "ايزي توك يجعل التواصل بكل لغات بين يديك      EasyTalk puts communication in all languages ​​at your fingertips "];

    @override
  void initState() {
    super.initState();
for(int i=0;i<3;i++) {
  slides.add(
      Slide(


        pathImage: "assests/ic_launcher.png",
        description:
        text[i],

        styleDescription:
         GoogleFonts.cairo(
            color: Colors.black,
            fontWeight:  FontWeight.bold,
            fontSize: 16,
          ),


backgroundColor: Colors.white,

        directionColorBegin: Alignment.topLeft,
        directionColorEnd: Alignment.bottomRight,
        onCenterItemPress: () {},
      ),
    );
}


  }

  Future<void> onDonePress() async {
    // Do what you want
    await SharedPreferenceHandler.setIntro();
     Navigator.push(
       context,
       MaterialPageRoute(builder: (context) => Login()),
     );
  }

  Widget renderNextBtn() {
    return  textGlobalWhiteBold14(context: context,text: "تخطي");
  }

  Widget renderDoneBtn() {

    return textGlobalWhiteBold14(context: context,text: "انهاء");
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: white,
    );
  }

  ButtonStyle myButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
      backgroundColor: MaterialStateProperty.all<Color>(darkCyan),
      overlayColor: MaterialStateProperty.all<Color>(darkCyan),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  IntroSlider(
      // List slides
      slides: this.slides,




      // Next button
      renderNextBtn: this.renderNextBtn(),
      nextButtonStyle: myButtonStyle(),

      // Done button
      renderDoneBtn: this.renderDoneBtn(),
      onDonePress: this.onDonePress,
      doneButtonStyle: myButtonStyle(),

      // Dot indicator
      colorDot:greyDark,
      colorActiveDot: darkCyan,
      sizeDot: 13.0,


      // Show or hide status bar
   //   hideStatusBar: true,
      backgroundColorAllSlides: Colors.white,

      // Scrollbar
      verticalScrollbarBehavior: ScrollbarBehavior.SHOW_ALWAYS,
    );
  }
}