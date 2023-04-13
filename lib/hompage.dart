import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project1/profile/personal_info.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Text('Logged in'),
          ),
          Container(
            width: (MediaQuery.of(context).size.width) * 3 / 4,
            child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
                onPressed: () =>
                    Navigator.of(context).pushNamed(personal_info.routeName),
                child: Text('Build a resume')),
          ),
          Container(
            width: (MediaQuery.of(context).size.width) * 3 / 4,
            child: ElevatedButton.icon(
                style:
                    ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
                onPressed: () => FirebaseAuth.instance.signOut(),
                icon: Icon(
                  Icons.arrow_back,
                  size: 36,
                ),
                label: Text('Sign out')),
          )
        ],
      ),
    );
  }
}