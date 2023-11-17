import 'dart:convert';
import 'package:flutter/material.dart';
import 'user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateAccountPage extends StatefulWidget {
  final List<User> users;

  const CreateAccountPage({super.key, required this.users});

  @override
  // ignore: library_private_types_in_public_api
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  ButtonStyle elevatedButtonStyle() {
    return ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(16),
      backgroundColor: Colors.blue,
      elevation: 0,
      minimumSize: const Size(double.infinity, 48),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _loginController,
              decoration: const InputDecoration(labelText: 'Usuário'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _createAccount,
              style: elevatedButtonStyle(),
              child: const Text('Criar'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: elevatedButtonStyle(),
              child: const Text('Cancelar'),
            ),
          ],
        ),
      ),
    );
  }

  void _createAccount() async {
    String login = _loginController.text.trim();
    String password = _passwordController.text.trim();

    if (login.isEmpty || password.isEmpty) {
      _showErrorDialog('Por favor, preencha todos os campos.');
      return;
    }

    bool userExists = widget.users.any((user) => user.login == login);

    if (userExists) {
      _clearFields();
      _showErrorDialog('Usuário já existe!');
    } else {
      widget.users.add(
        User(login: login, password: password),
      );
      await _saveUsersToStorage(
        widget.users,
      );

      await _atualizarTexto('Usuário criado com sucesso!');
      _clearFields();

      Navigator.pop(
        context,
      ); // Voltar para a página de login após criar a conta
    }
  }

  Future<void> _atualizarTexto(String texto) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(texto), //
        duration: const Duration(seconds: 1),
      ),
    );
  }

  Future<List<User>> _getUsersFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? usersJsonList = prefs.getStringList('users');
    if (usersJsonList == null) return [];
    return usersJsonList
        .map((userJson) =>
            User.fromMap(Map<String, dynamic>.from(json.decode(userJson))))
        .toList();
  }

  Future<void> _saveUsersToStorage(List<User> users) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> usersJsonList =
        users.map((user) => json.encode(user.toMap())).toList();
    prefs.setStringList('users', usersJsonList);
  }

  void _clearFields() {
    setState(() {
      _loginController.text = '';
      _passwordController.text = '';
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Erro'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sucesso'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
