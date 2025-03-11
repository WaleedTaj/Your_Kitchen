import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:your_kitchen/home.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  @override
  void initState() {
    super.initState();
    // Navigate to another page after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff213A50),
              Color(0xff071938),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 200),
                Image.asset(
                  "assets/images/image3.png",
                  height: 170,
                  width: 170,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Your Kitchen",
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'AsapCondensed',
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Made By Waleed Taj",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),
                const SpinKitWaveSpinner(
                  color: Colors.white,
                  size: 50.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
