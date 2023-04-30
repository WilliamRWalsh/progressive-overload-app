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

// Primary Action
const primaryActionColor = Color.fromARGB(255, 44, 212, 50);

// Secondary Action
const secondaryActionColor = Colors.orange;

// Background
const backgroundColor = Colors.black;

// Card
const cardColor = Color.fromARGB(255, 243, 209, 98);

// App Bar
const appBarColor = Color.fromARGB(255, 185, 28, 212);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Progression Tracker',
        theme: ThemeData(
            scaffoldBackgroundColor: backgroundColor,
            colorScheme: const ColorScheme(
              brightness: Brightness.dark,
              primary: primaryActionColor,
              onPrimary: backgroundColor,
              secondary: primaryActionColor,
              onSecondary: backgroundColor,
              error: Colors.red,
              onError: Colors.red,
              background: backgroundColor,
              onBackground: backgroundColor,
              surface: appBarColor,
              onSurface: backgroundColor,
            ),
            textTheme: const TextTheme(
              titleMedium:
                  TextStyle(color: Colors.white, fontSize: 24), // textfields
              bodyLarge: TextStyle(color: Colors.white, fontSize: 58),
              bodyMedium: TextStyle(color: Colors.white, fontSize: 58),
              bodySmall: TextStyle(color: Colors.white, fontSize: 58),
              displayLarge: TextStyle(
                color: Colors.white,
                fontSize: 46,
                fontWeight: FontWeight.bold,
              ),
              displayMedium: TextStyle(color: Colors.white, fontSize: 42),
              displaySmall: TextStyle(color: Colors.white, fontSize: 36),
              labelLarge: TextStyle(color: backgroundColor, fontSize: 28),
              labelMedium: TextStyle(color: backgroundColor, fontSize: 20),
            ),
            cardColor: cardColor,
            // cardTheme: CardTheme(surfaceTintColor: backgroundColor),
            inputDecorationTheme: InputDecorationTheme(
              disabledBorder: InputBorder.none,
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: appBarColor, width: 2.5),
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