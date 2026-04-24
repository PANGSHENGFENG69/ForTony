import 'package:device_preview/device_preview.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/bizlib.dart';
import 'package:flutter_demo/bizlib.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:multi_mode_animated_snack/multi_mode_animated_snack.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => LoginVM()),
        ChangeNotifierProvider(create: (_) => HomePageVM()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      locale: const Locale('en', 'US'), //預設語言，有空在把 這個寫死的值 改去 自動偵測手機系統的值
      routerConfig: router,
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('zh'),
        //其他語言
      ],
      localizationsDelegates: const [
        // AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        final mediaQuery = MediaQuery.of(context);
        return MediaQuery(
          data: mediaQuery.copyWith(
            textScaleFactor: 1.0,
          ), //防呆 別人自己去 手機系統設定改 字體大小
          child: child ?? const SizedBox.shrink(),
        );
      },
      theme: ThemeData(
        fontFamily: 'NotoSansTC', //可以參考 googlefonts
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Color(0xff7E22CE), //主要顏色
        ),
      ),
    );
  }
}

final GoRouter router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/home',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return TonyLayout(vm: context.read<HomePageVM>(), child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          pageBuilder: (context, state) =>
              fadePage(key: state.pageKey, child: HomePage()),
        ),
        GoRoute(
          path: '/profile',
          pageBuilder: (context, state) =>
              fadePage(key: state.pageKey, child: ProfilePage()),
        ),
      ],
    ),
  ],
);
