import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Formulaire',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FormulairePage(),
    );
  }
}

class FormulairePage extends StatefulWidget {
  const FormulairePage({Key? key});

  @override
  State<FormulairePage> createState() => _FormulairePageState();
}

class _FormulairePageState extends State<FormulairePage> {
  //https://docs.flutter.dev/cookbook/forms/text-field-changes
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _tailleController = TextEditingController();
  final TextEditingController _poidsController = TextEditingController();
  String _sexe = 'M';
  List<String> _tecno = [];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final String nom = _nomController.text;
      final String prenom = _prenomController.text;
      final int age = int.parse(_ageController.text);
      final double taille = double.parse(_tailleController.text);
      final double poids = double.parse(_poidsController.text);
      //IMC = Poids / (Taille * Taille)
      final double bmi = poids / (taille * taille);

      //test sur console
      print('Nom: $nom');
      print('Prénom: $prenom');
      print('Âge: $age');
      print('Sexe: $_sexe');
      print('Taille: $taille');
      print('Tecno: $_tecno');
      print('BMI: $bmi');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulaire'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nomController,
                decoration: const InputDecoration(labelText: 'Nom'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un nom';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _prenomController,
                decoration: const InputDecoration(labelText: 'Prénom'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un prénom';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Âge'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un âge';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Âge invalide';
                  }
                  return null;
                },
              ),
              Row(
                children: <Widget>[
                  const Text('Sexe: '),
                  Radio<String>(
                    value: 'M',
                    groupValue: _sexe,
                    onChanged: (value) {
                      setState(() {
                        _sexe = value!;
                      });
                    },
                  ),
                  const Text('M'),
                  Radio<String>(
                    value: 'F',
                    groupValue: _sexe,
                    onChanged: (value) {
                      setState(() {
                        _sexe = value!;
                      });
                    },
                  ),
                  const Text('F'),
                ],
              ),
              TextFormField(
                controller: _tailleController,
                decoration:
                    const InputDecoration(labelText: 'Taille (en mètres)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une taille';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Taille invalide';
                  }
                  return null;
                },
              ),
              Row(
                children: <Widget>[
                  const Text('Tecno: '),
                  Checkbox(
                    value: _tecno.contains('JavaScript'),
                    onChanged: (value) {
                      setState(() {
                        if (value != null && value) {
                          _tecno.add('JavaScript');
                        } else {
                          _tecno.remove('JavaScript');
                        }
                      });
                    },
                  ),
                  const Text('JavaScript'),
                  Checkbox(
                    value: _tecno.contains('Flutter'),
                    onChanged: (value) {
                      setState(() {
                        if (value != null && value) {
                          _tecno.add('Flutter');
                        } else {
                          _tecno.remove('Flutter');
                        }
                      });
                    },
                  ),
                  const Text('Flutter'),
                  Checkbox(
                    value: _tecno.contains('C'),
                    onChanged: (value) {
                      setState(() {
                        if (value != null && value) {
                          _tecno.add('C');
                        } else {
                          _tecno.remove('C');
                        }
                      });
                    },
                  ),
                  const Text('C'),
                ],
              ),
              TextFormField(
                controller: _poidsController,
                decoration:
                    const InputDecoration(labelText: 'Poids arrondi (en kg)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre Poids';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Poids invalide';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
