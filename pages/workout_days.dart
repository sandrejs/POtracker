import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class WorkoutDaysScreen extends StatefulWidget {
  const WorkoutDaysScreen({super.key});

  @override
  State<WorkoutDaysScreen> createState() => _WorkoutDaysScreenState();
}

class _WorkoutDaysScreenState extends State<WorkoutDaysScreen> {

  Set<String> selectedDays = {}; // Storing the days selected

  bool isAnyDaySelected = false;
  bool isNextButtonPressed = false;

  late VideoPlayerController _controller;

  // Video in the background
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/background.mp4')
      ..initialize().then((_) {
        _controller.setLooping(true);
        _controller.play();
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Button widget
  List<bool> buttonPressedStates = List.generate(7, (index) => false);
  Widget buildSquareButton(String buttonText, int index) {
    bool isSelected = buttonPressedStates[index];

    return Container(
      width: 65,
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: LinearGradient(
          colors: buttonPressedStates[index]
              ? [Colors.black, Colors.black]// Change color when pressed
              : [Colors.black, Colors.white.withOpacity(0)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            buttonPressedStates[index] = !buttonPressedStates[index];
            if (isSelected) {
              selectedDays.remove(buttonText);
            } else {
              selectedDays.add(buttonText);
            }

            isAnyDaySelected = selectedDays.isNotEmpty;

          });
        },
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(0),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 14.0,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 100.0, 30.0, 0.0),
                child: Center(
                  child: Text(
                    'Which days are you working out?',
                    style: GoogleFonts.poppins(
                      fontSize: 26,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 100),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildSquareButton('Mon', 0),
                    SizedBox(width: 30),
                    buildSquareButton('Tue', 1),
                    SizedBox(width: 30),
                    buildSquareButton('Wed', 2),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildSquareButton('Thur', 3),
                    SizedBox(width: 30),
                    buildSquareButton('Fri', 4),
                    SizedBox(width: 30),
                    buildSquareButton('Sat', 5),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildSquareButton('Sun', 6),
                  ],
                ),
              ),
              SizedBox(height: 150),
              if (!isAnyDaySelected && isNextButtonPressed)
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 0.0),
                  child: Text(
                    'You haven\'t selected any days!',
                    style: GoogleFonts.poppins(
                      fontSize: 14.0,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      isNextButtonPressed = true;
                    });

                    if (isAnyDaySelected) {
                      Navigator.pushNamed(
                        context,
                        '/exercise_info',
                        arguments: selectedDays.toList(),
                      );
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Next',
                        style: GoogleFonts.poppins(),
                      ),
                      const Icon(
                        Icons.arrow_forward_sharp,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
