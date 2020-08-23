import 'package:drinking_assistant/core/utils/const.dart';
import 'package:drinking_assistant/core/utils/style_res.dart';
import 'package:drinking_assistant/cubit_observer.dart';
import 'package:drinking_assistant/features/drinking_assistant/data/models/drink_history_model.dart';
import 'package:drinking_assistant/features/drinking_assistant/data/models/history_model.dart';
import 'package:drinking_assistant/features/drinking_assistant/presentation/manager/drink/drink_cubit.dart';
import 'package:drinking_assistant/features/drinking_assistant/presentation/manager/history/history_cubit.dart';
import 'package:drinking_assistant/features/drinking_assistant/presentation/pages/history/history_tab.dart';
import 'package:drinking_assistant/features/drinking_assistant/presentation/pages/info/info_tab.dart';
import 'package:drinking_assistant/features/drinking_assistant/presentation/pages/tracking/tracking_tab.dart';
import 'package:drinking_assistant/features/opening/presentation/pages/splash_screen.dart';
import 'package:drinking_assistant/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'injection.dart' as di;

void main() async {
  Bloc.observer = CubitObserver();
  await Hive.initFlutter();
  Hive.registerAdapter(DrinkHistoryModelAdapter());
  Hive.registerAdapter(HistoryModelAdapter());
  await Hive.openBox(DRINK_HISTORY_BOX);
  await di.init();

  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Drinking Assistant',
      home: SplashScreen(),
    );
  }
}

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle tabTitleStyle = GoogleFonts.muli(fontSize: 14.sp);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(color: colorPrimary),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(ScreenUtil.screenHeight * 0.015),
            child: Column(
              children: <Widget>[
                TabBar(
                  labelColor: colorPrimary,
                  unselectedLabelColor: white,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorPadding: EdgeInsets.all(16.0),
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(5), color: white),
                  tabs: <Widget>[
                    Container(
                      height: ScreenUtil.screenHeight * 0.04,
                      width: ScreenUtil.screenWidth * 0.4,
                      child: Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.schedule, size: 20),
                            SizedBox(width: 5),
                            Text("Tracking", style: tabTitleStyle),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: ScreenUtil.screenHeight * 0.04,
                      width: ScreenUtil.screenWidth * 0.4,
                      child: Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.history, size: 20),
                            SizedBox(width: 5),
                            Text("History", style: tabTitleStyle),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: ScreenUtil.screenHeight * 0.04,
                      width: ScreenUtil.screenWidth * 0.4,
                      child: Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.info_outline, size: 20),
                            SizedBox(width: 5),
                            Text("Info", style: tabTitleStyle),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.0)
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            BlocProvider(create: (_) => sl<DrinkCubit>(), child: TrackingTab()),
            BlocProvider(
                create: (_) => sl<HistoryCubit>(), child: HistoryTab()),
            InfoTab(),
          ],
        ),
      ),
    );
  }
}
