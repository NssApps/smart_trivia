
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    FlutterNativeSplash.remove();

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration( 
                gradient: LinearGradient( 
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFB063C0), 
                    Color(0xFFB195F9), 
                    Colors.white
                    ], 
                ), 
              ), 
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),

                  const Text('Welcome',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white
                    ),
                  ),

                  Image.asset('assets/img/logo.png', width: 300,),

                  const SizedBox(height: 20,),

                  Text('Are you ready?', style: Theme.of(context).textTheme.titleLarge,),
      
                  const Spacer(),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: FilledButton(
                      style:  ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 245, 130, 70)),
                      onPressed: () {
                      
                        context.go('/trivia/create');
                      }, 
                      child: const Text('Get Started'),
                      
                    ),
                  ),

                  const SizedBox(height: 50,),
                ],
              ),
          )
        ],
      ),
    );
  }
}