import 'package:flutter/material.dart';

// Caio Henrique   RA: 2920481911022
// Luiz Augusto    RA: 2920481911013
// Thales Shinji   RA: 2920481911017
// Tiago Oliveira  RA: 2920481911032
// Yuri Cavalcanti RA: 2920481911023

void main() {
  runApp(
    MaterialApp(
      home: Home()
    )
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _info = "Informe seus dados";
  var _color = Colors.grey;
  String _pesoIdeal = "";


  void _limpaCampos(){
    pesoController.text = "";
    alturaController.text = "";
    setState((){
      _info = "Informe seus dados";
      _color = Colors.grey;
      _pesoIdeal = "";
    });
  }

  void _calcularImc(){
    double peso = double.parse(pesoController.text);
    double altura = double.parse(alturaController.text) / 100;

    double imc = peso / (altura * altura);
    
    setState(() {
      if(imc < 18.6){
        _info = "Abaixo do peso ${imc.toStringAsPrecision(4)}";
        _color = Colors.yellow;
      }else if(imc < 24.9){
        _pesoIdeal = "";
        _info = "Peso ideal ${imc.toStringAsPrecision(4)}";
        _color = Colors.green;
      }else if(imc < 29.9){
        _info = "Levemente acima do peso ${imc.toStringAsPrecision(4)}";
        _color = Colors.yellow;
      }else if(imc < 34.9){
        _info = "Obesidade grau I ${imc.toStringAsPrecision(4)}";
        _color = Colors.orange;
      }else if(imc < 39.9){
        _info = "Obesidade grau II ${imc.toStringAsPrecision(4)}";
        _color = Colors.red;
      }else {
        _info = "Obesidade grau III ${imc.toStringAsPrecision(4)}";
        _color = Colors.purple;
      }
      if(imc < 18.6 || imc >= 24.9){
        var pesoMinimo = 18.6 * altura * altura;
        var pesoMaximo = 24.9 * altura * altura;
        _pesoIdeal = "Seu peso ideal é entre ${pesoMinimo.toStringAsPrecision(2)}kg e ${pesoMaximo.toStringAsPrecision(2)}kg";
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Calculadora IMC",
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[500],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _limpaCampos
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form( 
          key: _formKey,
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.person_outline,
                size: 120,
                color: Colors.blue[300],
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso (Kg)",
                  labelStyle: TextStyle(
                    color: Colors.green,
                  ),
                ),
                textAlign: TextAlign.center,
                style:  TextStyle(
                  color: Colors.green,
                  fontSize: 25.0,
                ),
                controller: pesoController,
                validator: (value){
                  return (value.isEmpty) ? "Insira seu peso" : null;
                }
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura (cm)",
                  labelStyle: TextStyle(
                    color: Colors.green,
                  )
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25.0,
                ),
                controller: alturaController,
                validator: (value){
                  if(value.isEmpty){
                    return "Insira sua altura";
                  } else {
                    return null;
                  }
                }
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                child: Container(
                  height: 50,
                  child: RaisedButton(
                    onPressed: (){
                      if(_formKey.currentState.validate()){
                        _calcularImc();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                    color: Colors.blue[900],
                  ),
                ),
              ),
              Text(
                _info,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _color,
                  fontSize: 25,
                ),
              ),
              Text(
                _pesoIdeal,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
