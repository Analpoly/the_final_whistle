

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class FifaRanking {
  final String clubImage;
  final String clubName;
  final int rank;
  final int points;
  final int goalDifference;
  final int matches;

  FifaRanking({
    required this.clubImage,
    required this.clubName,
    required this.rank,
    required this.points,
    required this.goalDifference,
    required this.matches,
  });

  factory FifaRanking.fromJson(Map<String, dynamic> json) {
    return FifaRanking(
      clubImage: json['clubImage'] ?? '',
      clubName: json['clubName'] ?? '',
      rank: (json['rank'] ?? 0).toInt(),
      points: (json['points'] ?? 0).toInt(),
      goalDifference: (json['goalDifference'] ?? 0).toInt(),
      matches: (json['matches'] ?? 0).toInt(),
    );
  }
}

class FifaRankingsResponse {
  final List<FifaRanking> rankings;

  FifaRankingsResponse({
    required this.rankings,
  });

  factory FifaRankingsResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> teams = json['table'] ?? [];
    final rankings = teams.map((team) => FifaRanking.fromJson(team)).toList();

    return FifaRankingsResponse(rankings: rankings);
  }
}

class Tournament extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
// backgroundColor: Color.fromARGB(113, 51, 131, 132),
        backgroundColor: Color.fromARGB(224, 140, 188, 186),

        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            color: Color.fromARGB(219, 5, 80, 75),
            child: AppBar(
              title: Text(
                'Football',
                style: TextStyle(
                  color: Colors.white, // Change the color here
                ),
              ),
              backgroundColor:
                  Colors.transparent, // Make the app bar transparent
              elevation: 0, // Remove the shadow
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            'images/ev2.png',
                            height: 60,
                            width: 60,
                          ),
                          Text(
                            ' FC Everton',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            ' Bressan 10\'',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            ' Raniele 68\'',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Text(
                            '2-2',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Finished',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Image.asset(
                            'images/li2.png',
                            height: 60,
                            width: 60,
                          ),
                          Text(
                            'FC Liverpool',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            ' Luiz Felipe 50\'',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                            ),
                          ),
                          Text(
                            ' Carlos Sanchez 70\'',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            TabBar(
              labelColor: Colors.white,
              tabs: [
                Tab(
                  text: 'STANDINGS',
                ),
                Tab(
                  text: 'LINEUPS',
                ),
              ],
              indicatorColor: Color.fromARGB(
                  255, 33, 86, 65), // Set tab indicator color here
            ),
            Expanded(
              child: TabBarView(
                children: [
                  FifaRankingsPage(),
                  AnotherTabPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnotherTabPage extends StatefulWidget {
  @override
  _AnotherTabPageState createState() => _AnotherTabPageState();
}

class _AnotherTabPageState extends State<AnotherTabPage> {
  late Future<Autogenerated> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  Future<Autogenerated> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('https://footapi7.p.rapidapi.com/api/match/10114139/lineups'),
        headers: {
          'x-rapidapi-host': 'footapi7.p.rapidapi.com',
          'x-rapidapi-key':
              '6f8f212fa7msh661c1dad7e67ffbp11eee3jsnd1980e109e13', // Replace with your RapidAPI key
        },
      );

      if (response.statusCode == 200) {
        return Autogenerated.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Autogenerated>(
      future: futureData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final data = snapshot.data!;
          return Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    // Add space below the "Lineup" label
                    Expanded(
                      child: ListView.builder(
                        itemCount: data.home?.players?.length ?? 0,
                        itemBuilder: (context, index) {
                          final homePlayer = data.home!.players![index].player!;
                          final awayPlayer = data.away!.players![index].player!;
                          final homePlayerRating =
                              data.home!.players![index].statistics?.rating;
                          final awayPlayerRating =
                              data.away!.players![index].statistics?.rating;

                          // Check if it's time to display the "Substitution" label
                          if (index == 0) {
                            return Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Lineups',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white70),
                                ),
                              ),
                            );
                          }
                          if (index == 12) {
                            return Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Substitutions',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white70),
                                ),
                              ),
                            );
                          }

                          // Display players based on their position in the lineup
                          return Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors
                                          .blue, // Choose your desired color
                                      child: Text(
                                        '${homePlayerRating ?? "N/A"}',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            8), // Add space below the avatar
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        '${homePlayer.name}',
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                    ),
                                    SizedBox(
                                        height: 16), // Add space below the name
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors
                                          .blue, // Choose your desired color
                                      child: Text(
                                        '${awayPlayerRating ?? "N/A"}',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            8), // Add space below the avatar
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text('${awayPlayer.name}',
                                          style:
                                              TextStyle(color: Colors.white70)),
                                    ),
                                    SizedBox(
                                        height: 16), // Add space below the name
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        } else {
          return Center(child: Text('No data available'));
        }
      },
    );
  }
}

