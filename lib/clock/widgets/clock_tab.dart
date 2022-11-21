import 'package:flutter/material.dart';

import '../../clock/clock.dart';

class ClockTab extends StatelessWidget {
  const ClockTab({
    super.key,
    this.currentIndex = 3,
  });

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: clockTabs,
      builder: (context, value, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: value
              .asMap()
              .entries
              .map(
                (e) => Icon(
                  e.value.icon,
                  color: e.key == currentIndex
                      ? const Color(0xFF00D9F6)
                      : Colors.white54,
                  size: 30,
                ),
              )
              .toList(),
        );
      },
    );
  }
}
