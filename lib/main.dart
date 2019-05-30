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
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of(context);

    Widget body;
    if (authProvider.isAuthenticated) {
      body = Center(
        child: Text(
          "User Authenticated\n\n${authProvider.isAnonymous ?
            "Anonymous" : "From - Facebook / Google / Email"}",
          textAlign: TextAlign.center,
        ),
      );
    } else {
      body = Center(
        child: Text("No authentication"),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: body,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              authProvider.signInAnonymously();
            },
            tooltip: 'Sign In Anonymously',
            child: Icon(Icons.account_circle),
          ),
          SizedBox(
            height: 12,
          ),
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
