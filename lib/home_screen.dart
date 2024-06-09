
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/tabs/settings/settings_tap.dart';
import 'package:todo/tabs/tasks/add_task_bottomsheet.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';
import 'package:todo/tabs/tasks/tasks_tap.dart';
import 'package:todo/theme.dart';

import 'auth/login_screen.dart';
import 'auth/user_provider.dart';
import 'firebase_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> tabs = [TasksTap(), const SettingsTap()];

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<String> appBarTitles = [
      AppLocalizations.of(context)!.todoList,
      AppLocalizations.of(context)!.settings,
    ];
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              FirebaseUtils.logOut();
              Provider.of<UserProvider>(context).currentUser = null;
              Provider.of<TasksProvider>(context).tasks = [];
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            },
            icon: Icon(
              Icons.logout,
              size: 32,
              color: AppTheme.white,
            ),
          )
        ],
        title: Padding(
            padding: const EdgeInsetsDirectional.only(start: 20, top: 20),
            child: Text(appBarTitles[currentIndex])),
      ),
      body: tabs[currentIndex],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        padding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 0,
        surfaceTintColor: Colors.white,
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                label: 'Tasks',
                icon: ImageIcon(AssetImage("images/icon_list.png"))),
            BottomNavigationBarItem(
                label: 'Settings',
                icon: ImageIcon(AssetImage("images/icon_settings.png"))),
          ],
          onTap: (index) => setState(() {
            currentIndex = index;
          }),
          currentIndex: currentIndex,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            context: context,
            builder: (_) => const AddTaskBottomSheet(),
          );
        },
        child: const Icon(
          Icons.add,
          size: 32,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
