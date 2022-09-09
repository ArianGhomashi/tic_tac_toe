import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/constants/constants.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool isTurnX = true;
  List<String> xOrOList = ['', '', '', '', '', '', '', '', ''];
  int scoreX = 0;
  int scoreO = 0;
  bool gameFinished = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () {
                if (gameFinished) {
                  setState(() {
                    xOrOList[0] = '';
                    xOrOList[1] = '';
                    xOrOList[2] = '';
                    xOrOList[3] = '';
                    xOrOList[4] = '';
                    xOrOList[5] = '';
                    xOrOList[6] = '';
                    xOrOList[7] = '';
                    xOrOList[8] = '';
                    gameFinished = false;
                  });
                }
              },
              child: Icon(
                Icons.refresh,
                color: redColor,
                size: 45,
              ),
            ),
          ),
        ],
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Tic Tac Toe',
          style: TextStyle(
            color: blueColor,
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: 285,
                height: 12,
                decoration: BoxDecoration(
                  color: redColor,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Visibility(
                        visible: winnerX(),
                        child: Text(
                          'Winner',
                          style: TextStyle(
                            color: redColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: 121,
                        height: 177,
                        decoration: BoxDecoration(
                          color: Color(0xff1263FF),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Image.asset('images/playerx.png'),
                            SizedBox(height: 10),
                            Text(
                              'Player X',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 2),
                            Container(
                              width: 77,
                              height: 2,
                              color: Colors.white,
                            ),
                            SizedBox(height: 5),
                            Image(
                              image: AssetImage('images/x.png'),
                              width: 28,
                              height: 40,
                            )
                          ],
                        ),
                      ),
                      Text(
                        '$scoreX',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Visibility(
                        visible: winnerO(),
                        child: Text(
                          'Winner',
                          style: TextStyle(
                            color: redColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: 121,
                        height: 177,
                        decoration: BoxDecoration(
                          color: Color(0xffEF5F5F),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Image.asset('images/playero.png'),
                            SizedBox(height: 10),
                            Text(
                              'Player O',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 2),
                            Container(
                              width: 77,
                              height: 2,
                              color: Colors.white,
                            ),
                            SizedBox(height: 5),
                            Image(
                              image: AssetImage('images/o_little_edition.png'),
                              width: 28,
                              height: 35,
                            )
                          ],
                        ),
                      ),
                      Text(
                        '$scoreO',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Visibility(
              visible: draw(),
              child: Text(
                'Draw',
                style: TextStyle(
                  color: redColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 5),
            _getMainContent(),
            Text(
              _getTurn(),
              style: TextStyle(
                fontSize: 23,
                color: blueColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getMainContent() {
    return Container(
      width: 360,
      height: 390,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            redColor,
            blueColor,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: GridView.builder(
          itemCount: 9,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 26,
            crossAxisSpacing: 15,
          ),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                tapped(index);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: xOrOList[index] == ''
                      ? Container()
                      : Image.asset('images/${xOrOList[index]}.png'),
                ),
              ),
            );
          }),
    );
  }

  void tapped(int index) {
    if (xOrOList[index] == '' && !winnerX() && !winnerO()) {
      setState(() {
        if (isTurnX) {
          xOrOList[index] = 'x';
        } else {
          xOrOList[index] = 'o';
        }
        isTurnX = !isTurnX;
      });
    }
    if (winnerX() && !gameFinished) {
      setState(() {
        scoreX += 1;
        gameFinished = true;
      });
    } else if (winnerO() && !gameFinished) {
      setState(() {
        scoreO += 1;
        gameFinished = true;
      });
    } else if (draw()) {
      setState(() {
        gameFinished = true;
      });
    }
    ;
  }

  String _getTurn() {
    if (isTurnX) {
      return 'x';
    } else {
      return 'o';
    }
  }

  bool winnerX() {
    return (xOrOList[0] != '' &&
            xOrOList[1] != '' &&
            xOrOList[2] != '' &&
            xOrOList[0] == xOrOList[1] &&
            xOrOList[0] == xOrOList[2] &&
            xOrOList[0] == 'x') ||
        (xOrOList[3] != '' &&
            xOrOList[4] != '' &&
            xOrOList[5] != '' &&
            xOrOList[3] == xOrOList[4] &&
            xOrOList[3] == xOrOList[5] &&
            xOrOList[3] == 'x') ||
        (xOrOList[6] != '' &&
            xOrOList[7] != '' &&
            xOrOList[8] != '' &&
            xOrOList[6] == xOrOList[7] &&
            xOrOList[6] == xOrOList[8] &&
            xOrOList[6] == 'x') ||
        (xOrOList[0] != '' &&
            xOrOList[3] != '' &&
            xOrOList[6] != '' &&
            xOrOList[0] == xOrOList[3] &&
            xOrOList[0] == xOrOList[6] &&
            xOrOList[0] == 'x') ||
        (xOrOList[1] != '' &&
            xOrOList[4] != '' &&
            xOrOList[7] != '' &&
            xOrOList[1] == xOrOList[4] &&
            xOrOList[1] == xOrOList[7] &&
            xOrOList[1] == 'x') ||
        (xOrOList[2] != '' &&
            xOrOList[5] != '' &&
            xOrOList[8] != '' &&
            xOrOList[2] == xOrOList[5] &&
            xOrOList[2] == xOrOList[8] &&
            xOrOList[2] == 'x') ||
        (xOrOList[0] != '' &&
            xOrOList[4] != '' &&
            xOrOList[8] != '' &&
            xOrOList[0] == xOrOList[4] &&
            xOrOList[0] == xOrOList[8] &&
            xOrOList[0] == 'x') ||
        (xOrOList[2] != '' &&
            xOrOList[4] != '' &&
            xOrOList[6] != '' &&
            xOrOList[2] == xOrOList[4] &&
            xOrOList[2] == xOrOList[6] &&
            xOrOList[2] == 'x');
  }

  bool winnerO() {
    return (xOrOList[0] != '' &&
            xOrOList[1] != '' &&
            xOrOList[2] != '' &&
            xOrOList[0] == xOrOList[1] &&
            xOrOList[0] == xOrOList[2] &&
            xOrOList[0] == 'o') ||
        (xOrOList[3] != '' &&
            xOrOList[4] != '' &&
            xOrOList[5] != '' &&
            xOrOList[3] == xOrOList[4] &&
            xOrOList[3] == xOrOList[5] &&
            xOrOList[3] == 'o') ||
        (xOrOList[6] != '' &&
            xOrOList[7] != '' &&
            xOrOList[8] != '' &&
            xOrOList[6] == xOrOList[7] &&
            xOrOList[6] == xOrOList[8] &&
            xOrOList[6] == 'o') ||
        (xOrOList[0] != '' &&
            xOrOList[3] != '' &&
            xOrOList[6] != '' &&
            xOrOList[0] == xOrOList[3] &&
            xOrOList[0] == xOrOList[6] &&
            xOrOList[0] == 'o') ||
        (xOrOList[1] != '' &&
            xOrOList[4] != '' &&
            xOrOList[7] != '' &&
            xOrOList[1] == xOrOList[4] &&
            xOrOList[1] == xOrOList[7] &&
            xOrOList[1] == 'o') ||
        (xOrOList[2] != '' &&
            xOrOList[5] != '' &&
            xOrOList[8] != '' &&
            xOrOList[2] == xOrOList[5] &&
            xOrOList[2] == xOrOList[8] &&
            xOrOList[2] == 'o') ||
        (xOrOList[0] != '' &&
            xOrOList[4] != '' &&
            xOrOList[8] != '' &&
            xOrOList[0] == xOrOList[4] &&
            xOrOList[0] == xOrOList[8] &&
            xOrOList[0] == 'o') ||
        (xOrOList[2] != '' &&
            xOrOList[4] != '' &&
            xOrOList[6] != '' &&
            xOrOList[2] == xOrOList[4] &&
            xOrOList[2] == xOrOList[6] &&
            xOrOList[2] == 'o');
  }

  bool draw() {
    return !winnerO() &&
        !winnerX() &&
        xOrOList[0] != '' &&
        xOrOList[1] != '' &&
        xOrOList[2] != '' &&
        xOrOList[3] != '' &&
        xOrOList[4] != '' &&
        xOrOList[5] != '' &&
        xOrOList[6] != '' &&
        xOrOList[7] != '' &&
        xOrOList[8] != '';
  }
}
