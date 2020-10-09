import 'package:app_imc/utils/componentes.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget { // cria o método stful
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> { // chama todos os widghtes

  // criação dos controladores, que estão como parâmetro no componentes.dart
  TextEditingController controllerPeso = TextEditingController();
  TextEditingController controllerAltura = TextEditingController();
  GlobalKey<FormState> cForm = GlobalKey<FormState>(); // responsável por executar as validações dentro do formulário
  String info = "Informe os seus dados"; // para atualizar com qualquer mensagem que deseja inserir para o usuário

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // para não mostrar o simbolo de debug no android
      home: criaPaginaPrincipal(), // dar um Altr + Enter para criar a página principal
    );
  }

  criaPaginaPrincipal() { // cria o ambiente da página principal
    return Scaffold(
      appBar: AppBar(
        title: Text("Calcula IMC"),
        centerTitle: true,
        actions: <Widget>[ // cria um botão de refresh no canto superior da tela para limpar os campos
          IconButton( // insere o Icone de refresh
              icon: Icon(Icons.refresh),
              onPressed: resetCampos, // quando clicar ele roda o método resetCampos
          ),
        ],
      ),
      body: criaFormularioIMC(), // cria outro método para adicionar o formulário
    );
  }

  criaFormularioIMC() { // criar o formulário para o usuário inserir os dados
    return Form( // dando um alt + Enter você tem a opção de transformar o método
      // no caso, foi colocado um Form e dentro desse form vem o Container com os dados que devem ser inseridos
      key: cForm, // associa a váriavel
      child: Container(
        child: Column( // o Column alinha como coluna (vertical), mas pode ser usado o Row (para colocar em linha)
          mainAxisAlignment: MainAxisAlignment.start, // para alinhar os botões, o start no caso, é para iniciar no começo da página
          children: [ // children são filhos, significa que pode ter mais de 1
            Componentes.caixaDeTexto("Peso", "Digite o peso", controllerPeso, validaPeso, numero: true), // para inserir o peso
            Componentes.caixaDeTexto("Altura", "Digite a altura", controllerAltura, validaAltura, numero: true), // para inserir a altura
            // passa por parâmetro as functions de validação criadas abaixo
            // o obscure foi inserido só para mostrar como fica
            Componentes.botao("Calcular", calcularIMC), // coloca o calcularIMC sem parenteses
            Text ( // para mostrar no dispositivo o resultado
              info,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.green),
            )
          ], // children
        ),
      ),
    );
  }

  // cria a função para validação de peso
  Function validaPeso = ((value) {
    if(value.isEmpty) { // se for vazio mostra a mensagem abaixo
      return "Informe o Peso";
    }
    if(int.parse(value) <= 0) { // int.parse() para comparar int (números inteiros)
      return "O peso não pode ser negativo!";
    }
    return null;
  });

  // cria a função para validação de altura
  Function validaAltura = ((value) {
    if(value.isEmpty) {
      return "Informe a Altura";
    }
    if(double.parse(value) <= 0) {
      return "A altura não pode ser negativa!";
    }
    return null;
  });

  resetCampos() { // para limpar o texto
    controllerPeso.text = "";
    controllerAltura.text = "";
    setState(() { // para dar um refresh na página
      info = "Informe os seus dados";
    });
  }
  // método para calcular o IMC
  calcularIMC() { // coloca no Componente.botao lá em cima
    setState(() { // para dar um refresh em toda a página

    if(!cForm.currentState.validate()) { // ! significa senão, para validação do método
      return null; // retorna qualquer coisa só para sair do método
    }
    double p = double.parse(controllerPeso.text); // pega o número inserido pelo usuário através do controller
    double a = double.parse(controllerAltura.text);
    double imc = p/(a*a); // calculo do IMC
    if(imc < 18.5)
      info = "Abaixo do peso (${imc.toStringAsPrecision(4)})";// mostra as 4 casas decimais
    else
      if(imc > 18.5 && imc < 30)
        info = "Peso ideal (${imc.toStringAsPrecision(4)})";
      else
        info = "Acima do peso (${imc.toStringAsPrecision(4)})";

      print(info);

    }); // fecha o setState()
  }
}


