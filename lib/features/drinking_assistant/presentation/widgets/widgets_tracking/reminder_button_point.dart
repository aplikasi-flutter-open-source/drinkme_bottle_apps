import 'package:drinking_assistant/core/utils/date_helper.dart';
import 'package:drinking_assistant/core/utils/reusable_widgets.dart';
import 'package:drinking_assistant/features/drinking_assistant/domain/entities/history_item_entity.dart';
import 'package:drinking_assistant/features/drinking_assistant/presentation/manager/drink/drink_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

const int WAIT = 1;
const int UPCOMING = 2;
const int DONE = 3;

class ReminderButtonPoint extends StatelessWidget {
  final double size;
  final int status;
  final String time;
  final HistoryItemEntity historyItem;

  const ReminderButtonPoint({
    Key key,
    @required this.size,
    @required this.time,
    @required this.status,
    @required this.historyItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (status == WAIT) {
      return Stack(
        overflow: Overflow.visible,
        children: [
          SizedBox(
            height: size,
            width: size,
            child: FlatButton(
              padding: EdgeInsets.all(8),
              textColor: Colors.lightBlue,
              color: Colors.white,
              child: FittedBox(
                  child: Text(time, style: GoogleFonts.muli(fontSize: 26.sp))),
              shape: CircleBorder(),
              onPressed: () {
                final double historyItemHourDouble =
                    DateTimeHelper.hourToDoubleFromDateString(historyItem.hour);
                final double dateTimeNowDouble =
                    DateTimeHelper.hourToDoubleFromDateTime(DateTimeHelper.now);

                if (historyItemHourDouble < dateTimeNowDouble) {
                  ReusableWidgets.showDialogYesNoButton(context,
                      useBottleGif: false,
                      title: 'Apakah kamu yakin?',
                      subtitle: 'Sudah minum untuk jam $time?', onTapYes: () {
                    HistoryItemEntity historyItemNew = HistoryItemEntity(
                        id: historyItem.id,
                        hour: historyItem.hour,
                        isComplete: !historyItem.isComplete,
                        percentage: historyItem.percentage);
//                    print('DATAA $historyItemNew');
                    context
                        .bloc<DrinkCubit>()
                        .updateDrinkHistory(historyItemNew);
                  });
                } else {
                  ReusableWidgets.showDialogOneButton(
                    context,
                    title: 'Hai Mohon Maaf :)',
                    subtitle:
                        'Waktu belum menunjukan pukul $time\n kamu dapat kembali lagi jam $time',
                  );
                }
              },
            ),
          ),
          Positioned(
            top: -2,
            right: -2,
            child: Icon(
              Icons.watch_later,
              color: Colors.pinkAccent.withOpacity(0.6),
              size: size * .45,
            ),
          )
        ],
      );
    } else if (status == UPCOMING) {
      return SizedBox(
        height: size,
        width: size,
        child: FlatButton(
          padding: EdgeInsets.all(8),
          textColor: Colors.white,
          color: Colors.transparent,
          child: FittedBox(
              child: Text(time, style: GoogleFonts.muli(fontSize: 26.sp))),
          shape: CircleBorder(side: BorderSide(width: 1, color: Colors.white)),
          onPressed: () {
            ReusableWidgets.showDialogOneButton(
              context,
              title: 'Hai Mohon Maaf :)',
              subtitle:
                  'Waktu belum menunjukan pukul $time\n kamu dapat kembali lagi jam $time',
            );
          },
        ),
      );
    } else {
      //if done
      return Stack(
        overflow: Overflow.visible,
        children: [
          SizedBox(
            height: size,
            width: size,
            child: FlatButton(
              padding: EdgeInsets.all(8),
              onPressed: () {},
              textColor: Colors.lightBlue,
              child: FittedBox(
                  child: Text(time, style: GoogleFonts.muli(fontSize: 26.sp))),
              shape: CircleBorder(
                  side: BorderSide(width: 1, color: Colors.lightBlue)),
            ),
          ),
          Positioned(
            top: -2,
            right: -2,
            child: Container(
              decoration: ShapeDecoration(
                  color: Color(0xffE1E6E9),
                  shape: CircleBorder(
                      side: BorderSide(
                    width: 1,
                    color: Colors.transparent,
                  ))),
              child: Icon(
                Icons.check_circle, color: Colors.lightBlue,
                size: size * .4,
//                color: Color(0xffE1E6E9),
              ),
            ),
          )
        ],
      );
    }
  }

//    if (upcoming) {
//      return Stack(
//        overflow: Overflow.visible,
//        children: [
//          SizedBox(
//            height: size,
//            width: size,
//            child: FlatButton(
//              padding: EdgeInsets.all(8),
////              borderSide: BorderSide(color: Colors.white),
//              onPressed: () {},
//              textColor: Colors.lightBlue,
//              color: Colors.white,
//              child: FittedBox(
//                  child: Text(time, style: GoogleFonts.muli(fontSize: 26.sp))),
//              shape: CircleBorder(),
//            ),
//          ),
//          Positioned(
//            top: -2,
//            right: -2,
//            child: Icon(
////              statusButton == StatusButtonUpcoming.WAITFORTIME
////                  ? Icons.do_not_disturb_on
////                  :
//              Icons.watch_later,
//              color: Colors.pinkAccent.withOpacity(0.6),
//              size: size * .45,
//            ),
//          )
//        ],
//      );
//    } else {
//      return SizedBox(
//        height: size,
//        width: size,
//        child: FlatButton(
//          padding: EdgeInsets.all(8),
////              borderSide: BorderSide(color: Colors.white),
//          onPressed: () {},
////                        textColor: Color(0xff3A556A),
//          textColor: Colors.white,
////          color: Colors.lightBlue,
//          color: Colors.transparent,
////              splashColor: Colors.white,
//          child: FittedBox(
//              child: Text(time, style: GoogleFonts.muli(fontSize: 26.sp))),
//          shape: CircleBorder(side: BorderSide(width: 1, color: Colors.white)),
//        ),
//      );
//    }
}
