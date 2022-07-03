// ignore_for_file: file_names, deprecated_member_use

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/Todo.dart';

class TodoController extends GetxController {
  late var todos = <Todo>[].obs;

  @override
  void onInit() {
    List? storedTodos = GetStorage().read<List>('todos');

    if (!storedTodos.isNull) {
      todos = storedTodos!.map((e) => Todo.fromJson(e)).toList().obs;
    }
    ever(todos, (_) {
      GetStorage().write('todos', todos.toList());
    });
    super.onInit();
  }
}
