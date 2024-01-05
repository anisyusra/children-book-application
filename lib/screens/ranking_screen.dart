// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

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
//           final String userName = entry['name'];
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

// class RankingService {
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;

//   Future<List<Object?>> fetchRanking() async {
//     final QuerySnapshot snapshot = await firestore.collection('ranking').get();

//     List<Map<String, dynamic>> rankings = [];

//     for (final rankingDoc in snapshot.docs) {
//       final userId = rankingDoc.id;
//       final userSnapshot = await firestore.collection('user').doc(userId).get();
//       final userData = userSnapshot.data();

//       if (userData != null) {
//         final Map<String, dynamic> rankingData = {
//           'name': userData['name'],
//           'score': rankingDoc.data()['score'],
//         };

//         rankings.add(rankingData);
//       }
//     }

//     rankings.sort((a, b) => b['score'].compareTo(a['score']));

//     return rankings;
//   }
// }
