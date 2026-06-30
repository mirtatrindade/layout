import 'package:flutter/material.dart';

import '../viewmodel/registro_viewmodel.dart';

class RegistroPage extends StatefulWidget {
  const RegistroPage({super.key});

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final _formKey = GlobalKey<FormState>();

  final _controllerEmail = TextEditingController();
  final _controllerSenha = TextEditingController();
  final _controllerNome = TextEditingController();
  final _controllerCelular = TextEditingController();

  bool _hideText = true;
  bool _aceitouTermos = false;

  final viewModel = RegistroViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,

        title: const Text(
          "CRIAR CONTA",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: Color.fromARGB(255, 214, 106, 106),
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
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
                  children: [
                    ClipOval(
                      child: Container(
                        width: 200,
                        height: 140,

                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.white, width: 3),
                        ),

                        child: Image.asset(
                          "assets/logo_e-festa.png",
                          fit: BoxFit.contain,
                          alignment: const Alignment(0, -2),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Container(
                      padding: const EdgeInsets.all(20),

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
                            controller: _controllerNome,

                            decoration: InputDecoration(
                              labelText: "Nome completo",
                              prefixIcon: const Icon(Icons.person),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),

                            validator: viewModel.validarNome,
                          ),

                          const SizedBox(height: 20),

                          TextFormField(
                            controller: _controllerCelular,
                            keyboardType: TextInputType.phone,

                            decoration: InputDecoration(
                              labelText: "Celular",
                              prefixIcon: const Icon(Icons.phone),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),

                            validator: viewModel.validarCelular,
                          ),

                          const SizedBox(height: 20),

                          TextFormField(
                            controller: _controllerEmail,
                            keyboardType: TextInputType.emailAddress,

                            decoration: InputDecoration(
                              labelText: "Email",
                              hintText: "Digite seu email",

                              prefixIcon: const Icon(Icons.email),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),

                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Digite um email";
                              }

                              if (!value.contains("@")) {
                                return "Email inválido";
                              }

                              return null;
                            },
                          ),

                          const SizedBox(height: 20),

                          TextFormField(
                            controller: _controllerSenha,
                            obscureText: _hideText,

                            decoration: InputDecoration(
                              labelText: "Senha",
                              hintText: "Digite sua senha",

                              prefixIcon: const Icon(Icons.lock),

                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _hideText = !_hideText;
                                  });
                                },

                                icon: Icon(
                                  _hideText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),

                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Digite uma senha";
                              }

                              if (value.length < 4) {
                                return "Mínimo 4 caracteres";
                              }

                              return null;
                            },
                          ),

                          CheckboxListTile(
                            value: _aceitouTermos,

                            onChanged: (value) {
                              setState(() {
                                _aceitouTermos = value ?? false;
                              });
                            },

                            title: const Text("Li e aceito os Termos de Uso"),

                            controlAffinity: ListTileControlAffinity.leading,
                          ),

                          TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,

                                builder: (_) => AlertDialog(
                                  title: const Text("Termos de Uso"),

                                  content: const SingleChildScrollView(
                                    child: Text('''
Ao criar uma conta no sistema E-Festa, o usuário concorda que:

• As reservas devem ser realizadas com antecedência mínima de 3 dias.

• Cada data pode ser reservada por apenas um cliente.

• O orçamento apresentado é apenas estimativo.

• O administrador poderá entrar em contato para confirmar detalhes da reserva.

• Caso o usuário exclua sua conta, os eventos futuros serão cancelados automaticamente.

• Os dados informados serão utilizados exclusivamente para fins de gerenciamento das reservas.

Ao continuar, você declara estar de acordo com estes termos.
'''),
                                  ),

                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },

                                      child: const Text("Fechar"),
                                    ),
                                  ],
                                ),
                              );
                            },

                            child: const Text("Ler Termos de Uso"),
                          ),

                          const SizedBox(height: 30),

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
                                if (!_aceitouTermos) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Para se cadastrar deve aceitar os Termos de Uso",
                                      ),
                                    ),
                                  );

                                  return;
                                }

                                if (_formKey.currentState!.validate()) {
                                  bool ok = await viewModel.registrarUsuario(
                                    _controllerNome.text,
                                    _controllerCelular.text,
                                    _controllerEmail.text,
                                    _controllerSenha.text,
                                  );

                                  if (ok) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Conta criada com sucesso",
                                        ),
                                      ),
                                    );

                                    Navigator.pop(context);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Erro ao criar conta"),
                                      ),
                                    );
                                  }
                                }
                              },

                              child: const Text(
                                "Cadastrar",
                                style: TextStyle(fontSize: 18),
                              ),
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
        ),
      ),
    );
  }
}
