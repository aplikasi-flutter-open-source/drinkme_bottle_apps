import 'package:drinking_assistant/core/utils/date_helper.dart';
import 'package:drinking_assistant/core/utils/style_res.dart';
import 'package:drinking_assistant/features/drinking_assistant/domain/entities/history_item_entity.dart';
import 'package:drinking_assistant/features/drinking_assistant/presentation/manager/history/history_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

class HistoryTab extends StatefulWidget {
  @override
  _HistoryTabState createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> with TickerProviderStateMixin {
  List _selectedEvents = [];
  DateTime _selectedDateTime;
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();

    context.bloc<HistoryCubit>().getDrinkHistory();

    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
      _selectedDateTime = day;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HistoryCubit, HistoryState>(
        // ignore: missing_return
        builder: (context, state) {
          if (state is HistoryLoadedState) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                _buildTableCalendarWithBuilders(state.mapEventsHistoryDrink),
                const SizedBox(height: 8.0),
                _buildButtons(),
                const SizedBox(height: 8.0),
                Expanded(child: _buildEventList(state.mapEventsHistoryDrink)),
              ],
            );
          } else if (state is EmptyHistoryState) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: Text(
                    'Hai saat ini kamu belum memiliki history, ayo isi botol mu dulu ;)',
                    textAlign: TextAlign.center,
                    style: text12Bold().copyWith(color: bottleHeaderColor)),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  // More advanced TableCalendar configuration (using Builders & Styles)
  Widget _buildTableCalendarWithBuilders(
      Map<DateTime, List> mapEventsHistoryDrink) {
    return TableCalendar(
      locale: 'id',
      calendarController: _calendarController,
      events: mapEventsHistoryDrink,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
        CalendarFormat.week: '',
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
        holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              color: bottleHeaderColor,
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(fontSize: 16.0, color: white),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            color: Colors.lightBlue[400],
            width: 100,
            height: 100,
            child: Text(
              '${date.day}',
              style: TextStyle().copyWith(fontSize: 16.0),
            ),
          );
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];

          if (events.isNotEmpty) {
            children.add(
              Positioned(
                right: 1,
                bottom: 1,
                child: _buildEventsMarker(date, events),
              ),
            );
          }

          if (holidays.isNotEmpty) {
            children.add(
              Positioned(
                right: -2,
                top: -2,
                child: _buildHolidaysMarker(),
              ),
            );
          }

          return children;
        },
      ),
      onDaySelected: (date, events) {
        _onDaySelected(date, events);
        _animationController.forward(from: 0.0);
      },
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEventsMarker(DateTime date, List<HistoryItemEntity> events) {
    var percentage =
        (events.where((element) => element.isComplete).toList().length /
                10 *
                100)
            .round();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _calendarController.isSelected(date)
            ? Colors.blue[500]
            : _calendarController.isToday(date)
                ? bottleHeaderColor
                : Colors.blue[400],
      ),
      width: 22.w,
      height: 22.w,
      child: FittedBox(
        child: Padding(
          padding: EdgeInsets.all(4.0),
          child: Text(
            '$percentage%',
            style: TextStyle().copyWith(
              color: Colors.white,
              fontSize: 12.sp,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }

  Widget _buildButtons() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Flexible(
              child: RaisedButton(
                color: colorPrimary,
                textColor: white,
                child: Text('View Month'),
                onPressed: () {
                  setState(() {
                    _calendarController.setCalendarFormat(CalendarFormat.month);
                  });
                },
              ),
            ),
            Flexible(
              child: RaisedButton(
                color: colorPrimary,
                textColor: white,
                child: Text('View 2 weeks'),
                onPressed: () {
                  setState(() {
                    _calendarController
                        .setCalendarFormat(CalendarFormat.twoWeeks);
                  });
                },
              ),
            ),
            Flexible(
              child: RaisedButton(
                color: colorPrimary,
                textColor: white,
                child: Text('View Week'),
                onPressed: () {
                  setState(() {
                    _calendarController.setCalendarFormat(CalendarFormat.week);
                  });
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }

  Widget _buildEventList(Map<DateTime, List> mapEventsHistoryDrink) {
    var todayFormat =
        DateTimeHelper.dateTimeFromString(DateTimeHelper.nowFormatyyyyMMdd);
    bool isThisEventToday =
        _calendarController.isToday(_selectedDateTime ?? todayFormat);

    List<HistoryItemEntity> listEventToShow = _selectedEvents.length == 0
        ? mapEventsHistoryDrink[todayFormat]?.length != null && isThisEventToday
            ? mapEventsHistoryDrink[todayFormat]
            : []
        : _selectedEvents;

    return ListView(
      children: listEventToShow.map((event) {
        var doubleNow =
            DateTimeHelper.hourToDoubleFromDateTime(DateTimeHelper.now);
        var doubleLimitHour =
            DateTimeHelper.hourToDoubleFromDateString('0000-00-00 19:00:00');

        return Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.8),
            borderRadius: BorderRadius.circular(12.0),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: ListTile(
            title: Text(DateTimeHelper.format12HourClock(event.hour)),
            subtitle: Text(event.isComplete
                ? 'Berhasil'
                : doubleNow < doubleLimitHour && isThisEventToday
                    ? 'Menunggu'
                    : 'Gagal'),
            trailing: Icon(
                event.isComplete
                    ? Icons.check_circle
                    : doubleNow < doubleLimitHour && isThisEventToday
                        ? Icons.watch_later
                        : Icons.remove_circle,
                color: event.isComplete
                    ? colorPrimary
                    : doubleNow < doubleLimitHour && isThisEventToday
                        ? Colors.orange
                        : Colors.red),
            onTap: () {},
          ),
        );
      }).toList(),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }
}
