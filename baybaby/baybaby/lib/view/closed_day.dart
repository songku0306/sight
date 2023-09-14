// import 'package:flutter/material.dart';

// class ClosedDay extends StatefulWidget {
//   const ClosedDay({super.key});

//   @override
//   State<ClosedDay> createState() => _ClosedDayState();
// }

// class _ClosedDayState extends State<ClosedDay> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         Text(
//           '데일리 리포트',
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         Text('총 수유량: ${calculateTotalFeedingAmount()} ml'),
//         Text(
//             '총 수면 시간: ${calculateTotalSleepTime().inHours}시간 ${calculateTotalSleepTime().inMinutes % 60}분'),
//         Text('총 기저귀 횟수: ${calculateTotalDiaperCount()}회'),
//       ),
//     );
//   }
// }
