import 'package:drinking_assistant/core/utils/image_res.dart';
import 'package:drinking_assistant/core/utils/style_res.dart';
import 'package:drinking_assistant/features/drinking_assistant/presentation/manager/drink/drink_cubit.dart';
import 'package:drinking_assistant/features/opening/presentation/manager/splash_cubit.dart';
import 'package:drinking_assistant/injection.dart';
import 'package:drinking_assistant/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    final width=MediaQuery.of(context).size.width;
//    final height=MediaQuery.of(context).size.height;
//    ScreenUtil.init(context, width: width, height: height, allowFontScaling: false);
    ScreenUtil.init(context, width: 360, height: 640, allowFontScaling: true);

    return BlocProvider(create: (_) => SplashCubit(), child: SplashView());
  }
}

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(dispatchSetSplash);
    super.initState();
  }

  void dispatchSetSplash(_) {
    context.bloc<SplashCubit>().startSplash();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(splash, scale: 2),
            SizedBox(height: 10.w),
            Text(
              'Drink Me Bottle Apps',
              style: text18Bold().copyWith(color: bottleHeaderColor),
            ),
            SizedBox(height: 5.w),
            BlocConsumer<SplashCubit, SplashState>(
              listener: (context, state) {
                if (state is SplashFinish) {
                  Future.delayed(Duration(seconds: 1, milliseconds: 500)).then(
                      (_) => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => BlocProvider(
                                  create: (_) => sl<DrinkCubit>(),
                                  child: App()))));
                }
              },
              builder: (context, state) {
                String text = state is SplashStart || state is SplashInitial
                    ? 'My Drink Reminder Bottle'
                    : 'Jangan Lupa Minum Hari Ini ;)';

                return Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 5),
                  decoration: ShapeDecoration(
                      color: colorPrimary, shape: StadiumBorder()),
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: text12Bold().copyWith(color: white),
                  ),
                );
              },
            ),
//            SizedBox(
//                height: 20,
//                width: 20,
//                child: CircularProgressIndicator(
//                    backgroundColor: colorPrimary,
//                    valueColor: AlwaysStoppedAnimation<Color>(greyInput))),
          ],
        ),
      ),
    );
  }
}
