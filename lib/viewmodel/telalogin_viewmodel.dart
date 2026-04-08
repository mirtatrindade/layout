class TelaloginViewModel {

  String? validarEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Informe o email";
    }
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return "Email inválido";
    }
    return null;
  }

  String? validarSenha(String? value) {
    if (value == null || value.isEmpty) {
      return "Informe a senha";
    }
    if (value.length < 4) {
      return "Mínimo 4 caracteres";
    }
    return null;
  }

}