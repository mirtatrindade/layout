# layout
# Estrutura do Banco de Dados – e-Festa

## SQL

CREATE TABLE usuarios (
  id INTEGER PRIMARY KEY,
  email TEXT NOT NULL,
  senha TEXT NOT NULL
);

CREATE TABLE eventos (
  id INTEGER PRIMARY KEY,
  nome TEXT,
  data DATE,
  quantidade_pessoas INTEGER,
  usuario_id INTEGER,
  FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

CREATE TABLE servicos (
  id INTEGER PRIMARY KEY,
  nome TEXT,
  preco REAL
);
