import 'package:flutter/material.dart';

class covidHome extends StatefulWidget {

  @override
  _covidHomeState createState() => _covidHomeState();
}

class _covidHomeState extends State<covidHome> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index : Accueil',
      style: optionStyle,
    ),
    Text(
      'Index : Centres de vaccination',
      style: optionStyle,
    ),
    Text(
      'Index : Conseil',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text('Covid Project',
        ),
      ),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                 child: Center(
                    child: Column(
                      children: <Widget>[
                         new UserAccountsDrawerHeader(
                            decoration: BoxDecoration(color: Colors.white),
                            currentAccountPicture: new CircleAvatar(
                              radius: 30.0,
                              backgroundColor: Colors.blueAccent,
                             ),
                          ),
                         ],
                      ),
                 ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ListTile(
                title: const Text('Accueil'),
                onTap: () {

                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Paramètres'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Contact'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('à propose'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Centres de vaccination',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Conseil ',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent[800],
        onTap: _onItemTapped,
      ),
      );
  }
}
