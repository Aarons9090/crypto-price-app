import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import "price_api.dart";
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class AppColors {
  Color dark = Color.fromRGBO(26, 26, 64, 1);
  Color dark_purple = Color.fromRGBO(39, 0, 130, 1);
  Color purple = Color.fromRGBO(122, 11, 192, 1);
  Color pink = Color.fromRGBO(250, 88, 182, 1);
}

String assetName = "bitcoin";
String vsCurrency = "eur";
String from = "1577836800";
String to = "1579936800";
List<Color> gradientColors = [
  AppColors().dark_purple,
  AppColors().purple,
];
SideTitles get sideTitles => SideTitles(
    showTitles: true,
    reservedSize: 40,
    getTextStyles: (context, value) {
      return const TextStyle(color: Colors.white30);
    });
LineChart getPriceChart(List<FlSpot> spots) {
  return LineChart(
    LineChartData(
      gridData: FlGridData(
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        rightTitles: sideTitles,
        leftTitles: sideTitles,
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          interval: (int.parse(to) - int.parse(from)) * 650,
          margin: 8,
          textAlign: TextAlign.right,
          getTextStyles: (context, value) => const TextStyle(
            color: Colors.white30,
            fontWeight: FontWeight.normal,
            fontSize: 10,
          ),
          getTitles: (value) {
            int v = value.round();
            return DateFormat("dd/MM/yyyy")
                .format(DateTime.fromMillisecondsSinceEpoch(v));
          },
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          colors: [AppColors().pink],
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
          isCurved: true,
          isStrokeCapRound: true,
          preventCurveOverShooting: true,
          dotData: FlDotData(show: false),
          spots: spots,
        ),
      ],
    ),
  );
}

FutureBuilder getChartBuilder() {
  return FutureBuilder(
    future: PriceAPICall().getPosts(vsCurrency, from, to, assetName),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.hasData) {
        List<FlSpot> spots = [];
        Map<int, double> map = snapshot.data as Map<int, double>;
        map.forEach((key, value) =>
            {spots.add(FlSpot(double.parse(key.toString()), value))});
        return getPriceChart(spots);
      } else {
        return const Text("no data");
      }
    },
  );
}

void setRequestTime(Duration duration) {
  DateTime past = DateTime.now().subtract(duration);
  DateTime now = DateTime.now();
  from = (past.millisecondsSinceEpoch / 1000).floor().toString();
  to = (now.millisecondsSinceEpoch / 1000).floor().toString();
}

class _MyHomePageState extends State<MyHomePage> {
  // Time range buttons
  Row get timeRangeButtons => Row(
        children: [
          Expanded(
            child: Container(
              height: 40,
              width: 100,
              child: FittedBox(
                child: FloatingActionButton.extended(
                  backgroundColor: AppColors().dark_purple,
                  splashColor: AppColors().pink,
                  extendedPadding: const EdgeInsets.all(30),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  label:
                      Text("3MTH", style: TextStyle(color: AppColors().pink)),
                  onPressed: () {
                    setRequestTime(const Duration(days: 90));
                    setState(() {});
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 40,
              width: 100,
              child: FittedBox(
                child: FloatingActionButton.extended(
                  backgroundColor: AppColors().dark_purple,
                  splashColor: AppColors().pink,
                  extendedPadding: const EdgeInsets.all(40),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  label: Text("1Y", style: TextStyle(color: AppColors().pink)),
                  onPressed: () {
                    setRequestTime(const Duration(days: 365));
                    setState(() {});
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 40,
              width: 100,
              child: FittedBox(
                child: FloatingActionButton.extended(
                  backgroundColor: AppColors().dark_purple,
                  splashColor: AppColors().pink,
                  extendedPadding: const EdgeInsets.all(40),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  label: Text("3Y", style: TextStyle(color: AppColors().pink)),
                  onPressed: () {
                    setRequestTime(const Duration(days: 1090));
                    setState(() {});
                  },
                ),
              ),
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Scaffold(
      backgroundColor: AppColors().dark,
      appBar: AppBar(
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.menu))],
          backgroundColor: AppColors().dark_purple,
          title: const Text("Price App")),
      body: Wrap(
        children: [
          Center(
            child: Title(
              child: Text(assetName.toUpperCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 40,
                      color: Colors.white)),
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 300,
            width: 500,
            child: Padding(
                padding: const EdgeInsets.all(10), child: getChartBuilder()),
          ),
          timeRangeButtons,
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 30, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Expanded(child: Text("Asset name:")),
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: controller,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
              onPressed: () {
                assetName = controller.text;
                setState(() {});
              },
              child: const Text("Refresh")),
        ],
      ),
    );
  }
}
