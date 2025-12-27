import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game/data/game_state.dart';
import 'game/aria_game.dart';
import 'widgets/game_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GameState(),
      child: MaterialApp(
        title: 'Aria',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const GameScreen(),
      ),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late AriaGame game;
  
  @override
  void initState() {
    super.initState();
    game = AriaGame();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AriaGameWidget(game: game),
    );
  }
}
