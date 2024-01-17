import 'package:datatable_con_adaptive/gestione_utenti/gestione_utenti.dart';
import 'package:datatable_con_adaptive/gestione_utenti/modifica_utente.dart';
import 'package:datatable_con_adaptive/register/change_password.dart';
import 'package:datatable_con_adaptive/register/login.dart';
import 'package:datatable_con_adaptive/register/register.dart';
import 'package:datatable_con_adaptive/dashboard/dashboard.dart';
import 'package:datatable_con_adaptive/dashboard/dashboard_provider.dart';
import 'package:datatable_con_adaptive/dashboard/operaio/future_operai.dart';
import 'package:datatable_con_adaptive/dashboard/timbrature/future_timbrature.dart';
import 'package:datatable_con_adaptive/homepage.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

//main tells flutter to run the app defined in MyApp
void main() => runApp(const MyApp());


final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'future_operaio',
          builder: (BuildContext context, GoRouterState state) {
            return const FutureOperai();
          },
        ),
        GoRoute(
            path: 'future_timbratura',
            builder: (BuildContext context, GoRouterState state) =>  const FutureTimbrature(cf: '',),
        ),
        GoRoute(
          path: 'dashboard',
          builder: (BuildContext context, GoRouterState state) => const Dashboard()
        ),
        GoRoute(
            path: 'register',
            builder: (BuildContext context, GoRouterState state) => const RegisterForm()
        ),
        GoRoute(
            path: 'login',
            builder: (BuildContext context, GoRouterState state) => const LoginForm()
        ),
        GoRoute(
            path: 'changePass',
            builder: (BuildContext context, GoRouterState state) => const ChangePasswordForm()
        ),
        GoRoute(
            path: 'gestione_utenti',
            builder: (BuildContext context, GoRouterState state) => const GestioneUtenti()
        ),
        GoRoute(path: 'modifica_utente/:Idutente',
            builder: (BuildContext context, GoRouterState state) => const ModificaUtente(idUtente: 24)
        ),
      ],
    ),
  ],
);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

 /*ChangeNotifierProvider provvede un'istanza di ChangeNotifier ai suoi discendenti*/
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DashboardProvider()),
      ],
      child: MaterialApp.router(
        routerConfig: _router,
        title: 'Fetch Data Example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
