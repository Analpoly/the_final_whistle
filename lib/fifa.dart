import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// void main() {
//   runApp(MyApp3());
// }
class FifaRanking {
  final String countryImage;
  final String countryName;
  final int rank;
  final int totalPoints;

  FifaRanking({
        required this.countryImage,
    required this.countryName,
    required this.rank,
    required this.totalPoints,
  });

  factory FifaRanking.fromJson(Map<String, dynamic> json) {
    return FifaRanking(
            countryImage: json['countryImage'] ?? '',
      countryName: json['countryName'] ?? '',
      rank: (json['rank'] ?? 0).toInt(),
      totalPoints: (json['totalPoints'] ?? 0).toInt(),
    );
  }
}

class FifaRankingsResponse {
  final List<FifaRanking> rankings;

  FifaRankingsResponse({
    required this.rankings,
  });

  factory FifaRankingsResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> teams = json['teams'] ?? [];
    final rankings = teams.map((team) => FifaRanking.fromJson(team)).toList();

    return FifaRankingsResponse(rankings: rankings);
  }
}


// class MyApp3 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'FIFA Rankings',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: FifaRankingsPage(),
//     );
//   }
// }

class Fifa extends StatefulWidget {
  @override
  _FifaRankingsPageState createState() => _FifaRankingsPageState();
}
class _FifaRankingsPageState extends State<Fifa> {
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
      Uri.parse('https://transfermarket.p.rapidapi.com/statistic/list-fifa-world-rankings'),
      headers: {
        'x-rapidapi-key': '1276b1c07fmshe6f361c7e7fa3e3p1b228ejsn798abaf7accf', // Replace with your actual API key
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
    return Scaffold(backgroundColor: Color.fromARGB(224, 140, 188, 186),


      appBar: AppBar(
        title: Text('FIFA Rankings',  style: TextStyle(
              color: Colors.white70, // Change the color here
            ),),
backgroundColor: Color.fromARGB(219, 5, 80, 75),

      ),
      body: Center(
        child: FutureBuilder<FifaRankingsResponse>(
          future: futureRankings,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
  itemCount: 50,
  itemBuilder: (context, index) {
    var ranking = snapshot.data!.rankings[index];
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey)),
          ),
          child: ListTile(
            leading: Text('${ranking.rank}',style: TextStyle(color: Colors.white),),
            title: Row(
              children: [
                ClipOval(
                  child: Image.network(
                    ranking.countryImage,
                    width: 36,
                    height: 36,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${ranking.countryName}',style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                Align(

                  alignment: Alignment.topRight,
                  child: Text('${ranking.totalPoints}',style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  },
);

            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
