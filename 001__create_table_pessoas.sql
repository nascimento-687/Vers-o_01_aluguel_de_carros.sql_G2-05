-- =====================================================================
-- Tabela: pessoas
-- Superclasse com os dados comuns entre clientes e atendentes.
-- Motivo do design: o enunciado exige que um atendente também possa
-- ser cliente. Em vez de duplicar CPF/nome/e-mail em duas tabelas
-- independentes, usamos especialização (Pessoa -> Cliente / Atendente):
-- cada pessoa pode ter um registro em CLIENTES, em ATENDENTES, em
-- ambos, ou em nenhum ainda.
-- =====================================================================

CREATE TABLE IF NOT EXISTS pessoas (
    id_pessoa   SERIAL PRIMARY KEY,
    cpf         VARCHAR(11)  NOT NULL UNIQUE,
    nome        VARCHAR(100) NOT NULL,
    sobrenome   VARCHAR(100) NOT NULL,
    email       VARCHAR(150) NOT NULL UNIQUE,
    criado_em   TIMESTAMP    NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE pessoas IS 'Superclasse com os dados comuns entre clientes e atendentes.';
