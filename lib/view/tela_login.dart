import 'package:flutter/material.dart';

import '../viewmodel/telalogin_viewmodel.dart';
import 'admin_page.dart';
import 'cliente_page.dart';

class Telalogin extends StatefulWidget {
  const Telalogin({super.key});

  @override
  State<Telalogin> createState() => _TelaloginState();
}

class _TelaloginState extends State<Telalogin> {
  final _formKey = GlobalKey<FormState>();

  final _controllerEmail = TextEditingController();
  final _controllerSenha = TextEditingController();

  bool _hideText = true;

  final viewModel = TelaloginViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "BEM-VINDO!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: Color.fromARGB(255, 214, 106, 106),
          ),
        ),
      ),

      body: Container(
        width: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 249, 240, 237),
              Color.fromARGB(255, 248, 191, 172),
              Color.fromARGB(255, 183, 217, 243),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: Padding(
          padding: const EdgeInsets.all(30),

          child: Form(
            key: _formKey,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,

              children: [

                ClipOval(
                  child: Container(
                    width: 200,
                    height: 140,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.white,
                        width: 3,
                      ),
                    ),

                    child: Image.asset(
                      "assets/logo_e-festa.png",
                      fit: BoxFit.contain,
                      alignment: const Alignment(0, -2),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Container(
                  padding: const EdgeInsets.all(15),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),

                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),

                  child: Column(
                    children: [

                      TextFormField(
                        controller: _controllerEmail,
                        keyboardType: TextInputType.emailAddress,

                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),

                          labelText: "Email",
                          hintText: "Digite seu email",

                          prefixIcon: const Icon(Icons.email),
                        ),

                        validator: viewModel.validarEmail,
                      ),

                      const SizedBox(height: 10),

                      TextFormField(
                        controller: _controllerSenha,
                        obscureText: _hideText,

                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),

                          labelText: "Senha",
                          hintText: "Digite sua senha",

                          prefixIcon: const Icon(Icons.password),

                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _hideText = !_hideText;
                              });
                            },

                            icon: _hideText
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                          ),
                        ),

                        validator: viewModel.validarSenha,
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        height: 50,

                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              242,
                              164,
                              164,
                            ),

                            foregroundColor: Colors.white,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),

                          onPressed: () async {

                            if (_formKey.currentState!.validate()) {

                              final result = await viewModel.loginAPI(
                                _controllerEmail.text,
                                _controllerSenha.text,
                              );

                              if (result != null) {

                                if (result["perfil"] == "admin") {

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const AdminPage(),
                                    ),
                                  );

                                } else {

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const ClientePage(),
                                    ),
                                  );
                                }

                              } else {

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Email ou senha incorretos",
                                    ),
                                  ),
                                );
                              }
                            }
                          },

                          child: const Text("Enviar"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}