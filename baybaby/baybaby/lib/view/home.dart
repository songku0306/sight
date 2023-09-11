import 'package:flutter/material.dart';

class OmokGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OmokBoard(),
    );
  }
}

class OmokBoard extends StatefulWidget {
  @override
  _OmokBoardState createState() => _OmokBoardState();
}

class _OmokBoardState extends State<OmokBoard> {
  late List<List<int>> board;
  late int currentPlayer;
  late bool gameOver;

  @override
  void initState() {
    super.initState();
    initializeBoard();
  }

  void initializeBoard() {
    board = List.generate(15, (i) => List<int>.filled(15, 0));
    currentPlayer = 1;
    gameOver = false;
  }

  void makeMove(int row, int col) {
    if (board[row][col] == 0 && !gameOver) {
      setState(() {
        board[row][col] = currentPlayer;
        if (checkWin(row, col)) {
          gameOver = true;
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('게임 종료!'),
              content: Text('플레이어 $currentPlayer가 이겼습니다!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    initializeBoard();
                  },
                  child: Text('새 게임 시작'),
                ),
              ],
            ),
          );
        } else {
          currentPlayer = (currentPlayer == 1) ? 2 : 1;
        }
      });
    }
  }

  bool checkWin(int row, int col) {
    // 수평, 수직, 대각선 방향으로 5개의 돌이 연속되었는지 확인하는 로직을 구현하세요.
    // 게임 승리 조건을 만족하면 true를 반환하세요.
    // 예를 들어, 가로로 5개의 돌이 연속되면 승리로 처리할 수 있습니다.
    // 이 외에도 세로, 왼쪽 위에서 오른쪽 아래 대각선, 오른쪽 위에서 왼쪽 아래 대각선 방향으로 승리 조건을 확인해야 합니다.
    // 만약 승리 조건을 만족하지 않으면 false를 반환하세요.
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('오목 게임'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '플레이어 $currentPlayer의 차례',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 15,
                ),
                itemBuilder: (BuildContext context, int index) {
                  int row = index ~/ 15;
                  int col = index % 15;
                  return GestureDetector(
                    onTap: () {
                      makeMove(row, col);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      child: Center(
                        child: board[row][col] == 1
                            ? CircleAvatar(
                                backgroundColor: Colors.black,
                              )
                            : (board[row][col] == 2
                                ? CircleAvatar(
                                    backgroundColor: Colors.grey,
                                  )
                                : null),
                      ),
                    ),
                  );
                },
                itemCount: 15 * 15,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                initializeBoard();
              },
              child: Text('새 게임 시작'),
            ),
          ],
        ),
      ),
    );
  }
}
