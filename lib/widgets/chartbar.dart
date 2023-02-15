import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final int dailyAmount;
  final double spentPercentage;

  const ChartBar({this.dailyAmount, this.label, this.spentPercentage});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: <Widget>[
            Container(
              //margin: EdgeInsets.all(1),
              padding: const EdgeInsets.symmetric(
                horizontal: 3,
              ),
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text('₹${dailyAmount.toString()}'),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.6,
              width: 15,
              child: RotatedBox(
                quarterTurns: 2, //rotating the stack by 180degrees
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromARGB(255, 172, 191, 201),
                          width: 2,
                        ),
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    FractionallySizedBox(
                      heightFactor: spentPercentage,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(221, 9, 135,
                              13), //Theme.of(context).primaryColor,
                          border: Border.all(
                            width: 1.5,
                            color: Color.fromARGB(255, 149, 194, 151),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(label),
              ),
            ),
          ],
        );
      },
    );
  }
}
