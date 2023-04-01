import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // 日付をキャプチャする変数の作成
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime foucusDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // スマホ画面上部の文字
      appBar: AppBar(title: Text("table_calendar")),
      body: content(),
    );
  }

  Widget content() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Text(
            "Selected Day = " + today.toString().split(" ")[0],
          ),
          Container(
            // このように追加するだけでカレンダーが表示される。
            // （表示自体はfocusDay、firstDay、lastDayの３つでOK！）
            child: TableCalendar(
              focusedDay: today,
              firstDay: DateTime.utc(2020, 4, 1),
              lastDay: DateTime.utc(2030, 3, 31),
              rowHeight: 60,
              // デフォルトで表示されている２weeksを消し、年月表示を中央揃え
              headerStyle:
                  HeaderStyle(formatButtonVisible: false, titleCentered: true),
              // availableGestures: AvailableGestures.all,
              // 選択した日付にもマークを出す
              onDaySelected: _onDaySelected,
              selectedDayPredicate: (day) => isSameDay(day, today),
            ),
          ),
        ],
      ),
    );
  }
}
