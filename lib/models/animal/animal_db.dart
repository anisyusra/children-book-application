import 'package:http/http.dart' as http;
import 'dart:convert';

import '../questions_model.dart';

class AnimalDBconnect {
  //function adding question to db
  final url = Uri.parse(
      'https://ohsem-9a0ae-default-rtdb.asia-southeast1.firebasedatabase.app/animals.json'
      );


  //fetch data from db
  Future<List<Question>> fetchQuestions() async {
    //return response which is data
    return http.get(url).then((response) {
      //decode
      var data = json.decode(response.body) as Map<String, dynamic>;

      List<Question> newQuestions = [];
      data.forEach(((key, value) {
        var newQuestion = Question(
          id: key, //the encrypted key/ the title
          title: value['title'], //title of question
          options: Map.castFrom(value['options']), //options of the quest
        );
        //add to newQuestions
        newQuestions.add(newQuestion);
      }));
      return newQuestions;
    });
  }
}