class Autogenerated {
  bool? confirmed;
  Home? home;
  Home? away;

  Autogenerated({this.confirmed, this.home, this.away});

  factory Autogenerated.fromJson(Map<String, dynamic> json) {
    return Autogenerated(
      confirmed: json['confirmed'],
      home: json['home'] != null ? Home.fromJson(json['home']) : null,
      away: json['away'] != null ? Home.fromJson(json['away']) : null,
    );
  }
}

class Home {
  List<Players>? players;

  Home({this.players});

  factory Home.fromJson(Map<String, dynamic> json) {
    return Home(
      players: json['players'] != null
          ? List<Players>.from(json['players'].map((x) => Players.fromJson(x)))
          : null,
    );
  }
}

class Players {
  Player? player;
  Statistics? statistics;

  Players({this.player, this.statistics});

  factory Players.fromJson(Map<String, dynamic> json) {
    return Players(
      player: json['player'] != null ? Player.fromJson(json['player']) : null,
      statistics: json['statistics'] != null
          ? Statistics.fromJson(json['statistics'])
          : null,
    );
  }
}

class Player {
  String? name;

  Player({this.name});

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      name: json['name'],
    );
  }
}

class Statistics {
  double? rating;

  Statistics({this.rating});

  factory Statistics.fromJson(Map<String, dynamic> json) {
    return Statistics(
      rating: json['rating'] is int
          ? (json['rating'] as int).toDouble()
          : json['rating'],
    );
  }
}



class FifaRankingsPage extends StatefulWidget {
  @override
  _FifaRankingsPageState createState() => _FifaRankingsPageState();
}

class _FifaRankingsPageState extends State<FifaRankingsPage> {
  late Future<FifaRankingsResponse> futureRankings;

  @override
  void initState() {
    super.initState();
    setState(() {
      futureRankings = fetchFifaRankings();
    });
  }

  Future<FifaRankingsResponse> fetchFifaRankings() async {
    final response = await http.get(
      Uri.parse(
          'https://transfermarket.p.rapidapi.com/competitions/get-table?id=GB1&seasonID=2020'),
      headers: {
        'x-rapidapi-key': '1276b1c07fmshe6f361c7e7fa3e3p1b228ejsn798abaf7accf',
        'x-rapidapi-host': 'transfermarket.p.rapidapi.com',
      },
    );

    if (response.statusCode == 200) {
      return FifaRankingsResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load FIFA rankings');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<FifaRankingsResponse>(
        future: futureRankings,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.rankings.length,
              itemBuilder: (context, index) {
                var ranking = snapshot.data!.rankings[index];
                return Card(
                  color: Color.fromARGB(240, 93, 132, 149),
                  child: ListTile(
                    leading:
                        Image.network(ranking.clubImage), // Display club image
                    title: Text(
                      '${ranking.clubName}',
                      style: TextStyle(color: Colors.white70),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Rank: ${ranking.rank}',
                            style: TextStyle(color: Colors.white70)),
                        Text('Points: ${ranking.points}',
                            style: TextStyle(color: Colors.white70)),
                        Text('Goal Difference: ${ranking.goalDifference}',
                            style: TextStyle(color: Colors.white70)),
                        Text('Matches Played: ${ranking.matches}',
                            style: TextStyle(color: Colors.white70)),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }
}
