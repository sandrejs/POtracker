import 'package:flutter/material.dart';
import 'package:po_tracker/pages/starting_screen.dart';
import 'package:po_tracker/pages/loading.dart';
import 'package:po_tracker/pages/workout_days.dart';
import 'package:po_tracker/pages/exercise_info.dart';


void main() => runApp(MaterialApp(
  initialRoute: '/starting_screen',
  routes: {
    '/': (context) => Loading(),
    '/starting_screen': (context) => StartingScreen(),
    '/workout_days': (context) => WorkoutDaysScreen(),
    '/exercise_info': (context) {
      final List<String>? selectedDays = ModalRoute.of(context)?.settings.arguments as List<String>?;
      return ExerciseInfo(selectedDays: selectedDays ?? []);
    },
  },
));
