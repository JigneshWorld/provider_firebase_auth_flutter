import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String title = 'Auth Provider Demo';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          builder: (_) {
            return AuthProvider();
          },
        )
      ],
      child: MaterialApp(
        title: title,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: title),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of(context);

    Widget body;
    if (authProvider.isAuthenticated) {
      body = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/welcome.png'),
          SizedBox(height: 32,),
          Text(
            "Welcome to the world\nClick on floating action autton to sign out.",
            textAlign: TextAlign.center,
          ),
        ],
      );
    } else {
      body = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/login.png'),
          SizedBox(height: 32,),
          Text(
            "Login to continue\nClick on floating action button to sign in anonymously.",
            textAlign: TextAlign.center,
          ),
        ],
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: body,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          if (!authProvider.isAuthenticated)
            FloatingActionButton(
              onPressed: () {
                authProvider.signInAnonymously();
              },
              tooltip: 'Sign In Anonymously',
              child: Icon(Icons.account_circle),
            ),
          if (authProvider.isAuthenticated)
            FloatingActionButton(
              onPressed: () {
                authProvider.signOut();
              },
              tooltip: 'Sign Out',
              child: Icon(Icons.exit_to_app),
            )
        ],
      ),
    );
  }
}
