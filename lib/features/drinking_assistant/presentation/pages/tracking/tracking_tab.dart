import 'package:drinking_assistant/core/platform/barcode_scanner_service.dart';
import 'package:drinking_assistant/core/utils/date_helper.dart';
import 'package:drinking_assistant/core/utils/image_res.dart';
import 'package:drinking_assistant/core/utils/reusable_widgets.dart';
import 'package:drinking_assistant/core/utils/style_res.dart';
import 'package:drinking_assistant/features/drinking_assistant/domain/entities/history_item_entity.dart';
import 'package:drinking_assistant/features/drinking_assistant/presentation/manager/drink/drink_cubit.dart';
import 'package:drinking_assistant/features/drinking_assistant/presentation/widgets/widgets_tracking/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';

class TrackingTab extends StatefulWidget {
  @override
  _TrackingTabState createState() => _TrackingTabState();
}

class _TrackingTabState extends State<TrackingTab>
    with AutomaticKeepAliveClientMixin<TrackingTab> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.bloc<DrinkCubit>().getDrinkHistoryToday();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          final bottleBodyHeight = constraints.maxHeight * (0.8);
          final buttonHeight = constraints.maxHeight * 0.081;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: constraints.maxHeight * 0.10,
                  width: constraints.maxWidth * 0.65,
                  decoration: ShapeDecoration(
                      color: bottleHeaderColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                              bottom: Radius.circular(5)))),
                ),
                BlocConsumer<DrinkCubit, DrinkState>(
                  listener: (context, state) {
                    if (state is DrinkLoadingState) {
                      ReusableWidgets.showLoading(context);
                    } else if (state is DrinkFailureState) {
                      Toast.show(state.message, context,
                          duration: Toast.LENGTH_LONG);
                      if (Navigator.canPop(context)) Navigator.pop(context);
                    } else if (state is DrinkHistoryLoadedState) {
//                      if (state is DrinkHistoryLoadedState)
                      Toast.show(state.message, context,
                          duration: Toast.LENGTH_LONG);
                      if (Navigator.canPop(context)) Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    final int halfOfDayPointReminder = 5;
                    final int notYet = 0;

                    final List<HistoryItemEntity> listHistoryItemToShow = [];
                    final List<int> status = [];

                    if (state is DrinkHistoryLoadedState) {
                      final List<HistoryItemEntity> listHistoryItem =
                          state.data.histories;
                      int isCompleteTotal = notYet;
                      listHistoryItem.forEach((element) {
                        if (element.isComplete) isCompleteTotal += 1;
                      });

                      String limitHour = isCompleteTotal <= 4
                          ? '19:00:00.000000'
                          : isCompleteTotal == 5
                              ? '12:01:01.000000'
                              : '13:01:01.000000';

                      final limitTimeHalfOfDay =
                          DateTimeHelper.dateTimeFromString(
                              '${DateTimeHelper.nowFormatyyyyMMdd} $limitHour');

                      status.clear();
                      listHistoryItem.forEach((historyItem) {
                        final double historyItemHourDouble =
                            DateTimeHelper.hourToDoubleFromDateString(
                                historyItem.hour);
                        final double dateTimeNowDouble =
                            DateTimeHelper.hourToDoubleFromDateTime(
                                DateTimeHelper.now);

                        if (DateTimeHelper.now.isBefore(limitTimeHalfOfDay)) {
                          if (historyItem.id <= halfOfDayPointReminder) {
                            listHistoryItemToShow.add(historyItem);
                            if (historyItem.isComplete) {
                              status.add(DONE);
                            } else {
                              if (historyItemHourDouble <= dateTimeNowDouble) {
                                status.add(WAIT);
                              } else {
                                if (historyItemHourDouble - dateTimeNowDouble <=
                                    1) {
                                  status.add(WAIT);
                                } else {
                                  status.add(UPCOMING);
                                }
                              }
                            }
                          }
                        } else {
                          if (historyItem.id > halfOfDayPointReminder) {
                            listHistoryItemToShow.add(historyItem);
                            if (historyItem.isComplete) {
                              status.add(DONE);
                            } else {
                              if (historyItemHourDouble <= dateTimeNowDouble) {
                                status.add(WAIT);
                              } else {
                                if (historyItemHourDouble - dateTimeNowDouble <=
                                    1) {
                                  status.add(WAIT);
                                } else {
                                  status.add(UPCOMING);
                                }
                              }
                            }
                          }
                        }
                      });
                      return Stack(
                        children: [
                          ClipPath(
                            clipper: BottleClipper(),
                            child: Container(
                              height: constraints.maxHeight * 0.8,
                              width: constraints.maxWidth * 0.8,
                              color: Color(0xffE1E6E9),
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(
                                      constraints.maxWidth * 0.12),
                                ),
                                child: state.data.percentage != 0
                                    ? WaterWaves(
                                        colorPrimary,
                                        colorPrimary,
//                                  95,
                                        state.data.percentage,
                                      )
                                    : Container(
                                        margin: EdgeInsets.only(left: 50.w),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 150.w,
                                              child: Card(
                                                  child: Padding(
                                                padding: EdgeInsets.all(10.w),
                                                child: Text(
                                                    'Selamat kamu\nberhasil hari ini',
                                                    style: text12Bold()
                                                        .copyWith(
                                                            color:
                                                                colorPrimary)),
                                              )),
                                            ),
                                            SizedBox(
                                              width: 150.w,
                                              child: Card(
                                                  child: Padding(
                                                padding: EdgeInsets.all(10.w),
                                                child: Text(
                                                    'Jangan lupa ulangi lagi besok ;)',
                                                    style: text12Bold()
                                                        .copyWith(
                                                            color:
                                                                colorPrimary)),
                                              )),
                                            )
                                          ],
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 30,
                            top: 50,
                            child: BottleReflection(constraints),
                          ),
                          Positioned(
                            bottom: (bottleBodyHeight * 0.8333333333) -
                                buttonHeight / 2,
                            left: 20,
                            child: ReminderButtonPoint(
                              size: buttonHeight,
                              time: DateTimeHelper.format12HourClock(
                                  listHistoryItemToShow[0].hour),
                              status: status[0],
                              historyItem: listHistoryItemToShow[0],
                            ),
                          ),
                          Positioned(
                              left: 19 + buttonHeight / 2,
                              top: (bottleBodyHeight * 0.1666666667) +
                                  buttonHeight / 2,
                              bottom: (bottleBodyHeight * 0.6666666667) +
                                  buttonHeight / 2,
                              child: VerticalDivider(
                                  color: Colors.white,
                                  width: 1,
                                  thickness: 1.3)),
                          Positioned(
                            bottom: (bottleBodyHeight * 0.6666666667) -
                                buttonHeight / 2,
                            left: 20,
                            child: ReminderButtonPoint(
                                size: buttonHeight,
                                time: DateTimeHelper.format12HourClock(
                                    listHistoryItemToShow[1].hour),
                                status: status[1],
                                historyItem: listHistoryItemToShow[1]),
                          ),
                          Positioned(
                              left: 19 + buttonHeight / 2,
                              top: (bottleBodyHeight * 0.3333333333) +
                                  buttonHeight / 2,
                              bottom:
                                  (bottleBodyHeight * 0.5) + buttonHeight / 2,
                              child: VerticalDivider(
                                  color: Colors.white,
                                  width: 1,
                                  thickness: 1.3)),
                          Positioned(
                            bottom:
                                (bottleBodyHeight * 0.50) - buttonHeight / 2,
                            left: 20,
                            child: ReminderButtonPoint(
                                size: buttonHeight,
                                time: DateTimeHelper.format12HourClock(
                                    listHistoryItemToShow[2].hour),
                                status: status[2],
                                historyItem: listHistoryItemToShow[2]),
                          ),
                          Positioned(
                              left: 19 + buttonHeight / 2,
                              top: (bottleBodyHeight * 0.5) + buttonHeight / 2,
                              bottom: (bottleBodyHeight * 0.3333333333) +
                                  buttonHeight / 2,
                              child: VerticalDivider(
                                  color: Colors.white,
                                  width: 1,
                                  thickness: 1.3)),
                          Positioned(
                            bottom: (bottleBodyHeight * 0.3333333333) -
                                buttonHeight / 2,
                            left: 20,
                            child: ReminderButtonPoint(
                                size: buttonHeight,
                                time: DateTimeHelper.format12HourClock(
                                    listHistoryItemToShow[3].hour),
                                status: status[3],
                                historyItem: listHistoryItemToShow[3]),
                          ),
                          Positioned(
                              left: 19 + buttonHeight / 2,
                              top: (bottleBodyHeight * 0.6666666667) +
                                  buttonHeight / 2,
                              bottom: (bottleBodyHeight * 0.1666666667) +
                                  buttonHeight / 2,
                              child: VerticalDivider(
                                  color: Colors.white,
                                  width: 1,
                                  thickness: 1.3)),
                          Positioned(
                            bottom: (bottleBodyHeight * 0.1666666667) -
                                buttonHeight / 2,
                            left: 20,
                            child: ReminderButtonPoint(
                                size: buttonHeight,
                                time: DateTimeHelper.format12HourClock(
                                    listHistoryItemToShow[4].hour),
                                status: status[4],
                                historyItem: listHistoryItemToShow[4]),
                          ),
                        ],
                      );
                    } else {
                      return ClipPath(
                        clipper: BottleClipper(),
                        child: Container(
                          height: constraints.maxHeight * 0.8,
                          width: constraints.maxWidth * 0.8,
                          color: Color(0xffE1E6E9),
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Kamu belum mengisi botolmu hari ini ;)',
                                style: GoogleFonts.muli(
                                    color: bottleHeaderColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10.w),
                              RaisedButton.icon(
                                color: colorPrimary,
                                textColor: white,
                                icon: Image.asset(splash_reverse, scale: 8),
                                label: Text(
                                  'Isi Botolmu Sekarang',
                                  style: GoogleFonts.muli(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  ReusableWidgets.showDialogInstruction(context,
                                      onTapYes: () {
                                    ReusableWidgets.showDialogYesNoButton(
                                        context,
                                        title: 'Apakah kamu yakin?',
                                        subtitle:
                                            'Sudah mengisi penuh botolmu?',
                                        useBottleGif: true, onTapYes: () {
                                      QRScanner().scan().then((value) {
                                        print(
                                            'value.rawContent ${value.rawContent}');
                                        context
                                            .bloc<DrinkCubit>()
                                            .authenticateBottle(
                                                value.rawContent);
                                      });
                                    });
                                  });
                                },
                              )
                            ],
                          )),
                        ),
                      );
                    }
                  },
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
