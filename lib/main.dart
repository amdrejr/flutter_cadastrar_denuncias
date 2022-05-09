import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    ),
  );
}

// CONSTANTES de CORES
const Color corPri = Colors.amber;
const Color corSec = Color(0xFFFAF1A1);
final Color corBackground = Colors.grey.shade900;

late String usuarioLogado;
String conectou = '';

// TELA DE LOGIN
class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();

  TextEditingController senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: corBackground,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Realize seu Login',
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: corSec),
                  ),

                  const SizedBox(height: 30), // Espaçamento Vertical 30px

                  // CAMPO USUÁRIO
                  TextField(
                    controller: emailController,
                    style: const TextStyle(color: corSec),
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                        label: Text('Digite seu e-mail'),
                        focusColor: Colors.red,
                        labelStyle: TextStyle(color: corPri),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: corPri, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: corSec, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                  ),

                  const SizedBox(height: 25), // Espaçamento Vertical 25px

                  // CAMPO USUÁRIO
                  TextField(
                    controller: senhaController,
                    obscureText: true,
                    style: const TextStyle(color: corSec),
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                        label: Text('Digite sua senha:'),
                        focusColor: Colors.red,
                        labelStyle: TextStyle(color: corPri),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: corPri, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: corSec, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                  ),

                  const SizedBox(height: 25), // Espaçamento Vertical 25px

                  ElevatedButton(
                    // BOTÃO ENTRAR
                    onPressed: () {
                      for (int c = 0; c < Usuario.cadastrados.length; c++) {
                        print('llop');
                        // VERIFICAR SE USUÁRIO ESTÁ CADASTRADO
                        if (Usuario.cadastrados[c].email ==
                            emailController.text) {
                          if (Usuario.cadastrados[c].senha ==
                              senhaController.text) {
                            conectou = '';
                            usuarioLogado = Usuario.cadastrados[c].nome;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Denuncias(),
                              ),
                            );
                          } else {
                            print('ok');
                            setState(() {
                              conectou = 'Senha incorreta';
                            });
                          }
                        } else {
                          print('ok2');

                          setState(() {
                            conectou = 'Conta não cadastrada';
                          });
                        }
                      }
                    },

                    child: const Text(
                      'Entrar',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(corPri),
                    ),
                  ),

                  const SizedBox(height: 20), // Espaçamento Vertical 25px

                  TextButton(
                      // BOTÃO DE TEXTO, CADASTRAR
                      onPressed: () {
                        setState(() {
                          conectou = '';
                          emailController.clear();
                          senhaController.clear();
                        });

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Cadastro(),
                          ),
                        );
                      },
                      child: const Text('Cadastre-se clicando aqui!',
                          style: TextStyle(color: corSec)))
                ],
              ),
            ),
            const SizedBox(height: 25),
            Text(
              ' $conectou',
              style: const TextStyle(color: Colors.red),
            )
          ],
        ),
      ),
    );
  }
}

