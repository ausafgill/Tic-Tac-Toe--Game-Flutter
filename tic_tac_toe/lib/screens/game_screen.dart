import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameScreen extends StatefulWidget {
  String player1, player2;
  GameScreen({required this.player1, required this.player2});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<String> displayXO = ['', '', '', '', '', '', '', '', ''];
  bool turn = true;
  int player1Score = 0;
  int player2Score = 0;
  int filledBoxes = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        '${widget.player1.toUpperCase()}(O)',
                        style: GoogleFonts.pressStart2p(
                            color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        player1Score.toString(),
                        style: GoogleFonts.pressStart2p(
                            color: Colors.white, fontSize: 20),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Text(
                        '${widget.player2.toUpperCase()}(X)',
                        style: GoogleFonts.pressStart2p(
                            color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        player2Score.toString(),
                        style: GoogleFonts.pressStart2p(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )),
            Expanded(
              flex: 3,
              child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        _tapped(index);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 4,
                                  color:
                                      const Color.fromARGB(255, 126, 36, 30))),
                          child: Center(
                            child: Text(
                              displayXO[index],
                              style: GoogleFonts.rubikSprayPaint(
                                  color: Colors.white, fontSize: 40),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Expanded(
                child: Text(
              '@CREATEDBYAG',
              style: GoogleFonts.pressStart2p(color: Colors.white),
            ))
          ],
        ),
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (turn && displayXO[index] == '') {
        displayXO[index] = 'O';
        if (filledBoxes < 9) {
          filledBoxes += 1;
        }
      } else if (!turn && displayXO[index] == '') {
        displayXO[index] = 'X';
        if (filledBoxes < 9) {
          filledBoxes += 1;
        }
      }
      turn = !turn;
      _checkWinner();
    });
  }

  void _checkWinner() {
//First Row Check
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != '') {
      _showDialogBox(displayXO[0]);
    }
    //Second Row Check
    if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != '') {
      _showDialogBox(displayXO[3]);
    }

    // Third Row Check
    if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != '') {
      _showDialogBox(displayXO[6]);
    }

//First Col Check
    if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != '') {
      _showDialogBox(displayXO[0]);
    }

    //Sec Col Check
    if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != '') {
      _showDialogBox(displayXO[1]);
    }

    //Third col check

    if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != '') {
      _showDialogBox(displayXO[2]);
    }

//Diagnols Check

    if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != '') {
      _showDialogBox(displayXO[0]);
    }

    if (displayXO[2] == displayXO[4] &&
        displayXO[2] == displayXO[6] &&
        displayXO[2] != '') {
      _showDialogBox(displayXO[2]);
    } else if (filledBoxes == 9) {
      _showDrawBox();
    }
  }

  void _showDialogBox(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          String winnerName = winner == 'X' ? widget.player2 : widget.player1;

          if (winner == 'O') {
            player1Score += 1;
          } else if (winner == 'X') {
            player2Score += 1;
          }
          return AlertDialog(
            title: Text(
              'WINNER: ${winnerName.toUpperCase()}',
              style: GoogleFonts.pressStart2p(color: Colors.black),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    _clearBoard();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'PLAY AGAIN',
                    style: GoogleFonts.pressStart2p(color: Colors.black),
                  ))
            ],
          );
        });
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayXO[i] = '';
      }
    });
    filledBoxes = 0;
  }

  void _showDrawBox() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "DRAW",
              style: GoogleFonts.pressStart2p(color: Colors.black),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    _clearBoard();
                    Navigator.pop(context);
                  },
                  child: Text(
                    "PLAY AGAIN",
                    style: GoogleFonts.pressStart2p(color: Colors.black),
                  ))
            ],
          );
        });
  }
}
