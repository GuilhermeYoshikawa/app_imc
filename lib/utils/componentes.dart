import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// primeiro foi criado a classe Componentes para adicionar os componentes (nesse caso, o botão)
class Componentes { // classe criada para adicionar todos os componentes

  // criação do componente Caixa de texto
  static caixaDeTexto(String rotulo, String dica, TextEditingController controlador, validacao, {bool obscure=false, bool numero=false}) {
    return TextFormField(
      controller: controlador,
      obscureText: obscure, // usado no caso de senhas para esconder o texto
      validator: validacao,
      keyboardType: numero?TextInputType.number:TextInputType.text, // qual o tipo de caracteres que será aceito
      // se numero for igual ao number é número senão é igual a text
      decoration: InputDecoration(
        labelText: rotulo, // rotulo que irá aparecer
        labelStyle: TextStyle(fontSize: 18),
        hintText: dica, // dica que irá aparecer
        hintStyle: TextStyle(fontSize: 10, color: Colors.red),
      ),
    );
  }

  // criação do componente Botão
  static botao(String _texto, Function _f){
    return Container( // criar um container para o botão
      child: RaisedButton(
        onPressed: _f, // para ser chamada por parâmetro
        child: Text( // para estilizar o texto
            _texto,
          style: TextStyle(color: Colors.white, fontSize: 18), // estilizar o texto dentro do botão
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // deixar a borda do botão circular
          side: const BorderSide(color: Colors.black, width: 4) // tamanho e cor da borda
        ),
        color: Colors.black87.withOpacity(0.4), // estilizar o botão
        hoverColor: Colors.yellow.withOpacity(0.3), // cor quando o mouse passar por cima
      ),
    );
  }
}