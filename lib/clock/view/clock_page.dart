import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../clock/clock.dart';

class ClockPage extends StatelessWidget {
  const ClockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF10121A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ClockTab(),
              const SizedBox(
                height: 20,
              ),
              _buildBedTimeTile(),
              const SizedBox(height: 10),
              const Divider(
                color: Colors.white24,
              ),
              const SizedBox(height: 50),
              const HorizontalCalendar(),
              const ClockFace(),
              _buildBottomTile(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBedTimeTile() {
    return Row(
      children: [
        const Expanded(
          child: Text(
            'Bedtime Schedule',
            style: TextStyle(
              color: Colors.white,
              // fontSize: 40,
            ),
          ),
        ),
        Switch.adaptive(
          value: false,
          onChanged: (value) {},
        ),
      ],
    );
  }

  Widget _buildBottomTile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: const [
            Text(
              '00:00',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Bedtime',
              style: TextStyle(
                color: Color(0xFF1BD3F4),
                // fontSize: 40,
              ),
            ),
            SizedBox(height: 5),
            Icon(
              LineIcons.powerOff,
              color: Color(0xFF1BD3F4),
              size: 40,
            )
          ],
        ),
        Column(
          children: const [
            Text(
              '00:00',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Wake Up',
              style: TextStyle(
                color: Color(0xFF1BD3F4),
                // fontSize: 40,
              ),
            ),
            SizedBox(height: 5),
            Icon(
              LineIcons.bell,
              color: Color(0xFF1BD3F4),
              size: 40,
            ),
          ],
        ),
      ],
    );
  }
}
