import 'package:flutter/material.dart';

class CalendarTiile extends StatelessWidget {
  const CalendarTiile({
    super.key,
    this.active = false,
  });

  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: active ? const Color(0xFF1BD3F4) : const Color(0xFF171C26),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        'M',
        style: TextStyle(
          fontSize: 20,
          color: active ? Colors.black : Colors.white54,
        ),
      ),
    );
  }
}

class HorizontalCalendar extends StatelessWidget {
  const HorizontalCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        itemCount: 10,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(width: 20),
        itemBuilder: (BuildContext context, int index) {
          return CalendarTiile(
            active: index.isEven,
          );
        },
      ),
    );
  }
}