// TELA DE CADASTRO
class Cadastro extends StatelessWidget {
  Cadastro({Key? key}) : super(key: key);

  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: corPri,
          child: const Icon(Icons.keyboard_return_sharp),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: corBackground,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  const Text(
                    'Cadastre-se',
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: corSec),
                  ),

                  const SizedBox(height: 30), // Espaçamento Vertical 25px

                  TextField(
                    // CAMPO NOME
                    controller: nomeController,
                    style: const TextStyle(color: corSec),
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                        label: Text('Preencha seu nome'),
                        focusColor: Colors.red,
                        labelStyle: TextStyle(color: corPri),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: corPri, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: corSec, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                  ),

                  const SizedBox(height: 25), // Espaçamento Vertical 25px

                  TextField(
                    // CAMPO E-MAIL
                    controller: emailController,
                    style: const TextStyle(color: corSec),
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                        label: Text('Preenche seu e-mail'),
                        focusColor: Colors.red,
                        labelStyle: TextStyle(color: corPri),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: corPri, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: corSec, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                  ),
                  const SizedBox(height: 25), // Espaçamento Vertical 25px

                  TextField(
                    // CAMPO SENHA
                    controller: senhaController,
                    obscureText: true,
                    style: const TextStyle(color: corSec),
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                        label: Text('Crie uma senha'),
                        focusColor: Colors.red,
                        labelStyle: TextStyle(color: corPri),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: corPri, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: corSec, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                  ),
                  const SizedBox(height: 25), // Espaçamento Vertical 25px
                  ElevatedButton(
                    // BOTÃO CADASTRAR
                    onPressed: () {
                      if (emailController.text.isNotEmpty &&
                          nomeController.text.isNotEmpty &&
                          senhaController.text.isNotEmpty) {
                        Usuario newUsuario = Usuario(
                            email: emailController.text,
                            nome: nomeController.text,
                            senha: senhaController.text);
                        Usuario.cadastrados.add(newUsuario);

                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Cadastrado com sucesso'),
                            content: const Text(
                                'Agora você já pode conectar e fazer denúncias!'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, 'OK');
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'OK',
                                  style: TextStyle(color: corPri),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Cadastrar',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(corPri),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// CADASTRAR DENUNCIAS
class Denuncias extends StatefulWidget {
  Denuncias({Key? key}) : super(key: key);

  @override
  State<Denuncias> createState() => _DenunciasState();
}

class _DenunciasState extends State<Denuncias> {
  int radioClick = 1;
  final TextEditingController textController = TextEditingController();

  String radioFunc() {
    if (radioClick == 1) {
      return 'Residencial';
    } else if (radioClick == 2) {
      return 'Ambiental';
    } else if (radioClick == 3) {
      return 'Cível';
    } else {
      return ' ';
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey.shade800,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade900,
          title:
              const Text('DENÚNCIAS CIDADE', style: TextStyle(color: corPri)),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Denunciar',
                icon: Icon(Icons.paste, color: corSec),
              ),
              Tab(
                text: 'Consultar',
                icon: Icon(Icons.find_in_page_outlined, color: corSec),
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          // ABA DENUNCIAR
          SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade800,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Registrar Denúncia',
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: corPri),
                          ),

                          const SizedBox(
                              height: 30), // Espaçamento Vertical 30px

                          // TEXTFIELD REGISTRAR DENUNCIA
                          TextField(
                            controller: textController,
                            maxLength: 130,
                            style: const TextStyle(color: corSec),
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                                label: Text('Digite aqui sua denúncia'),
                                focusColor: Colors.red,
                                labelStyle: TextStyle(color: corPri),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: corPri, width: 2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: corSec, width: 2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)))),
                          ),

                          const SizedBox(
                              height: 25), // Espaçamento Vertical 25px

                          const Text(
                            'Tipo de Denúncia',
                            style: TextStyle(
                                color: corPri,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),

                          const SizedBox(
                              height: 10), // Espaçamento Vertical 10px

                          // RADIO BUTTON 'RESIDENCIAL'
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => corPri),
                                value: 1,
                                groupValue: radioClick,
                                onChanged: (int? change) {
                                  setState(() {
                                    radioClick = change!;
                                  });
                                },
                              ),
                              Text('Residencial',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color:
                                          radioClick == 1 ? corPri : corSec)),
                            ],
                          ),

                          // RADIO BUTTON 'AMBIENTAL'
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => corPri),
                                value: 2,
                                groupValue: radioClick,
                                onChanged: (int? change) {
                                  setState(() {
                                    radioClick = change!;
                                  });
                                },
                              ),
                              Text('Ambiental',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color:
                                          radioClick == 2 ? corPri : corSec)),
                            ],
                          ),

                          // RADIO BUTTON 'CÍVEL'
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => corPri),
                                value: 3,
                                groupValue: radioClick,
                                onChanged: (int? change) {
                                  setState(() {
                                    radioClick = change!;
                                  });
                                },
                              ),
                              Text('Cível',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color:
                                          radioClick == 3 ? corPri : corSec)),
                            ],
                          ),

                          ElevatedButton(
                            // BOTÃO ENTRAR

                            onPressed: () {
                              EnvioDado newDado = EnvioDado(
                                denuncia: textController.text,
                                tipo: radioFunc(),
                                dateTime: DateTime.now(),
                              );
                              dados.add(newDado);
                              setState(() {
                                textController.clear();
                              });
                            },
                            child: const Text(
                              'Registrar',
                              style: TextStyle(fontSize: 18),
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(corPri),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ABA CONSULTAR
          Column(
            children: [
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    SizedBox(height: 5),
                    for (EnvioDado dado in dados) CartaoDenuncia(dado: dado),
                  ],
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}

// DESIGN DO WIDGET CARTÃO DE DENÚNCIAS QUE SERÃO LISTADO

class CartaoDenuncia extends StatelessWidget {
  final EnvioDado dado;
  const CartaoDenuncia({required this.dado});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(15, 2.5, 15, 2.5),
        child: Container(
            height: 130,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: const Color(0xff303030),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('TIPO:',
                            style: TextStyle(
                                fontSize: 16,
                                color: corPri,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 3),
                        Text(dado.tipo.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 16,
                                color: corSec,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Text(
                          DateFormat('dd/MM/yyyy - HH:mm')
                              .format(dado.dateTime),
                          style: const TextStyle(
                              fontSize: 12, color: Colors.white)),
                      const SizedBox(height: 7),
                      Text('Usuário: $usuarioLogado',
                          style: const TextStyle(
                              fontSize: 16,
                              color: corPri,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 7),
                      Text(dado.denuncia,
                          style: const TextStyle(fontSize: 14, color: corSec))
                    ],
                  ),
                ),
              ],
            )));
  }
}

// CLASSES AUXILIARES

List<EnvioDado> dados = [];

class EnvioDado {
  String denuncia;
  String tipo;
  DateTime dateTime;

  EnvioDado({
    required this.denuncia,
    required this.tipo,
    required this.dateTime,
  });
}

class Usuario {
  String nome;
  String email;
  String senha;

  Usuario({
    required this.nome,
    required this.email,
    required this.senha,
  });

  static List<Usuario> cadastrados = [];
}
