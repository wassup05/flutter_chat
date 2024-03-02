import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/authservice.dart';
import 'package:flutter_application_1/shared/loading.dart';

//get started screen

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    PageController _controller = PageController();

    return (loading)
        ? const Loading()
        : PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _controller,
            children: [
                Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.deepPurple[200],
                  ),
                  body: Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 60,
                        ),
                        Text(
                          'Welcome to Medos!!',
                          style: TextStyle(
                              fontSize: 25,
                              fontStyle: FontStyle.italic,
                              color: Colors.blue[200]),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'We are very happy and excited to have you here',
                          style: TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                              color: Colors.blue[100]),
                        ),
                        const SizedBox(
                          height: 45,
                        ),
                        Image.asset(
                          'assets/ic_launcher.png',
                        ),
                        const SizedBox(
                          height: 90,
                        ),
                        TextButton(
                          style: ButtonStyle(
                              fixedSize:
                                  const MaterialStatePropertyAll(Size(200, 50)),
                              backgroundColor: MaterialStatePropertyAll(
                                  Colors.deepPurple[200])),
                          onPressed: () {
                            _controller.nextPage(
                                duration: const Duration(milliseconds: 150),
                                curve: Curves.easeIn);
                          },
                          child: const Text(
                            'Get Started',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.deepPurple[200],
                  ),
                  body: Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 60,
                        ),
                        Text(
                          'Consider Signing In',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.blue[300],
                              fontStyle: FontStyle.italic),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Image.asset(
                          'assets/ic_launcher.png',
                        ),
                        const SizedBox(
                          height: 90,
                        ),
                        TextButton(
                          style: ButtonStyle(
                              fixedSize:
                                  const MaterialStatePropertyAll(Size(250, 50)),
                              backgroundColor: MaterialStatePropertyAll(
                                  Colors.deepPurple[200])),
                          onPressed: () async {
                            setState(() {
                              loading = false;
                            });
                            await AuthService().signInWithGoogle();
                          },
                          child: const Text(
                            'Sign In With Google',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ]);
  }
}
