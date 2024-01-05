import 'package:flutter/material.dart';
import '../../common_widgets/game_color.dart';
import '../../common_widgets/next_button.dart';
import '../../common_widgets/option_card.dart';
import '../../common_widgets/questions_widget.dart';
import '../../common_widgets/result_box.dart';
import '../../constants/colors.dart';
import '../../screens/quiz/quiz_main.dart';
import '../questions_model.dart';
import 'alpha_db.dart';

class AlphaGame extends StatefulWidget {
  const AlphaGame({super.key});

  @override
  State<AlphaGame> createState() => _AlphaGameState();
}

class _AlphaGameState extends State<AlphaGame> {
  //create and object for Dbconnect
  var db = AlphaDBconnect();

  late Future _questions;

  Future<List<Question>> getData() async {
    return db.fetchQuestions();
  }

  @override
  void initState() {
    _questions = getData();
    super.initState();
  }

//loop of index
  int index = 0;
//create score var
  int score = 0;
//boolean value for color button before click
  bool isPressed = false;

  bool isAlreadySelected = false;

//function displaying next question
  void nextQuestion(int questionLength) {
    if (index == questionLength - 1) {
      // Block when questions end
      showDialog(
          context: context,
          barrierDismissible:
              false, //disable the dismiss function on clicking outside of box
          builder: (ctx) => ResultBox(
                result: score, //total points that user got
                questionLength: questionLength,
              ));
    } else {
      if (isPressed) {
        setState(() {
          index++;
          isPressed = false; //when index change to 1, rebuild the app
          isAlreadySelected = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please select any option'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(vertical: 20),
        ));
      }
    }
  }

//function change color
  void checkAnswerAndUpdate(bool value) {
    if (isAlreadySelected) {
      return;
    } else {
      if (value == true) {
        score++;
      }
      setState(() {
        isPressed = true;
        isAlreadySelected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _questions as Future<List<Question>>,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
                child: Text(
              '${snapshot.error}',
            ));
          } else if (snapshot.hasData) {
            var extractedData = snapshot.data as List<Question>;
            return Scaffold(
              backgroundColor: const Color.fromRGBO(255, 250, 215, 1),
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const QuizMain()),
                    );
                  },
                  icon: const Icon(Icons.home),
                  iconSize: 25,
                  color: const Color.fromRGBO(255, 250, 215, 1),
                ),
                backgroundColor: tPrimaryColor,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: Text(
                      'Score: $score',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(255, 250, 215, 1),
                      ),
                    ),
                  )
                ],
              ),
              body: SafeArea(
                  child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 25.0,
                    ),
                    QuestionWidget(
                      indexAction: index,
                      question: extractedData[index].title,
                      totalQuestions: extractedData.length,
                    ),
                    const Divider(
                      color: Color.fromRGBO(255, 144, 187, 1),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    for (int i = 0;
                        i < extractedData[index].options.length;
                        i++)
                      GestureDetector(
                        onTap: () => checkAnswerAndUpdate(
                            extractedData[index].options.values.toList()[i]),
                        child: OptionCard(
                          option: extractedData[index].options.keys.toList()[i],
                          color: isPressed
                              ? extractedData[index]
                                          .options
                                          .values
                                          .toList()[i] ==
                                      true
                                  ? correct
                                  : incorrect
                              : neutral,
                        ),
                      ),
                  ],
                ),
              )),
              floatingActionButton: GestureDetector(
                onTap: () => nextQuestion(extractedData.length),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: NextButton(),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            );
          }
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Please wait while Questions are loading..',
                  style: TextStyle(
                    color: Colors.yellow,
                    decoration: TextDecoration.none,
                    fontSize: 14.0,
                  ),
                )
              ],
            ),
          );
        }
        return const Center(
          child: Text('No Data'),
        );
      },
    );
  }
}
