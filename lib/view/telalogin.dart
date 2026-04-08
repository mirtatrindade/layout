import 'package:flutter/material.dart';
import '../viewmodel/telalogin_viewmodel.dart';

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
        title: Semantics(
          header: true,
          child: Text(
            "BEM-VINDO!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 242, 164, 164),
              shadows: [
                Shadow(
                  blurRadius: 6,
                  color: Colors.black26,
                  offset: Offset(2, 3),
                ),
              ],
            ),
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
            child: Semantics(
              container: true,
              label: "Formulário de login",
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Semantics(
                    label: "Logo do aplicativo e-Festa",
                    image: true,
                    child: ClipOval(
                      child: Container(
                        width: 260,
                        height: 185,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                        child: Image.asset(
                          "assets/logo_e-festa.png",
                          fit: BoxFit.contain,
                          alignment: Alignment(0, -2),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  Semantics(
                    label: "Campo de email",
                    hint: "Digite seu email",
                    textField: true,
                    child: TextFormField(
                      controller: _controllerEmail,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: "Email",
                        hintText: "Digite seu email",
                        prefixIcon: ExcludeSemantics(child: Icon(Icons.email)),
                      ),
                      validator: viewModel.validarEmail,
                    ),
                  ),

                  const SizedBox(height: 10),
                  Semantics(
                    label: "Campo de senha",
                    hint: "Digite sua senha",
                    textField: true,
                    child: TextFormField(
                      controller: _controllerSenha,
                      obscureText: _hideText,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: "Senha",
                        hintText: "Digite sua senha",
                        prefixIcon: ExcludeSemantics(
                          child: Icon(Icons.password),
                        ),
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
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Semantics(
                      label: "Botão para entrar no sistema",
                      button: true,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            print("Login válido");
                            print(_controllerEmail.text);
                            print(_controllerSenha.text);
                          }
                        },
                        child: const Text("Enviar"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
