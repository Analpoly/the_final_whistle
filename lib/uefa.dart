import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Model class for club rankings
class FifaRanking {
  final String rowName;
  final int ranking;
  final int points;

  FifaRanking({
    required this.rowName,
    required this.ranking,
    required this.points,
  });

  factory FifaRanking.fromJson(Map<String, dynamic> json) {
    return FifaRanking(
      rowName: json['rowName'] ?? '',
      ranking: (json['ranking'] ?? 0).toInt(),
      points: (json['points'] ?? 0).toInt(),
    );
  }
}

// Response model class for club rankings
class FifaRankingsResponse {
  final List<FifaRanking> rankings;

  FifaRankingsResponse({
    required this.rankings,
  });

  factory FifaRankingsResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> teams = json['rankings'] ?? [];
    final rankings = teams.map((team) => FifaRanking.fromJson(team)).toList();

    return FifaRankingsResponse(rankings: rankings);
  }
}

// Model class for country rankings
class FifaCountryRanking {
  final String rowName;
  final int ranking;
  final int points;

  FifaCountryRanking({
    required this.rowName,
    required this.ranking,
    required this.points,
  });

  factory FifaCountryRanking.fromJson(Map<String, dynamic> json) {
    return FifaCountryRanking(
      rowName: json['rowName'] ?? '',
      ranking: (json['ranking'] ?? 0).toInt(),
      points: (json['points'] ?? 0).toInt(),
    );
  }
}

// Response model class for country rankings
class FifaCountryRankingsResponse {
  final List<FifaCountryRanking> rankings;

  FifaCountryRankingsResponse({
    required this.rankings,
  });

  factory FifaCountryRankingsResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> countries = json['rankings'] ?? [];
    final rankings = countries
        .map((country) => FifaCountryRanking.fromJson(country))
        .toList();

    return FifaCountryRankingsResponse(rankings: rankings);
  }
}

// Fetch function for club rankings
Future<FifaRankingsResponse> fetchFifaRankings() async {
  final response = await http.get(
    Uri.parse('https://footapi7.p.rapidapi.com/api/rankings/uefa/clubs'),
    headers: {
      'x-rapidapi-key': '6f8f212fa7msh661c1dad7e67ffbp11eee3jsnd1980e109e13', // Replace with your actual API key
      'x-rapidapi-host': 'footapi7.p.rapidapi.com',
    },
  );

  if (response.statusCode == 200) {
    return FifaRankingsResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load FIFA club rankings');
  }
}

// Fetch function for country rankings
Future<FifaCountryRankingsResponse> fetchFifaCountryRankings() async {
  final response = await http.get(
    Uri.parse('https://footapi7.p.rapidapi.com/api/rankings/uefa/countries'),
    headers: {
      'x-rapidapi-key': '6f8f212fa7msh661c1dad7e67ffbp11eee3jsnd1980e109e13', // Replace with your actual API key
      'x-rapidapi-host': 'footapi7.p.rapidapi.com',
    },
  );

  if (response.statusCode == 200) {
    return FifaCountryRankingsResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load FIFA country rankings');
  }
}



class Uefa extends StatefulWidget {
  @override
  _uefaRankingsPageState createState() => _uefaRankingsPageState();
}

class _uefaRankingsPageState extends State<Uefa> {
  late Future<FifaRankingsResponse> futureClubRankings;
  late Future<FifaCountryRankingsResponse> futureCountryRankings;

  @override
  void initState() {
    super.initState();
    futureClubRankings = fetchFifaRankings();
    futureCountryRankings = fetchFifaCountryRankings();
  }

  Widget buildClubRankings(BuildContext context, FifaRanking ranking) {
    return Card(
      color: Color.fromARGB(113, 51, 131, 132),

      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Row(
          children: [
            Text(
              '${ranking.ranking}',
              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white60),
            ),
            Expanded(
              child: Center(
                child: Text(style: TextStyle(color: Colors.white60),
                  ranking.rowName,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Text(
              '${ranking.points}',
              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white60),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCountryRankings(BuildContext context, FifaCountryRanking ranking) {
    return Card(
color: Color.fromARGB(113, 51, 131, 132),
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Row(
          children: [
            Text(
              '${ranking.ranking}',
              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white60),
            ),
            Expanded(
              child: Center(
                child: Text(style: TextStyle(color: Colors.white60),
                  ranking.rowName,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Text(
              '${ranking.points}',
              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white60),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
backgroundColor: Color.fromARGB(224, 140, 188, 186),

        appBar: AppBar(
          title: Text("UEFA Ranking",  style: TextStyle(
              color: Colors.white70, // Change the color here
            ),),
backgroundColor: Color.fromARGB(219, 5, 80, 75),

          bottom: TabBar(
               indicatorColor: Colors.white70, // Change the color of the indicator
              labelColor: Colors.white70, // Change the color of the selected tab text
              unselectedLabelColor: Colors.white70, 
            tabs: [
              Tab(text: 'CLUB'),
              Tab(text: 'COUNTRIES'),
              
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              child: Center(
                child: FutureBuilder<FifaRankingsResponse>(
                  future: futureClubRankings,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: 50,
                        itemBuilder: (context, index) {
                          var ranking = snapshot.data!.rankings[index];
                          return buildClubRankings(context, ranking);
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ),
            Center(
              child: FutureBuilder<FifaCountryRankingsResponse>(
                future: futureCountryRankings,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: 50,
                      itemBuilder: (context, index) {
                        var ranking = snapshot.data!.rankings[index];
                        return buildCountryRankings(context, ranking);
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

