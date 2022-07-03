// ignore_for_file: prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_const_constructors, unrelated_type_equality_checks, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo/constants/constant.dart';
import 'package:getx_todo/controllers/TodoController.dart';
import 'package:getx_todo/models/Todo.dart';

class TodoScreen extends StatelessWidget {
  /* dependency Inject */
  final TodoController controller = Get.find();
  late int index;
  TodoScreen({Key? key, required this.index}) : super(key: key);

  void update(int index) {}

  @override
  Widget build(BuildContext context) {
    String text = '';
    // ignore: unnecessary_null_comparison
    if (index != -1) {
      text = controller.todos[index].text;
    }
    final TextEditingController textController =
        TextEditingController(text: text);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add todo'),
        backgroundColor: Constant.kPrimaryColor,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_constructors
            children: [
              const Text(
                'Hello from Getx',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey),
              ),
              // const RoundedInputField(hintText: 'Enter your todo')
              SizedBox(
                height: size.height * 0.03,
              ),

              /* TextField Input */
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                height: 70,
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  autofocus: true,
                  controller: textController,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter Your Todo Here',
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),

              /* Button */
              Container(
                margin: const EdgeInsets.all(8),
                width: size.width * 0.5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: MaterialButton(
                    height: 50,
                    color: Constant.kPrimaryColor,
                    textColor: Colors.white,
                    splashColor: Constant.kPrimaryLightColor,
                    child: Text((index != -1) ? 'Update' : 'Add'),
                    onPressed: () {
                      /* for newly added todos */
                      if (textController.text.isNotEmpty && index == -1) {
                        controller.todos.add(
                          Todo(text: textController.text),
                        );
                        Get.back();
                        Get.snackbar(
                          'New task added',
                          '${textController.text} added succesfully',
                          backgroundColor: Color.fromARGB(255, 140, 100, 100),
                          colorText: Colors.white,
                          snackPosition: SnackPosition.TOP,
                          dismissDirection: DismissDirection.horizontal,
                          isDismissible: true,
                          duration: Duration(milliseconds: 1500),
                        );
                      }
                      /* for updating  todos */
                      else if (textController.text.isNotEmpty && index != -1) {
                        /*  1. grab the editetd item 
                            2. override that text value 
                            3. append this into nth items 
                        */
                        var editedTodoItem = controller.todos[index];
                        editedTodoItem.text = textController.text;
                        controller.todos[index] = editedTodoItem;
                        Get.back();
                      } else {
                        Get.snackbar(
                          'Please, write a Task',
                          'You wrote nothing',
                          // backgroundColor: Colors.black,
                          colorText: Colors.orange,
                          isDismissible: true,
                          duration: Duration(milliseconds: 1500),
                        );
                        return;
                      }
                      // Get.back();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
