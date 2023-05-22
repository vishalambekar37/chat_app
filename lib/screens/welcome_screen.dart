import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';

import '../components/log_reg_file.dart';
// import 'package:animated_text_kit/animated_text_kit.dart';

// import 'components/log_reg_file.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  @override
  // ignore: library_private_types_in_public_api
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

// we use for animation. also add (below with SingleTickerProviderStateMixin)
class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  // late Animation animation;
  ColorTween _colorTween = ColorTween(begin: Colors.red, end: Colors.blue);
  AnimationController? _animationController;

  @override
  void iniState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5))
          ..repeat();
    _animationController?.addListener(() {
      print(_animationController?.value);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // this use to animation like color see bright to dark color.
      // backgroundColor: Color(0xFF13EFF7),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              _colorTween.evaluate(
                AlwaysStoppedAnimation(_animationController?.value ?? 0),
              ),
              Colors.white,
            ].map((color) => color as Color).toList(),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('assets/images/flash_logo.png'),
                      height: 50,
                    ),
                  ),
                  Container(
                    child: DefaultTextStyle(
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w900,
                            color: Colors.black),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText('💎FLASH CHAT'),
                          ],
                          //  child: Text('💎FLASH CHAT') ,
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 48.0,
              ),
              log_reg_screen(
                color: Colors.lightBlue,
                pagename: LoginScreen.id,
                text: ('login'),
              ),
              log_reg_screen(
                color: Colors.blue,
                pagename: RegistrationScreen.id,
                text: ('register'),
              )
            ],
          ),
        ),
      ),
    );
  }
}


// // import 'package:flutter/material.dart';

// // class WelcomeScreen extends StatefulWidget {
// //   @override
// //   _WelcomeScreenState createState() => _WelcomeScreenState();
// // }

// // class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin{

// //   late Animation animation;
// //   late AnimationController animationController;

// //   @override
// //   void initState() {
// //     super.initState();
// //     animationController = AnimationController(vsync: this,
// //     duration: Duration(seconds: 2));
// //     animation = CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn);

// //     animation.addListener(() {
// //       setState(() {
// //         print(animationController.value);
// //       });
// //     });

// //    animation.addStatusListener((status) {
// //      if (status == AnimationStatus.completed){
// //        animationController.reverse();
// //      }
// //    });

// //     animationController.forward();
// //   }
// //   @override
// //   void dispose() {

// //     super.dispose();
// //     animationController.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text("Animation App")),
// //       body: Center(
// //         child: Container(
// //           height: (animationController.value*100)+50,
// //           width: (animationController.value*100)+50,
// //           child: FlutterLogo(),
// //         ),
// //       ),

// //     );
// //   }
// // }



// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

// class WelcomeScreen extends StatefulWidget {
//   const WelcomeScreen({super.key});
//   static String id = 'Welcome_Screen';
//   @override
//   State<WelcomeScreen> createState() => _WelcomeScreenState();
// }

// class _WelcomeScreenState extends State<WelcomeScreen> {
//   var myOpacity = 0.0;
//   @override
//   void initState() {
//     // TODO: implement initState
//     Timer(
//       Duration(seconds: 2),
//       () => setState(() {
//         myOpacity = 1.0;
//       }),
//     );
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: AnimatedOpacity(
//           duration: const Duration(seconds: 1),
//           opacity: myOpacity,
//           child: Container(
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             color: Colors.blue,
//           )),
//     );
//   }
// }
