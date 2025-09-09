import 'package:flutter/material.dart';
import 'package:flutter_basic/screens/loginscreen.dart';

void main() => runApp(const MyApp());
String? name = "admin";
String? password = "admin";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '3 en Raya',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Colors.white),
          titleSmall: TextStyle(color: Colors.white),
          labelLarge: TextStyle(color: Colors.white),
          labelMedium: TextStyle(color: Colors.white),
          labelSmall: TextStyle(color: Colors.white),
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Loginscreen(),
        '/game': (context) => const TicTacToePage(),
      },
    );
  }
}

// ================= JUEGO 3 EN RAYA =================
class TicTacToePage extends StatefulWidget {
  const TicTacToePage({super.key});

  @override
  State<TicTacToePage> createState() => _TicTacToePageState();
}

class _TicTacToePageState extends State<TicTacToePage> {
  final List<String> _board = List.filled(9, '');
  String _currentPlayer = 'X';
  String? _winner;
  int _scoreX = 0;
  int _scoreO = 0;

  static const List<List<int>> _winCombos = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  void _handleTap(int index) {
    if (_board[index] != '' || _winner != null) return;

    setState(() {
      _board[index] = _currentPlayer;
      _checkWinner();
      if (_winner == null) {
        _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
      } else {
        if (_winner == 'X')
          _scoreX++;
        else if (_winner == 'O')
          _scoreO++;
      }
    });

    if (_winner != null) {
      _showEndDialog();
    }
  }

  void _checkWinner() {
    for (final combo in _winCombos) {
      final a = combo[0], b = combo[1], c = combo[2];
      if (_board[a] != '' && _board[a] == _board[b] && _board[b] == _board[c]) {
        _winner = _board[a];
        return;
      }
    }
    if (!_board.contains('')) {
      _winner = 'Empate';
    }
  }

  void _resetBoard() {
    setState(() {
      for (var i = 0; i < 9; i++) _board[i] = '';
      _winner = null;
      _currentPlayer = 'X';
    });
  }

  void _resetGame() {
    setState(() {
      _resetBoard();
      _scoreX = 0;
      _scoreO = 0;
    });
  }

  Future<void> _showEndDialog() async {
    final title = _winner == 'Empate' ? 'Empate' : 'Gana $_winner';
    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(
          _winner == 'Empate'
              ? 'Nadie ganó esta ronda.'
              : '¡Jugador $_winner gana!',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _resetBoard();
            },
            child: const Text('Nueva ronda'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _resetGame();
            },
            child: const Text('Reiniciar todo'),
          ),
        ],
      ),
    );
  }

  Widget _buildCell(int index) {
    return GestureDetector(
      onTap: () => _handleTap(index),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 255, 255, 255)),
          color: _board[index] == ''
              ? const Color.fromARGB(0, 255, 255, 255)
              : const Color.fromARGB(255, 0, 0, 0),
        ),
        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),

            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: _board[index] == 'X'
                  ? const Color.fromARGB(255, 255, 0, 0)
                  : const Color.fromARGB(255, 0, 94, 255),
            ),
            child: Text(_board[index]),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('3 en Raya'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/");
              },
              child: Text("Regresar"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Turno actual',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Text(
                          _currentPlayer,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.person),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        const Text(
                          'X',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text('$_scoreX', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Column(
                      children: [
                        const Text(
                          'O',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text('$_scoreO', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: 9,
                  itemBuilder: (context, i) => _buildCell(i),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _resetBoard,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Nueva ronda'),
                ),
                ElevatedButton.icon(
                  onPressed: _resetGame,
                  icon: const Icon(Icons.restart_alt),
                  label: const Text('Reiniciar todo'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Toca una casilla para jugar. Dos jugadores en el mismo dispositivo.',
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
