import 'package:adopt_app/pages/add_page.dart';
import 'package:adopt_app/pages/home_page.dart';
import 'package:adopt_app/pages/update_page.dart';
import 'package:adopt_app/providers/pets_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PetsProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }

  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/add_page',
        builder: (context, state) => AddPage(),
      ),
      GoRoute(
        path: '/update_page/:petId',
        builder: (context, state) {
          final pet = Provider.of<PetsProvider>(context).pets.firstWhere((element) => element.id.toString() == state.pathParameters['petId']);
          return UpdatePage(pet: pet,);
        },
      ),
    ],
  );
}
