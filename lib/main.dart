import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progressive_overload_app/exercise_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Progression Tracker',
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.black87,
            colorScheme: const ColorScheme(
              brightness: Brightness.dark,
              primary: Colors.purple,
              onPrimary: Colors.black,
              secondary: Colors.yellow,
              onSecondary: Colors.yellow,
              error: Colors.red,
              onError: Colors.red,
              background: Colors.black,
              onBackground: Colors.black,
              surface: Colors.black,
              onSurface: Colors.grey,
            ),
            primarySwatch: Colors.purple,
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.white, fontSize: 20),
              bodyMedium: TextStyle(color: Colors.white, fontSize: 16),
              bodySmall: TextStyle(color: Colors.white, fontSize: 16),
              displayLarge: TextStyle(color: Colors.white, fontSize: 46),
              displayMedium: TextStyle(color: Colors.white, fontSize: 42),
              displaySmall: TextStyle(color: Colors.white, fontSize: 36),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.purple, width: 2.5),
                  gapPadding: 30),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 2.5,
                  ),
                  gapPadding: 30),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(width: 10, color: Colors.white)),
              iconColor: Colors.white,
              labelStyle: TextStyle(
                color: Colors.white,
                decorationColor: Colors.white,
              ),
              hintStyle: TextStyle(
                color: Colors.white,
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
    return const ExercisePage();
  }
}
