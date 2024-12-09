import 'package:daily_training_flutter/providers/ranking.provider.dart';
import 'package:daily_training_flutter/providers/training_release.provider.dart';
import 'package:daily_training_flutter/services/ranking.service.dart';
import 'package:daily_training_flutter/services/training_release.service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:daily_training_flutter/screens/bets.dart';
import 'package:daily_training_flutter/screens/signup.dart';
import 'package:daily_training_flutter/screens/signin.dart';
import 'package:daily_training_flutter/screens/new_bet.dart';
import 'package:daily_training_flutter/screens/ranking.dart';
import 'package:daily_training_flutter/screens/bet_details.dart';
import 'package:daily_training_flutter/services/api.service.dart';
import 'package:daily_training_flutter/services/bets.service.dart';
import 'package:daily_training_flutter/providers/bets.provider.dart';
import 'package:daily_training_flutter/providers/auth.provider.dart';
import 'package:daily_training_flutter/providers/users.provider.dart';
import 'package:daily_training_flutter/services/participants.service.dart';
import 'package:daily_training_flutter/providers/participants.privider.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UsersProvider()),
        ChangeNotifierProvider(
            create: (_) =>
                TrainingReleaseProvider(TrainingReleaseService(ApiService()))),
        ChangeNotifierProvider(
            create: (_) => RankingProvider(RankingService(ApiService()))),
        ChangeNotifierProvider(
            create: (_) =>
                ParticipantsProvider(ParticipantsService(ApiService()))),
        ChangeNotifierProvider(
            create: (_) => BetsProvider(BetsService(ApiService()))),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Diretoria Fitness',
          initialRoute: '/',
          routes: {
            '/': (context) => SignInScreen(),
            '/new-bet': (context) => NewBetScreen(),
            '/bets': (context) => const BetsScreen(),
            '/signup': (context) => const SignUpScreen(),
            '/ranking': (context) => const RankingScreen(),
            '/bet-details': (context) => const BetDetailsScreen(),
          },
        ));
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Erro")),
      body: const Center(
        child: Text("Algo deu errado!"),
      ),
    );
  }
}
