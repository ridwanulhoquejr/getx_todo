// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo/controllers/TodoController.dart';
import 'package:getx_todo/models/Todo.dart';
import 'package:getx_todo/screens/TodoScreen.dart';

import '../constants/constant.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TodoController controller = Get.put(TodoController());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        backgroundColor: Constant.kPrimaryColor,
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        height: size.height,
        width: double.infinity,
        child: Obx(
          () => ListView.builder(
              itemBuilder: (context, index) => Dismissible(
                    key: UniqueKey(),
                    onDismissed: (_) {
                      // Todo? makes the variable or Todo object nullable
                      Todo? removedItem = controller.todos[index];
                      controller.todos.removeAt(index);
                      Get.snackbar(
                        'New task added',
                        '${removedItem.text} removed succesfully',
                        // backgroundColor: Colors.black,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.TOP,
                        dismissDirection: DismissDirection.horizontal,
                        isDismissible: true,
                        duration: Duration(milliseconds: 1500),
                        mainButton: TextButton(
                          onPressed: () {
                            // ignore: unnecessary_null_comparison
                            if (removedItem == null) {
                              return;
                            }
                            controller.todos.insert(index, removedItem!);
                            removedItem = null;
                            if (Get.isSnackbarOpen) {
                              Get.back();
                            }
                          },
                          child: Text(
                            'Undo',
                            style: TextStyle(color: Colors.orange),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: size.height * 0.12,
                      child: Card(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        elevation: 3,
                        shadowColor: Color.fromARGB(255, 73, 67, 67),
                        child: Align(
                          alignment: Alignment.center,
                          child: ListTile(
                            leading: Card(
                              shadowColor: Color.fromARGB(255, 130, 39, 39),
                              elevation: 1,
                              margin: EdgeInsets.all(5),
                              child: Checkbox(
                                value: controller.todos[index].done,
                                onChanged: (e) {
                                  /*  
                                      1. grab the changed item via index
                                      2. override that done value 
                                      3. append this into nth items 
                                */
                                  var changed = controller.todos[index];
                                  changed.done = e!;
                                  controller.todos[index] = changed;
                                },
                              ),
                            ),
                            title: Text(
                              controller.todos[index].text,
                              style: (controller.todos[index].done)
                                  ? TextStyle(
                                      color: Color.fromARGB(255, 193, 40, 29),
                                      decoration: TextDecoration.lineThrough)
                                  : TextStyle(
                                      color: Colors.black,
                                    ),
                            ),
                            trailing: Icon(Icons.edit),
                            onTap: () {
                              Get.to(
                                TodoScreen(
                                  index: index,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
              itemCount: controller.todos.length),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constant.kPrimaryColor,
        child: Icon(Icons.add),

        /* index -1 means, new Todo otherwise Update */
        onPressed: () {
          Get.to(TodoScreen(
            index: -1,
          ));
        },
      ),
    );
  }
}
