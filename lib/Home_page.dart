import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:msocial_scanner_app/Event_details.dart';
import 'package:msocial_scanner_app/loginScreen.dart';
import 'models/PostsModels.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List<Data> postList = [];
  Future<List<>> getPostApi() async {
    final response = await http.get(Uri.parse(
        'https://api.msocialin.com/api/Authontication_Controller/event_list'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        postList.add(PostsModels.fromJson(i));
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Color.fromRGBO(253, 113, 112, 1),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPostApi(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: postList.length,
                      itemBuilder: (context, index) {
                        return Container(
                            margin: EdgeInsets.all(20),
                            height: 200,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                        postList[index].cover.toString(),
                                        // "assets/logo.png",
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    height: 160,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                                        gradient: LinearGradient(
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                            colors: [
                                              Colors.black.withOpacity(0.8),
                                              Colors.transparent
                                            ])),
                                  ),
                                ),
                                Positioned(
                                  bottom: 50,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 10),
                                        Text(
                                          postList[index].name.toString(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 20,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 10),
                                        Text(
                                          postList[index].startDate.toString(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 11),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ));
                        // Text(postList[index].startDate.toString());
                      });
                } else {
                  return const Text("Loading");
                }
              },
            ),
          ),
        ],
      ),
      drawer: const NavigationDrawer(),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context),
              buildMenuItem(context),
            ],
          ),
        ),
      );
  Widget buildHeader(BuildContext context) => Container(
        color: const Color.fromRGBO(119, 14, 45, 1),
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        child: Column(
          children: const [
            SizedBox(height: 5),
            Icon(Icons.person, size: 120),
            SizedBox(height: 0),
            Text(
              "MOTHER",
              style: TextStyle(fontSize: 16, color: Colors.white, height: 2),
            ),
            Text(
              'Mothering Events',
              style: TextStyle(fontSize: 16, color: Colors.white, height: 1),
            ),
            SizedBox(height: 10),
          ],
        ),
      );
  Widget buildMenuItem(BuildContext context) => Container(
      padding: const EdgeInsets.all(2),
      child: Wrap(
        runSpacing: 6,
        children: [
          ListTile(
            leading: const Icon(Icons.event_rounded),
            title: const Text('Events'),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const EventDetails(),
            )),
          ),
          const Divider(color: Color.fromRGBO(119, 14, 45, 1)),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => SignUpScreen(),
              ),
            ),
          ),
        ],
      ));
}
