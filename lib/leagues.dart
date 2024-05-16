import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_final_whistle/fifa.dart';
import 'package:the_final_whistle/matches.dart';
import 'package:the_final_whistle/tournament.dart';
import 'package:the_final_whistle/uefa.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Football Matches',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        backgroundColor: Colors.red[200], // Set background color here
        body: MyWidget2(),
      ),
    );
  }
}


class MyWidget2 extends StatefulWidget {
  @override
  State<MyWidget2> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget2> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text("Football",  style: TextStyle(
              color: Colors.white, // Change the color here
            ),),
backgroundColor: Color.fromARGB(219, 5, 80, 75),
       
      ),
      body: _selectedIndex == 0 ? MatchesPage() : MyApp2(),
      floatingActionButton: _selectedIndex == 0
  ? FloatingActionButton(
      onPressed: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', false);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Dark7()),
        );
      },
      child: Icon(Icons.logout),
    )
  : null,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(219, 5, 80, 75),

        // backgroundColor: Colors.green[700],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.lock_clock_outlined),
            label: 'Matches',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stacked_bar_chart),
            label: 'Leagues',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}

class MatchesPage extends StatefulWidget {
  @override
  _MatchesPageState createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  List<PlayDayMatches>? _matches;
  bool _isLoading = false;
  bool _isPinnedLeagueVisible = true;
  bool _isIconUpwards = true;

  @override
  void initState() {
    super.initState();
    _fetchMatches();
  }

  Future<void> _fetchMatches() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse(
            'https://transfermarket.p.rapidapi.com/matches/list-by-game-plan?seasonID=2020&leagueID=GB1&dayID=5'),
        headers: {
          'x-rapidapi-key':
              '731882f858mshcebef05f30b510cp13db04jsn12dd2904e178',
          'x-rapidapi-host': 'transfermarket.p.rapidapi.com',
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _matches = List<PlayDayMatches>.from(data['playDayMatches']
              .map((x) => PlayDayMatches.fromJson(x)));
        });
      } else {
        throw Exception(
            'Failed to load matches: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to load matches: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Color.fromARGB(84, 59, 206, 14), // Light neutral background color for the body
// backgroundColor:Color.fromARGB(255, 239, 236, 236),
backgroundColor: Color.fromARGB(113, 51, 131, 132),
      body: Column(
        children: [
          SizedBox(
            height: 160.0,
            child: CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                height: 155.0,
                aspectRatio: 10/10,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.4,
              ),
              items: [
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                      image: AssetImage("images/maa.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                      image: AssetImage("images/mat.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Recent Matches",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Color.fromARGB(205, 17, 135, 225)),
                ),
              ),
              IconButton(
                icon: _isIconUpwards ? Icon(Icons.arrow_upward) : Icon(Icons.arrow_downward),
                onPressed: () {
                  setState(() {
                    _isPinnedLeagueVisible = !_isPinnedLeagueVisible;
                    _isIconUpwards = !_isIconUpwards;
                  });
                },
              ),
            ],
          ),
          if (_isPinnedLeagueVisible)
            Column(
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Text("England",style: TextStyle(color: Color.fromARGB(255, 25, 126, 146)),),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_right),
                    ),
                    Padding(
                      padding: EdgeInsets.only(),
                      child: Text("Premier League",style: TextStyle(color: Color.fromARGB(255, 25, 126, 146)),),
                    )
                  ],
                ),
              ],
            ),
 Expanded(
  child: _isPinnedLeagueVisible
      ? _isLoading
          ? Center(child: CircularProgressIndicator())
          : _matches == null
              ? Center(child: Text('No matches available'))
              : ListView.builder(
                  itemCount: _matches!.length,
                  itemBuilder: (context, index) {
                    final match = _matches![index];
                    return GestureDetector(
                      onTap: () {
                        if (index == 0) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Tournament(),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MatchDetailsPage(match: match),
                            ),
                          );
                        }
                      },
                      child: Card(
                        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        child: Container(
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Color.fromARGB(240, 93, 132, 149),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ListTile(
                            title: Text(
                                '${match.homeClubName} vs ${match.awayClubName}',
                                style: TextStyle(color: Colors.white)), // Change text color here
                            subtitle: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(match.matchTime ??
                                    'No time available',
                                    style: TextStyle(color: Colors.white)), // Change text color here
                                SizedBox(height: 4),
                                Text(
                                    'Goals: ${match.resultObject?.goalsHome ?? 'N/A'} - ${match.resultObject?.goalsAway ?? 'N/A'}',
                                    style: TextStyle(color: Colors.white)), // Change text color here
                              ],
                            ),
                            leading: Image.network(
                                match.homeClubImage ?? ''),
                            trailing: Image.network(
                                match.awayClubImage ?? ''),
                          ),
                        ),
                      ),
                    );
                  },
                )
      : Container(),
),




        ],
      ),
    );
  }
}

