import 'dart:async';
import 'package:avatar_glow/avatar_glow.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe/screens/homescreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 4), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: Center(child: Image.asset('assets/logo.png')),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          AvatarGlow(
            endRadius: 140,
            duration: Duration(seconds: 3),
            glowColor: Colors.white,
            repeat: true,
            repeatPauseDuration: Duration(seconds: 1),
            startDelay: Duration(seconds: 1),
            child: Text(
              "Let's Play",
              style: GoogleFonts.lobster(color: Colors.white, fontSize: 30),
            ),
          )
        ],
      ),
    );
  }
}
