import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class ClockTabItem {
  const ClockTabItem({required this.icon});
  final IconData icon;
}

final clockTabs = ValueNotifier<List<ClockTabItem>>(const [
  ClockTabItem(
    icon: Icons.alarm,
  ),
  ClockTabItem(
    icon: LineIcons.clock,
  ),
  ClockTabItem(
    icon: LineIcons.bed,
  ),
  ClockTabItem(
    icon: LineIcons.stopwatch,
  ),
  ClockTabItem(
    icon: Icons.sync,
  )
]);
