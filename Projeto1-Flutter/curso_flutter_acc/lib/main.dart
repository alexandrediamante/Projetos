import 'package:flutter/material.dart';

//AD
void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //Removendo o marcador "Debug" --
      home: Container(
        decoration: const BoxDecoration(),
        child: const MeuCorpo(),
      ),
    );
  }
}

class MeuCorpo extends StatefulWidget {
  const MeuCorpo({Key? key}) : super(key: key);

  @override
  MeuCorpoState createState() => MeuCorpoState();
}

class MeuCorpoState extends State<MeuCorpo> {
  int contador = 0;

  void incrementar() {
    setState(() {
      if (contador < 20) {
        contador++;
      }
      if (contador == 20) {
        _atualizarTexto('Lotado');
      }
    });
  }

  void decrementar() {
    setState(() {
      if (contador > 0) {
        contador--;
      }
      if (contador == 0) {
        _atualizarTexto('Valor não pode ser menor que Zero, Verifique!');
      }
    });
  }

  void _atualizarTexto(String texto) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(texto), //
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contador Entrada'),
        centerTitle: true,
        backgroundColor: Colors.yellow,
        titleTextStyle: const TextStyle(
          fontSize: 23,
          color: Colors.blueAccent,
        ),
      ),
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Flutter01.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    contador >= 20 ? 'Lotado' : 'Pode Entrar',
                    style: TextStyle(
                      fontSize: 45,
                      color: contador >= 20
                          ? Colors.red
                          : Colors.white, // Altera a cor dinamicamente
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '$contador',
                    style: TextStyle(
                      fontSize: 45,
                      color: contador >= 20
                          ? Colors.red
                          : Colors.white, // Altera a cor dinamicamente
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      decrementar();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      fixedSize: const Size(100, 100),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: const Text(
                      'Saiu',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      incrementar();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      fixedSize: const Size(100, 100),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: const Text(
                      'Entrou',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
