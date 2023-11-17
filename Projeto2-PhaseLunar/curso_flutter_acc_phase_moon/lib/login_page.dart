import 'dart:convert';
import 'package:flutter/material.dart';
import 'create_account.dart';
import 'phasesdalua.dart';
import 'user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  final List<User> users;

  LoginPage({required this.users});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _loginController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    widget.users.clear();
    widget.users.addAll(await _getUsersFromStorage());
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Projeto Fases da Lua - 2023(ACC-Flutter)'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _loginController,
              decoration: InputDecoration(labelText: 'Usuário'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              style: elevatedButtonStyle(),
              child: Text('Entrar'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _navigateToCreateAccount,
              style: elevatedButtonStyle(),
              child: Text('Criar Conta?'),
            ),
          ],
        ),
      ),
    );
  }

  void _login() {
    String login = _loginController.text.trim();
    String password = _passwordController.text.trim();

    if (login.isEmpty || password.isEmpty) {
      _showErrorDialog('Por favor, preencha todos os campos.');
      return;
    }

    bool isUserValid = widget.users
        .any((user) => user.login == login && user.password == password);

    if (isUserValid) {
      _clear();
      _navigateToHome();
    } else {
      _clear();
      _showErrorDialog('Login ou senha incorretos.');
    }
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => PhasesDaLua()),
    );
  }

  void _navigateToCreateAccount() {
    _clear();
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CreateAccountPage(users: widget.users)),
    );
  }

  void _clear() {
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
          title: Text('Erro'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  ButtonStyle elevatedButtonStyle() {
    return ElevatedButton.styleFrom(
      padding: EdgeInsets.all(16),
      primary: Colors.blue,
      elevation: 0,
      minimumSize: Size(double.infinity, 48),
    );
  }
}
