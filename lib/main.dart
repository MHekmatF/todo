
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/settings_provider.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';
import 'package:todo/theme.dart';

import 'auth/login_screen.dart';
import 'auth/register_screen.dart';
import 'auth/user_provider.dart';
import 'home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await FirebaseFirestore.instance.disableNetwork();
  // FirebaseFirestore.instance.settings =
  //     Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SettingsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(create: (_) => TasksProvider()
            //..getTasks(),
            ),
      ],
      child: const TodoApp(),
    ),
  );
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: settingsProvider.themeMode,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(settingsProvider.languageCode),
      routes: {
        HomeScreen.routeName: (_) => HomeScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen(),
      },
      initialRoute: LoginScreen.routeName,
      //DD
    );
  }
}
/*
* dynamic can be null
* object can't be null
* object can't take methods from children
*
*
* */
/*
* const work on compile time
final run time
*final in const in object
* const object have const variable of object and final in class
*
* const Test test=const test();
*
*
class Test{
* final int age;
* final String name
* const Test(this.age,this.name)  ***{}*** wrong
* constructure can't have body
* }
*
* }*
*
*
*
*
*
*
*
*
*
* * const Point point1= Point(2,8);
* * const Point point2= Point(2,8);
* prit(p1.hashcode);
* prit(p2.hashcode);
* show the same
* will create just one object in memory
*
*
class Point{
* final int x;
* final int y
* const Test(this.x,this.y)

* }
*
*
*
*
* sized box heght is const and give best performence coz if i used 5 sized box with height 10 will create in memory just one
*
* */
