import 'package:flutter/material.dart';
import 'app_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(BreakingBadApp(
    appRouter: AppRouter(),
  ));
}

class BreakingBadApp extends StatelessWidget {
  final AppRouter appRouter;

  const BreakingBadApp({Key? key, required this.appRouter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder:(context,child)=> MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}
