import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Grid extends StatefulWidget {
  var number = [];
  Function onClick;

  Grid({Key? key, required this.number, required this.onClick})
      : super(key: key);

  @override
  State<Grid> createState() => _GridState();
}

class _GridState extends State<Grid> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.55, //* 0.6,
      width: MediaQuery.of(context).size.width, //* 0.6,
      padding: const EdgeInsets.all(25),
      child: GridView.builder(
          itemCount: widget.number.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, crossAxisSpacing: 1.0, mainAxisSpacing: 1.0),
          itemBuilder: (context, index) {
            return widget.number[index] != 0
                ? GestureDetector(
                    onTap: () {
                      widget.onClick(index);
                    },
                    child: Card(
                      elevation: 8,
                      color: CupertinoColors.systemIndigo,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: Center(
                          child: FittedBox(
                              child: Text(
                            widget.number[index].toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink();
          }),
    );
  }
}
