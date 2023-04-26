import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:progressive_overload_app/models/session.model.dart';
import 'package:progressive_overload_app/models/exercise_type.model.dart';
import 'package:progressive_overload_app/models/exercise_set.model.dart';
import 'package:progressive_overload_app/models/routine.model.dart';
import 'package:progressive_overload_app/pages/routine/routine_list_page.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(ExerciseTypeAdapter());
  Hive.registerAdapter(SessionAdapter());
  Hive.registerAdapter(RoutineAdapter());
  Hive.registerAdapter(ExerciseSetAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const green = Color.fromARGB(255, 44, 212, 50);
    const orange = Color.fromARGB(255, 243, 209, 98);
    const purple = Color.fromARGB(255, 185, 28, 212);
    return ProviderScope(
      child: MaterialApp(
        title: 'Progression Tracker',
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.black87,
            colorScheme: const ColorScheme(
              brightness: Brightness.dark,
              primary: green,
              onPrimary: Colors.black,
              secondary: green,
              onSecondary: Colors.black,
              error: Colors.red,
              onError: Colors.red,
              background: Colors.black,
              onBackground: Colors.black,
              surface: purple,
              onSurface: Colors.black,
            ),
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.white, fontSize: 20),
              bodyMedium: TextStyle(color: Colors.white, fontSize: 16),
              bodySmall: TextStyle(color: Colors.white, fontSize: 16),
              displayLarge: TextStyle(color: Colors.white, fontSize: 46),
              displayMedium: TextStyle(color: Colors.white, fontSize: 42),
              displaySmall: TextStyle(color: Colors.white, fontSize: 36),
              labelLarge: TextStyle(color: Colors.black, fontSize: 32),
              labelMedium: TextStyle(color: Colors.black, fontSize: 20),
            ),
            cardColor: orange,
            cardTheme: CardTheme(surfaceTintColor: Colors.black),
            inputDecorationTheme: InputDecorationTheme(
              disabledBorder: InputBorder.none,
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: purple, width: 2.5),
                  gapPadding: 30),
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 2.5,
                  ),
                  gapPadding: 30),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(width: 10, color: Colors.white)),
              iconColor: Colors.white,
              labelStyle: TextStyle(
                color: Colors.white.withOpacity(.85),
                decorationColor: Colors.white,
              ),
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(.5),
                decorationColor: Colors.white,
              ),
            )
            // elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(foregroundColor: ))
            ),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const RoutineListPage();
  }
}

// todo: better transistions