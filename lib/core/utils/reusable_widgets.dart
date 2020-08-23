import 'package:drinking_assistant/core/utils/image_res.dart';
import 'package:drinking_assistant/core/utils/style_res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableWidgets {
  static showLoading(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(shape: CircleBorder(), child: loading());
        });
  }

  static Widget loading() => Stack(
        alignment: Alignment.center,
        children: [
          Container(
              width: .25.wp,
              height: .25.wp,
              padding: EdgeInsets.all(.05.wp),
              decoration:
                  ShapeDecoration(color: Colors.white, shape: CircleBorder()),
              child: Image.asset(splash_reverse)),
          SizedBox(
              width: .25.wp,
              height: .25.wp,
              child: CircularProgressIndicator()),
        ],
      );

  static showDialogOneButton(
    BuildContext context, {
    @required String title,
    @required String subtitle,
  }) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: GoogleFonts.muli(
                  fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.muli(fontSize: 12.sp),
            ),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Oke'),
          ),
        ],
      ),
    );
  }

  static showDialogYesNoButton(BuildContext context,
      {@required String title,
      @required String subtitle,
      @required bool useBottleGif,
      VoidCallback onTapYes}) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            useBottleGif
                ? Column(
                    children: [
                      SizedBox(height: 15.w),
                      Image.asset(splash_reverse, scale: 3),
                    ],
                  )
                : SizedBox(),
            SizedBox(height: 15.w),
            Text(
              title,
              style: GoogleFonts.muli(
                  fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              subtitle,
              style: GoogleFonts.muli(fontSize: 12.sp),
            ),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text('BELUM'),
          ),
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
              onTapYes();
            },
            child: Text('YAKIN'),
          ),
        ],
      ),
    );
  }

  static showDialogInstruction(BuildContext context, {VoidCallback onTapYes}) {
    return showDialog(
      context: context,
      builder: (context) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: .9.wp,
              height: 50.w,
              decoration: BoxDecoration(
                  color: colorPrimary,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(10))),
              child: Center(
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    'INSTRUKSI',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.muli(
                        color: white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              color: white,
              width: .9.wp,
              child: Material(
                color: white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: <Widget>[
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                    height: .25.hp,
                                    width: .3.wp,
                                    child: FadeInImage.assetNetwork(
                                        placeholder: splash,
                                        image: instruction1,
                                        fit: BoxFit.fitHeight)),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 4, horizontal: 8),
                                          margin: EdgeInsets.only(bottom: 6),
                                          decoration: ShapeDecoration(
                                              color: colorPrimary,
                                              shape: StadiumBorder()),
                                          child: Text(
                                            '1. Isi Penuh Botol Kamu',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.muli(
                                                color: white,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Text(
                                          'Isi botol kamu dengan air putih, pastikan botol terisi penuh dengan air ya...',
                                          textAlign: TextAlign.justify,
                                          style:
                                              GoogleFonts.muli(fontSize: 12.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 10.w),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                    height: .25.hp,
                                    width: .3.wp,
                                    child: FadeInImage.assetNetwork(
                                        placeholder: splash,
                                        image: instruction2,
                                        fit: BoxFit.fitHeight)),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 4, horizontal: 8),
                                          margin: EdgeInsets.only(bottom: 6),
                                          decoration: ShapeDecoration(
                                              color: colorPrimary,
                                              shape: StadiumBorder()),
                                          child: Text(
                                            '2. Scan QRCode Botol',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.muli(
                                                color: white,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Text(
                                          'Setelah botol terisi, klik tombol "Scan QRCode" dibawah untuk melakukan pemindaian QRCode yang terdapat pada tutup botol, tujuannya untuk memverifikasi botol agar aplikasi dapat digunakan...',
                                          textAlign: TextAlign.justify,
                                          style:
                                              GoogleFonts.muli(fontSize: 12.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 10.w),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                    height: .25.hp,
                                    width: .3.wp,
                                    child: FadeInImage.assetNetwork(
                                        placeholder: splash,
                                        image: instruction3,
                                        fit: BoxFit.fitHeight)),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 4, horizontal: 8),
                                          margin: EdgeInsets.only(bottom: 6),
                                          decoration: ShapeDecoration(
                                              color: colorPrimary,
                                              shape: StadiumBorder()),
                                          child: Text(
                                            '3. Kondisikan Posisi Botol',
//                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.muli(
                                                color: white,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Text(
                                          'Letakan botol didekat jangkauan dan posisikan bagian belakang botol kearah pandangan kamu, sehingga kamu akan selalu ingat untuk minum, jika waktu minum tiba aplikasi juga akan mengingatkan kamu kok...',
                                          textAlign: TextAlign.justify,
                                          style:
                                              GoogleFonts.muli(fontSize: 12.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: .9.wp,
              height: 50.w,
              child: ClipRRect(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(10)),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Material(
                          color: white.withOpacity(0.8),
                          child: InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Center(
                                child:
                                    Text('Batal', style: GoogleFonts.muli())),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Material(
                          color: colorPrimary,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              onTapYes();
                            },
                            child: Center(
                                child: Text('Scan QRcode',
                                    style: GoogleFonts.muli(
                                        color: white,
                                        fontWeight: FontWeight.bold))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
