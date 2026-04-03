import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statemanagement/auth_bloc.dart';
import 'package:statemanagement/home.dart';
import 'package:statemanagement/login.dart';
import 'package:statemanagement/order.dart';
import 'package:statemanagement/order_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => AuthBloc()),
        BlocProvider<OrderBloc>(create: (_) => OrderBloc())
      ],
      child: MaterialApp(
        title: 'Bloc state management app',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        initialRoute: '/login',
        routes: {
          "/login": (context) => const LoginPage(),
          "/home" : (context) => const HomePage(),
          "/order" : (context) => const OrderPage()
        },
      ),
    );
  }
}
