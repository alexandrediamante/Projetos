import 'package:flutter/material.dart';
import 'package:todo_acc/todo_list_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const TodoListApp());
}

class TodoListApp extends StatelessWidget {
  const TodoListApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtenha o textTheme do tema padrão do Material
    TextTheme textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de Tarefas - Curso Flutter ACC',
      theme: ThemeData(
        textTheme: GoogleFonts.dmSansTextTheme(textTheme).copyWith(
          bodyMedium: GoogleFonts.aDLaMDisplay(textStyle: textTheme.bodyMedium),
        ),
        primarySwatch: Colors.blue,
      ),
      home: const TodoListScreen(),
    );
  }
}
