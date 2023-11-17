import 'package:flutter/material.dart';
import 'main.dart';

class PhasesDaLua extends StatelessWidget {
  final List<String> dias =
      List.generate(31, (index) => '${index + 1}/12/2023');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Fases da Lua até 31/12'),
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  // Navega para a classe MyApp (main.dart)
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp()),
                  );
                },
              ),
            ],
          ),
        ),
        body: Container(
          color: Colors.lightBlue,
          child: ListView.builder(
            itemCount: dias.length,
            itemBuilder: (context, index) {
              String faseLua = calcularFaseLua(
                  DateTime(2023, 12, index + 1)); // Cálculo da fase da lua
              return GestureDetector(
                onTap: () {
                  _mostrarImagem(context, faseLua);
                },
                child: ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${dias[index]}: ${_capitalizeFirstLetter(faseLua)}',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        alignment: Alignment.centerRight,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Colors.white,
                              width: 3.0,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(
                              'assets/images/$faseLua.jpeg',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  String calcularFaseLua(DateTime data) {
    int y = data.year;
    int m = data.month;
    int d = data.day;

    if (m < 3) {
      y--;
      m += 12;
    }

    int a = y ~/ 100;
    int b = 2 - a + (a ~/ 4);

    double jd = 365.25 * (y + 4716) + 30.6001 * (m + 1) + d + b - 1524.5;
    int fase = ((jd + 4.867) % 29.53059).round();

    if (fase < 0) fase += 29;

    if (fase < 7) {
      return 'lua-nova';
    } else if (fase < 15) {
      return 'lua-crescente';
    } else if (fase < 22) {
      return 'lua-cheia';
    } else {
      return 'lua-minguante';
    }
  }

  void _mostrarImagem(BuildContext context, String faseLua) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Hero(
            tag: faseLua,
            child: CircleAvatar(
              radius: 150,
              backgroundImage: AssetImage(
                'assets/images/$faseLua.jpeg',
              ),
            ),
          ),
        ),
      ),
    ));
  }

  String _capitalizeFirstLetter(String text) {
    return text[0].toUpperCase() + text.substring(1);
  }
}
