import 'package:flutter/material.dart';

void main() {
  runApp(const Calculatrice());
}

class Calculatrice extends StatelessWidget {
  const Calculatrice({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculatrice',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const CalculatricePage(title: 'Calculatrice'),
    );
  }
}

class CalculatricePage extends StatefulWidget {
  const CalculatricePage({super.key, required this.title});
  final String title;

  @override
  State<CalculatricePage> createState() => _CalculatricePageState();
}

class _CalculatricePageState extends State<CalculatricePage> with SingleTickerProviderStateMixin {
  String _saisieActuelle = '0';
  String _calculComplet = '';
  String _dernierBoutonAppuye = '';
  Color _couleurAffichage = Colors.black;
  double _tailleTexte = 48;

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _traiterBouton(String bouton) {
    _dernierBoutonAppuye = bouton;
    _animationController.reset();
    _animationController.forward();

    setState(() {
      // Effacer tout
      if (bouton == 'C') {
        _saisieActuelle = '0';
        _calculComplet = '';
        _couleurAffichage = Colors.black;
        _tailleTexte = 48;
        return;
      }

      // Calculer le résultat
      if (bouton == '=') {
        _calculComplet += ' $_saisieActuelle =';
        _saisieActuelle = _calculer(_calculComplet);
        _couleurAffichage = Colors.green;
        _tailleTexte = 60;
        return;
      }

      // Traiter les opérateurs
      if (['+', '-', '×', '÷'].contains(bouton)) {
        _calculComplet = '$_saisieActuelle $bouton';
        _saisieActuelle = '0';
        _couleurAffichage = Colors.deepPurple;
        _tailleTexte = 48;
        return;
      }

      // Traiter les chiffres et le point
      if (bouton == '.') {
        if (!_saisieActuelle.contains('.')) {
          _saisieActuelle += '.';
        }
      } else {
        // Chiffres
        if (_saisieActuelle == '0') {
          _saisieActuelle = bouton;
        } else {
          _saisieActuelle += bouton;
        }
        _couleurAffichage = Colors.black;
        _tailleTexte = 48;
      }
    });
  }

  String _calculer(String expression) {
    // Traiter la chaîne pour extraire les nombres et l'opération
    expression = expression.replaceAll(' =', '');
    List<String> parts = expression.split(' ');

    if (parts.length != 3) {
      return 'Erreur';
    }

    double nombre1 = double.tryParse(parts[0]) ?? 0;
    String operation = parts[1];
    double nombre2 = double.tryParse(parts[2]) ?? 0;
    double resultat = 0;

    // Effectuer l'opération
    switch (operation) {
      case '+': resultat = nombre1 + nombre2; break;
      case '-': resultat = nombre1 - nombre2; break;
      case '×': resultat = nombre1 * nombre2; break;
      case '÷':
        if (nombre2 == 0) {
          return 'Erreur';
        }
        resultat = nombre1 / nombre2;
        break;
      default: return 'Erreur';
    }

    // Formater le résultat
    String resultatTexte = resultat.toString();
    if (resultatTexte.endsWith('.0')) {
      resultatTexte = resultatTexte.substring(0, resultatTexte.length - 2);
    }

    return resultatTexte;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          // Affichage du calcul
          Expanded(
            flex: 1,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: double.infinity,
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: _dernierBoutonAppuye == '='
                    ? Colors.grey.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                _calculComplet,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.grey,
                ),
              ),
            ),
          ),

          // Affichage de la saisie actuelle
          Expanded(
            flex: 2,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: double.infinity,
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: _dernierBoutonAppuye == '='
                    ? Colors.green.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: TextStyle(
                  fontSize: _tailleTexte,
                  fontWeight: FontWeight.bold,
                  color: _couleurAffichage,
                ),
                child: Text(_saisieActuelle),
              ),
            ),
          ),

          // Boutons de la calculatrice
          Expanded(
            flex: 5,
            child: GridView.count(
              crossAxisCount: 4,
              childAspectRatio: 1.0,
              padding: const EdgeInsets.all(8),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                _construireBouton('7'),
                _construireBouton('8'),
                _construireBouton('9'),
                _construireBouton('÷'),
                _construireBouton('4'),
                _construireBouton('5'),
                _construireBouton('6'),
                _construireBouton('×'),
                _construireBouton('1'),
                _construireBouton('2'),
                _construireBouton('3'),
                _construireBouton('-'),
                _construireBouton('0'),
                _construireBouton('.'),
                _construireBouton('='),
                _construireBouton('+'),
                _construireBouton('C'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _construireBouton(String texte) {
    Color couleurBouton;

    if (['+', '-', '×', '÷', '='].contains(texte)) {
      couleurBouton = Colors.deepPurpleAccent;
    } else if (texte == 'C') {
      couleurBouton = Colors.redAccent;
    } else {
      couleurBouton = Colors.deepPurple;
    }

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          transform: Matrix4.identity()
            ..scale(_dernierBoutonAppuye == texte
                ? 1.0 - _animation.value * 0.1
                : 1.0),
          child: ElevatedButton(
            onPressed: () => _traiterBouton(texte),
            style: ElevatedButton.styleFrom(
              backgroundColor: couleurBouton,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(texte == _dernierBoutonAppuye ? 20 : 10),
              ),
              elevation: texte == _dernierBoutonAppuye ? 8 : 4,
            ),
            child: Text(
              texte,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}