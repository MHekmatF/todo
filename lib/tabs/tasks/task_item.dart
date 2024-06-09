
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';

import '../../auth/user_provider.dart';
import '../../firebase_utils.dart';
import '../../models/task_model.dart';
import '../../theme.dart';

class TaskItem extends StatefulWidget {
  final TaskModel taskModel;

  const TaskItem({Key? key, required this.taskModel}) : super(key: key);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Slidable(
        key: UniqueKey(),
        startActionPane: ActionPane(
          // A motion is a widget used to control how the pane animates.
          motion: const ScrollMotion(),

          // A pane can dismiss the Slidable.
          // dismissible: DismissiblePane(onDismissed: () {}),

          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              onPressed: deleteTask,
              backgroundColor: AppTheme.red,
              foregroundColor: AppTheme.white,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
              color: AppTheme.white, borderRadius: BorderRadius.circular(15)),
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 50,
                color: Theme.of(context).primaryColor,
                margin: const EdgeInsetsDirectional.only(end: 8),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.taskModel.title,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    widget.taskModel.description,
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
              const Spacer(),
              Container(
                height: 34,
                width: 69,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset("images/icon_check.png"),
              )
            ],
          ),
        ),
      ),
    );
  }

  void deleteTask(BuildContext ctx) {
    final userId =
        Provider.of<UserProvider>(context, listen: false).currentUser!.id;
    FirebaseUtils.deleteTaskFromFirestore(widget.taskModel.id, userId)
        .then((_) {
      Provider.of<TasksProvider>(context, listen: false).getTasks(userId);
      Fluttertoast.showToast(
        msg: "Delete Success",
        toastLength: Toast.LENGTH_SHORT,
      );
    })
        //   .timeout(
        // const Duration(milliseconds: 500),
        // onTimeout: () {
        //   Provider.of<TasksProvider>(context, listen: false).getTasks(userId);
        //   Fluttertoast.showToast(
        //     msg: "Delete Success",
        //     toastLength: Toast.LENGTH_SHORT,
        //   );
        // },)
        .catchError((_) {
      Fluttertoast.showToast(
        msg: "Failed",
        toastLength: Toast.LENGTH_SHORT,
      );
    });
  }
}
