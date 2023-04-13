import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/features/cart/bloc/cart_bloc.dart';
import 'package:task_app/features/home/ui/home.dart';

import 'features/summary/ui/summary.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CartBloc(),
      child: MaterialApp(
  title: 'Flutter Demo',
  theme: ThemeData(
    // is not restarted.
    primarySwatch: Colors.blue,
  ),
  initialRoute: '/',
  routes: {
    '/': (context) => const Home(),
    '/summary': (context) => const SummaryPage(),
  },
)

    );
  }
}
