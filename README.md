# e-Festa

Aplicativo móvel desenvolvido em Flutter para gerenciamento de salões de festas.

O sistema permite que clientes realizem reservas e personalizem seus eventos e que administradores gerenciem todas as solicitações através de um painel administrativo.

---

## Funcionalidades

### Cliente

- Cadastro de usuário
- Login
- Recuperação de senha
- Reserva de eventos
- Visualização do mapa do salão
- Consulta de disponibilidade de datas
- Cálculo automático de orçamento
- Edição do perfil
- Exclusão de conta (Soft Delete)
- Plano Premium 

### Administrador

- Login administrativo
- Listagem de todos os eventos
- Filtro por status
- Aprovação de reservas
- Cancelamento de reservas
- Visualização dos dados completos dos eventos

---

## Plano Premium

O aplicativo possui uma simulação de monetização através do Plano Premium.

Benefícios:

-  Reserva prioritária (até 12 meses de antecedência)
-  10% de desconto em reservas
-  Cancelamento flexível sem multa

---

##  Tecnologias Utilizadas

- Flutter
- Dart
- PHP
- MySQL (MariaDB)
- XAMPP
- Google Maps
- Table Calendar
- HTTP Requests (API REST)

---

## Banco de Dados

Banco de dados:

```
efesta
```

Principais tabelas:

- usuarios
- eventos

---

## Estrutura do Projeto

```
lib/
│
├── config/
├── model/
├── view/
├── viewmodel/
└── main.dart
```

---

## Segurança

O sistema possui:

- Soft Delete de usuários
- Cancelamento automático de reservas futuras ao excluir uma conta
- Validação de login
- Validação de formulários
- Controle de perfis (Administrador e Cliente)

---

## Monetização

Foi implementada uma interface de Paywall simulando a assinatura Premium.

A compra altera o status Premium do usuário na base de dados.

---

## Acessibilidade

O aplicativo possui melhorias de acessibilidade:

- Labels para leitores de tela
- Campos ampliados
- Botões ampliados
- Melhor contraste de interface

---

## Como executar

1. Clone o projeto

```
git clone https://github.com/SEU-USUARIO/layout.git
```

2. Abra no Visual Studio Code

3. Instale as dependências

```
flutter pub get
```

4. Inicie o XAMPP

- Apache
- MySQL

5. Importe o banco de dados **efesta**

6. Configure o endereço da API em:

```
lib/config/api_config.dart
```

7. Execute

```
flutter run
```

---

## Desenvolvido por

Mirta Fernanda Trindade Rodríguez

Tecnólogo em Análise e Desenvolvimento de Sistemas

UTEC / IFSUL

2026