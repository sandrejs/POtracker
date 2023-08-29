import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExerciseInfo extends StatefulWidget {
  final List<String> selectedDays;

  const ExerciseInfo({super.key, required this.selectedDays});

  @override
  State<ExerciseInfo> createState() => _ExerciseInfoState();
}

class _ExerciseInfoState extends State<ExerciseInfo> {
  @override
  Widget build(BuildContext context) {

    String firstSelectedDay = widget.selectedDays.isNotEmpty ? widget.selectedDays[0] : 'No selected days'; // Get the first selected day or a default message

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 100.0, 30.0, 0.0),
                child: Center(
                  child: Text(
                    'Choose exercises for $firstSelectedDay or make new ones',
                    style: GoogleFonts.poppins(
                      fontSize: 26,
                      height: 1.2,
                    ),
                      textAlign: TextAlign.center,
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
