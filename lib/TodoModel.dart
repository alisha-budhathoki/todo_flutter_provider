import 'package:flutter/cupertino.dart';
import 'package:provider_todo/TaskModel.dart';

class TodoModel extends ChangeNotifier{
  List<TaskModel> taskList = []; //contians all the task

  addTaskInList(String sourceInput){
    //notifying
    // print('snjbjdbdshj'+ sourceInput.toString());
    // TaskModel taskModel = TaskModel(sourceInput.toString()+"title ${taskList.length}", "this is the task no detail ${taskList.length}");
    // taskList.add(taskModel);
    if(sourceInput.toString() == null){
      TaskModel taskModel = TaskModel("title ${taskList.length} ", "this is the task no detail ${taskList.length}");
      taskList.add(taskModel);
    }
    else{
      TaskModel taskModel = TaskModel(sourceInput.toString()+" title ${taskList.length}", "this is the task no detail ${taskList.length}");
      taskList.add(taskModel);
    }

    notifyListeners();
  }

}