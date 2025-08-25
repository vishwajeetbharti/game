import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme.dart';
import 'features/game/bloc/game_bloc.dart';
import 'features/game/bloc/game_event.dart';
import 'features/game/presentation/pages/game_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const NumberMatchApp());
}
class NumberMatchApp extends StatelessWidget {
  const NumberMatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Match Puzzle',
      theme: buildTheme(),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => GameBloc()..add(GameStarted(levelIndex: 0)),
        child: const GamePage(),
      ),
    );
  }
}