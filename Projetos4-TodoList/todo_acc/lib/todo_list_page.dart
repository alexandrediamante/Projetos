import 'package:flutter/material.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<String> tasks = [];
  final TextEditingController _taskController = TextEditingController();
  final FocusNode _taskFocusNode = FocusNode();

  void _addTask() {
    String newTask = _taskController.text.trim();
    if (newTask.isNotEmpty) {
      setState(() {
        tasks.add(newTask);
        _taskController.clear();
      });
    }
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void _clearAllTasks() {
    setState(() {
      tasks.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    focusNode: _taskFocusNode,
                    onSubmitted: (_) {
                      _addTask();
                      _taskFocusNode.requestFocus();
                    },
                    decoration: InputDecoration(
                      hintText: 'Digite uma tarefa',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _addTask,
                  child: Text('Inserir'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Focus(
              focusNode: _taskFocusNode,
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(tasks[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteTask(index),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Pendentes: ${tasks.length}'),
            ),
            ElevatedButton(
              onPressed: _clearAllTasks,
              child: Text('Limpar Tudo'),
            ),
          ],
        ),
      ),
    );
  }
}