// Define a Match class to hold match data
class Match {
  final String homeClubName;
  final String awayClubName;
  final String? matchTime;

  Match({
    required this.homeClubName,
    required this.awayClubName,
    this.matchTime,
  });
}


class MatchDetailsPage extends StatelessWidget {
  final PlayDayMatches match;

  MatchDetailsPage({required this.match});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Color.fromARGB(224, 140, 188, 186),

      appBar: AppBar(backgroundColor: Color.fromARGB(219, 5, 80, 75),

        title: Text('Match Details',style: TextStyle(color: Colors.white),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Match Details',
              style: TextStyle(fontSize: 24,color: Colors.white70),
            ),
            SizedBox(height: 20),
            Text('Home Club: ${match.homeClubName ?? 'N/A'}',style: TextStyle(color: Colors.white70),),
            Text('Away Club: ${match.awayClubName ?? 'N/A'}',style: TextStyle(color: Colors.white70)),
            Text('Match Time: ${match.matchTime ?? 'N/A'}',style: TextStyle(color: Colors.white70)),
            // You can display more details here based on your requirements
          ],
        ),
      ),
    );
  }
}


class PlayDayMatches {
  String? competitionName;
  String? competitionImage;
  String? matchTime;
  String? homeClubName;
  String? homeClubImage;
  String? awayClubName;
  String? awayClubImage;
  ResultObject? resultObject;

  PlayDayMatches({
    this.competitionName,
    this.competitionImage,
    this.matchTime,
    this.homeClubName,
    this.homeClubImage,
    this.awayClubName,
    this.awayClubImage,
    this.resultObject,
  });

  factory PlayDayMatches.fromJson(Map<String, dynamic> json) {
    return PlayDayMatches(
      competitionName: json['competitionName'],
      competitionImage: json['competitionImage'],
      matchTime: json['matchTime'],
      homeClubName: json['homeClubName'],
      homeClubImage: json['homeClubImage'],
      awayClubName: json['awayClubName'],
      awayClubImage: json['awayClubImage'],
      resultObject: json['resultObject'] != null
          ? ResultObject.fromJson(json['resultObject'])
          : null,
    );
  }
}

class ResultObject {
  String? goalsHome;
  String? goalsAway;

  ResultObject({
    this.goalsHome,
    this.goalsAway,
  });

  factory ResultObject.fromJson(Map<String, dynamic> json) {
    return ResultObject(
      goalsHome: json['goalsHome'],
      goalsAway: json['goalsAway'],
    );
  }
}

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return WillPopScope(
      onWillPop: () async {
        // Navigate back to MatchesPage when the back button is pressed
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyWidget2()),
        );
        // Return true to indicate that the back button action has been handled
        return true;
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(113, 51, 131, 132),

        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LeaguesPage(),
            Expanded(
              child: FutureBuilder<CategoryList>(
                future: fetchCategories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Error: ${snapshot.error}"),
                    );
                  } else {
                    return LeaguesList(categories: snapshot.data!.categories);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LeaguesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                  Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Fifa(),
                            ),
                          );
                // Handle tap on FIFA image
              },
              child: Container(
                width: 100,
                height: 100,
                color:  Color.fromARGB(0, 51, 131, 132),


                child: Image.asset(
                  'images/fifa2.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(width: 50),
            GestureDetector(
              onTap: () {
                  Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Uefa(),
                            ),
                          );
                // Handle tap on UEFA image
              },
              child: Container(
                width: 100.0,
                height: 100.0,
                color:  Color.fromARGB(0, 51, 131, 132),

                child: Image.asset(
                  'images/uefa4.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 70),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Selected Categories',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                
                ],
              ),
              Text(
                'Categories you want to see first',
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(132, 44, 38, 38),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}

class Category {
  final String name;
  final String flag;
  bool isExpanded; // Add isExpanded property

  Category({required this.name, required this.flag, this.isExpanded = false});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'],
      flag: json['flag'],
    );
  }
}


