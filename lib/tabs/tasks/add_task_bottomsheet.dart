
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';

import '../../auth/user_provider.dart';
import '../../firebase_utils.dart';
import '../../models/task_model.dart';
import '../../theme.dart';
import 'default_elevated_button.dart';
import 'default_text_form_field.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var selctedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/ MM /yyyy');
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      padding: EdgeInsets.all(16),
      width: double.infinity,
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Text(
                "Add New Task",
                style: textTheme.bodyMedium?.copyWith(color: Colors.black),
              ),
              DefaultTextFormField(
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return 'title cannott be empty';
                    }
                    return null;
                  },
                  controller: titleController,
                  hintText: 'Enter Task Title'),
              SizedBox(
                height: 16,
              ),
              DefaultTextFormField(
                  controller: descriptionController,
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return 'Description cannott be empty';
                    }
                    return null;
                  },
                  hintText: 'Enter Task Description',
                  maxLines: 5),
              SizedBox(
                height: 16,
              ),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  "Selected Date",
                  style: textTheme.bodyLarge,
                ),
              ),
              InkWell(
                child: Text(
                    // DateTime.now().toString().substring(0, 11),
                    dateFormat.format(selctedDate),
                    style: textTheme.bodySmall),
                onTap: () async {
                  final dateTime = await showDatePicker(
                      context: context,
                      initialDate: selctedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(
                        const Duration(days: 365),
                      ),
                      initialEntryMode: DatePickerEntryMode.calendarOnly);
                  if (dateTime != null) {
                    selctedDate = dateTime;
                    setState(() {});
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              DefaultElevatedButton(
                child: Text(
                  "ADD",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: AppTheme.white),
                ),
                onPress: addTask,
              )
            ],
          ),
        ),
      ),
    );
  }

  void addTask() {
    final userId =
        Provider.of<UserProvider>(context, listen: false).currentUser!.id;
    if (formKey.currentState?.validate() == true) {
      FirebaseUtils.addTaskToFirestore(
        TaskModel(
          title: titleController.text,
          description: descriptionController.text,
          dateTime: selctedDate,
        ),
        userId,
      ).then(
        (_) {
          Provider.of<TasksProvider>(context, listen: false).getTasks(userId);
          Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
          );
          Navigator.of(context).pop();
        },
      )
          //   .timeout(
          // Duration(milliseconds: 500),
          // onTimeout: () {
          //   Provider.of<TasksProvider>(context, listen: false)
          //       .getTasks(Provider.of<UserProvider>(context).currentUser!.id);
          //   Fluttertoast.showToast(
          //     msg: "Success",
          //     toastLength: Toast.LENGTH_SHORT,
          //   );
          //   Navigator.of(context).pop();
          //   // print("success");
          // },)
          .catchError((_) {
        Fluttertoast.showToast(
          msg: "Failed",
          toastLength: Toast.LENGTH_SHORT,
        );
        Navigator.of(context).pop();

        print('Error');
      });
    }
  }
}
