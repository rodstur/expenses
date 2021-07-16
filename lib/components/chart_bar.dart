import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final String value;
  final double percentage;

  const ChartBar(
      {this.percentage = 0, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrainst) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Column(
          children: [
            SizedBox(
              height: constrainst.maxHeight * 0.15,
              child: FittedBox(child: FittedBox(child: Text(value.toString()))),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: constrainst.maxHeight * 0.05,
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: const Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                height: constrainst.maxHeight * 0.60,
                width: 10,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    FractionallySizedBox(
                      heightFactor: percentage,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: constrainst.maxHeight * 0.15,
              child: FittedBox(child: Text(label)),
            ),
          ],
        ),
      ),
    );
  }
}