class CategoryList {
  final List<Category> categories;

  CategoryList({required this.categories});

  factory CategoryList.fromJson(List<dynamic> json) {
    return CategoryList(
      categories: json.map((categoryJson) => Category.fromJson(categoryJson)).toList(),
    );
  }
}

class LeaguesList extends StatefulWidget {
  final List<Category> categories;

  LeaguesList({required this.categories});

  @override
  _LeaguesListState createState() => _LeaguesListState();
}

class _LeaguesListState extends State<LeaguesList> {
  late List<Category> _categories;

  @override
  void initState() {
    super.initState();
    _categories = widget.categories;
    // Load saved order from SharedPreferences
    _loadOrder();
  }

  // Load saved order from SharedPreferences
  void _loadOrder() async {
    final prefs = await SharedPreferences.getInstance();
    final order = prefs.getStringList('category_order');
    if (order != null) {
      setState(() {
        _categories.sort((a, b) => order.indexOf(a.name).compareTo(order.indexOf(b.name)));
      });
    }
  }

  // Save current order to SharedPreferences
  void _saveOrder() async {
    final prefs = await SharedPreferences.getInstance();
    final order = _categories.map((category) => category.name).toList();
    prefs.setStringList('category_order', order);
  }

 
@override
Widget build(BuildContext context) {
  return ListView( // Wrap ReorderableListView inside a ListView
    shrinkWrap: true,
    children: [
      ReorderableListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) {
          final category = _categories[index];
         return Container(
          width: 5,
          decoration: BoxDecoration(    borderRadius: BorderRadius.vertical(),  color: index % 2 == 0 ?  Color.fromARGB(240, 93, 132, 149) : Color.fromARGB(147, 93, 132, 149), 

),
  key: ValueKey(category.name),
  padding: EdgeInsets.all(10), // Add padding for spacing
  // color: index % 2 == 0 ?  Color.fromARGB(240, 93, 132, 149) : Color.fromARGB(147, 93, 132, 149), // Alternate colors
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ListTile(
        title: Text(category.name),
        trailing: Icon(Icons.keyboard_arrow_down), // Add down arrow icon
        onTap: () {
          setState(() {
            // Toggle the visibility of the container
            category.isExpanded = !category.isExpanded;
          });
        },
      ),
      if (category.isExpanded) // Show the container if expanded
        Container(
          padding: EdgeInsets.all(8.0),
          // color: Colors.grey[300],
          child: Text(
            'Additional content for ${category.name}',
            style: TextStyle(fontSize: 14.0),
          ),
        ),
    ],
  ),
);

        },
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            final Category item = _categories.removeAt(oldIndex);
            _categories.insert(newIndex, item);
            _saveOrder(); // Save the order when reordering
          });
        },
      ),
    ],
  );
}


}

Future<CategoryList> fetchCategories() async {
  final response = await http.get(
    Uri.parse('https://sofascore.p.rapidapi.com/categories/list'),
    headers: {
      "x-rapidapi-host": "sofascore.p.rapidapi.com",
      "x-rapidapi-key": "1276b1c07fmshe6f361c7e7fa3e3p1b228ejsn798abaf7accf"
    },
  );

  if (response.statusCode == 200) {
    return CategoryList.fromJson(jsonDecode(response.body)['categories']);
  } else {
    throw Exception('Failed to load categories');
  }
}
