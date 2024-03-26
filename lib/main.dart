import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark_test_task/configs/app_strings.dart';
import 'package:webspark_test_task/views/home/cubit/home_cubit.dart';
import 'package:webspark_test_task/views/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.websparkTestTask,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(),
        child: const HomeScreen(),
      ),
    );
  }
}
