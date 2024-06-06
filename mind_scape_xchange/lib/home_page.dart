import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'activity_atlas.dart';
import 'community_spotlight.dart';
import 'educareer.dart';
import 'marketing_mavericks.dart';
import 'profile.dart';
import 'blogposts_container.dart';
import 'login_screen.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      if (selectedIndex == 0) {
        // Navigate to Activity Atlas screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ActivityAtlasScreen(),
          ),
        );
      } else if (selectedIndex == 1) {
        // Navigate to EduCareer Hub screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EduCareerHubScreen(),
          ),
        );
      } else if (selectedIndex == 2) {
        // Navigate to Community Spotlight screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CommunitySpotlightScreen(),
          ),
        );
      } else if (selectedIndex == 3) {
        // Navigate to Marketing Mavericks screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MarketingMavericksScreen(),
          ),
        );
      }
    });
  }

  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MsX'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  selectedIndex = 0;
                });
              },
            ),
            ListTile(
              title: Text('Favorites'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  selectedIndex = 1;
                });
              },
            ),
            ListTile(
              title: Text('Logout'), // logout option
              onTap: _logout, // Calls the _logout function
            )
          ],
        ),
      ),
      body: Center(
        child: LayoutBuilder(builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Heading 1',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: constraints.maxWidth * 0.8,
                height: 150,
                decoration: BoxDecoration(
                  color: Color.fromARGB(
                      255, 202, 75, 192), // Move the color property here
                  borderRadius: BorderRadius.circular(
                      15), // Adjust the radius for smooth edges
                ),
                padding: EdgeInsets.all(20),
              ),
              SizedBox(height: 16),
              Container(
                width: constraints.maxWidth * 0.8,
                height: 150,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(
                      84, 160, 190, 1), // Move the color property here
                  borderRadius: BorderRadius.circular(
                      15), // Adjust the radius for smooth edges
                ),
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        child: Align(
                      alignment: Alignment.centerLeft,
                      // Add functionality for the first floating action button
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MarketingMavericksScreen(),
                            ),
                          );
                        },
                        tooltip: 'FAB 1',
                        heroTag: 'fab1', // Unique hero tag for the first FAB
                        child: Icon(Icons.add),
                      ),
                    )),
                    Expanded(
                        child: Align(
                      alignment: Alignment.centerRight,
                      // Add functionality for the second floating action button
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MarketingMavericksScreen(),
                            ),
                          );
                        },
                        tooltip: 'FAB 2',
                        heroTag: 'fab2', // Unique hero tag for the second FAB
                        child: Icon(Icons.edit),
                      ),
                    ))
                  ],
                ),
              ),
              SizedBox(height: 20),
              BlogPostsContainer(), // Use of the BlogPostsContainer
            ],
          );
        }),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_run),
            label: 'Activity Atlas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'EduCareer Hub',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Community Spotlight',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insights),
            label: 'Marketing Mavericks',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileScreen()),
          );
        },
        tooltip: 'Profile',
        heroTag: 'profile', // Unique hero tag for the third FAB
        child: Icon(Icons.person),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
