// import 'package:flutter/material.dart';
// import 'package:project_mobile/screens/ranking_screen.dart';

// class RankingScreen extends StatefulWidget {
//   @override
//   _RankingScreenState createState() => _RankingScreenState();
// }

// class _RankingScreenState extends State<RankingScreen> {
//   final RankingService rankingService = RankingService();
//   List<Map<String, dynamic>> rankingData = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchRankingData();
//   }

//   Future<void> fetchRankingData() async {
//     final List<Object?> data = await rankingService.fetchRanking();
//     final List<Map<String, dynamic>> convertedData =
//         data.cast<Map<String, dynamic>>().toList();

//     setState(() {
//       rankingData = convertedData;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Ranking'),
//       ),
//       body: ListView.builder(
//         itemCount: rankingData.length,
//         itemBuilder: (context, index) {
//           final Map<String, dynamic> entry = rankingData[index];
//           final String userName = entry['username'];
//           final int score = entry['score'];

//           return ListTile(
//             title: Text(userName),
//             subtitle: Text('Score: $score'),
//           );
//         },
//       ),
//     );
//   }
// }
