import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'UserDataClass.dart';

/*
The http.get() method returns a Future that contains a Response.

Future is a core Dart class for working with async operations. A Future object represents a potential value or error that will be available at some time in the future.
The http.Response class contains the data received from a successful http call.
*/

Future<UserDataClass> fetchUserDataByGetApiCall() async {
  final response = await http.get('https://reqres.in/api/users/2');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return UserDataClass.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

void main() => runApp(MyApp(userDataCall: fetchUserDataByGetApiCall()));

class MyApp extends StatelessWidget {
  final Future<UserDataClass> userDataCall;

  MyApp({Key key, this.userDataCall}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data by Rest Api Call'),
        ),
        body: Center(
          child: FutureBuilder<UserDataClass>(
            future: userDataCall,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: <Widget>[
                    Text(snapshot.data.userId.toString() ??
                        'Successful call but Unknown Result'),
                    Text(snapshot.data.email ??
                        'Successful call but Unknown Result'),
                    Text(snapshot.data.firstName ??
                        'Successful call but Unknown Result'),
                    Text(snapshot.data.lastName ??
                        'Successful call but Unknown Result'),
                    Image.network(snapshot.data.avatar),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text(
                    "${snapshot.error}" ?? 'Call failed  but Unknown Result');
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
