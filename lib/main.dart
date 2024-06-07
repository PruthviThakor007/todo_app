import 'package:flutter/material.dart';
import 'package:todo_app/util/task_dialog.dart';
import 'package:todo_app/util/task_tile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.deepPurple[100],
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = TextEditingController();
  List todoList = [
    ["Use ToDo App", true],
    ["Explore this App", false],
  ];

  int _selectedFilterIndex = 0; // 0: All, 1: Incomplete, 2: Completed

  void checkBoxChange(bool? value, int index) {
    setState(() {
      todoList[index][1] = value!;
    });
  }

  void addTodo() {
    setState(() {
      todoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('New todo added successfully'),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  void deleteTodo(int index) {
    setState(() {
      String deletedTodo = todoList[index][0];
      todoList.removeAt(index);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$deletedTodo deleted successfully'),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      );
    });
  }

  void toggleShowAllTodos() {
    setState(() {
      _selectedFilterIndex = 0;
    });
    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Showing All Todos'),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.blue,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  void toggleShowIncompleteTodos() {
    setState(() {
      _selectedFilterIndex = 1;
    });
    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Showing Incomplete Todos'),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.blue,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  void toggleShowCompletedTodos() {
    setState(() {
      _selectedFilterIndex = 2;
    });
    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Showing Completed Todos'),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.blue,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  List getFilteredTodoList() {
    if (_selectedFilterIndex == 1) {
      return todoList.where((todo) => !todo[1]).toList();
    } else if (_selectedFilterIndex == 2) {
      return todoList.where((todo) => todo[1]).toList();
    }
    return todoList;
  }

  Widget buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepPurple[300],
            ),
            child: Text(
              'Filters',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Show All Todos'),
            onTap: toggleShowAllTodos,
            trailing: Icon(
              _selectedFilterIndex == 0
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              color: _selectedFilterIndex == 0 ? Colors.deepPurple[200] : null,
            ),
          ),
          ListTile(
            title: Text('Show Incomplete Todos'),
            onTap: toggleShowIncompleteTodos,
            trailing: Icon(
              _selectedFilterIndex == 1
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              color: _selectedFilterIndex == 1 ? Colors.deepPurple[200] : null,
            ),
          ),
          ListTile(
            title: Text('Show Completed Todos'),
            onTap: toggleShowCompletedTodos,
            trailing: Icon(
              _selectedFilterIndex == 2
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              color: _selectedFilterIndex == 2 ? Colors.deepPurple[200] : null,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List filteredTodoList = getFilteredTodoList();

    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo App'),
        elevation: 0,
        backgroundColor: Colors.deepPurple[300],
      ),
      drawer: buildDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return TodoDialog(
                controller: _controller,
                addTodo: addTodo,
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      body: filteredTodoList.isEmpty
          ? Center(
              child: Text(
                _selectedFilterIndex == 1
                    ? 'All todos completed'
                    : 'No completed todos',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.deepPurple[300],
                ),
              ),
            )
          : ListView.builder(
              itemCount: filteredTodoList.length,
              itemBuilder: (context, index) {
                return TodoTile(
                  todo: filteredTodoList[index],
                  onChanged: (value) {
                    int actualIndex = todoList.indexOf(filteredTodoList[index]);
                    checkBoxChange(value, actualIndex);
                  },
                  onDelete: () {
                    int actualIndex = todoList.indexOf(filteredTodoList[index]);
                    deleteTodo(actualIndex);
                  },
                );
              },
            ),
    );
  }
}
