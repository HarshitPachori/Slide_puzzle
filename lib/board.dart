import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slide_puzzle/Image_widget.dart';
import 'package:slide_puzzle/grid.dart';

class Board extends StatefulWidget {
  const Board({Key? key}) : super(key: key);

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> with SingleTickerProviderStateMixin {
  var number = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
  int movesCounter = 0;

  String timeString = "00:00:00";
  Stopwatch stopwatch = Stopwatch();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    number.shuffle();
    start();
  }

  void start() {
    stopwatch.start();
    timer = Timer.periodic(const Duration(milliseconds: 1), update);
  }

  void update(Timer t) {
    if (stopwatch.isRunning) {
      setState(() {
        timeString =
            (stopwatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
                ":" +
                (stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, "0") +
                ":" +
                (stopwatch.elapsed.inMilliseconds % 1000 / 10)
                    .clamp(0, 99)
                    .toStringAsPrecision(0)
                    .padLeft(2, "0");
      });
    }
  }

  void stop() {
    setState(() {
      timer!.cancel();
    });
  }

  void reset() {
    timer!.cancel();
    stopwatch.reset();
    setState(() {
      timeString = "00:00:00";
    });
    stopwatch.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 100,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Center(
                        child: FittedBox(
                      child: Text(
                        "Slide Puzzle",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: FittedBox(
                          child: Text(
                            movesCounter.toString() + " Moves | 15 Tiles",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Center(
                    child:
                        ImageDisplay(imagePath: "asset/images/Dashatars.png")),
              ],
            ),
          ),
          SizedBox(
            child: Text(timeString),
          ),
          Grid(
            number: number,
            onClick: onClick,
          ),
          ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  CupertinoColors.systemIndigo,
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              onPressed: () {
                setState(() {
                  number.shuffle();
                  stopwatch.isRunning ? stop() : start();
                  movesCounter = 0;
                });
              },
              icon: const Icon(
                CupertinoIcons.refresh_bold,
                color: Colors.white,
                size: 18,
              ),
              label: const Text(
                "Shuffle",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ))
        ],
      ),
    );
  }

  void onClick(index) {
    if (index - 1 >= 0 && number[index - 1] == 0 && index % 4 != 0 ||
        index + 1 < 16 && number[index + 1] == 0 && (index + 1) % 4 != 0 ||
        (index - 4 >= 0 && number[index - 4] == 0) ||
        (index + 4 < 16 && number[index + 4] == 0)) {
      setState(() {
        number[number.indexOf(0)] = number[index];
        number[index] = 0;

        movesCounter++;
      });
    }
    start();
    checkWinner();
  }

  bool isSorted(List numberList) {
    int first = numberList.first;
    for (int i = 1; i < numberList.length; i++) {
      int nextNumber = numberList[i];
      if (first > nextNumber) {
        return false;
      }
      first = numberList[i];
    }
    return true;
  }

  void checkWinner() {
    bool isWinner = isSorted(number);
    if (isWinner) {
      const AlertDialog(
        title: Text("Congratulations !!"),
        content: Text("You have succesfully completed this puzzle game ! "),
      );
    }
  }
}
