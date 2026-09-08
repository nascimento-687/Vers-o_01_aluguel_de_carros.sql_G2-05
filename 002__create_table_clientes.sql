-- =====================================================================
-- Tabela: clientes
-- Especialização de PESSOAS: dados exclusivos de quem contrata a
-- locação de um veículo. id_cliente é, ao mesmo tempo, chave primária
-- e chave estrangeira para pessoas.id_pessoa (relacionamento 1:1
-- opcional -- nem toda pessoa é cliente).
-- =====================================================================

CREATE TABLE IF NOT EXISTS clientes (
    id_cliente      INTEGER      PRIMARY KEY,
    endereco        VARCHAR(200) NOT NULL,
    dados_bancarios VARCHAR(100) NOT NULL,
    criado_em       TIMESTAMP    NOT NULL DEFAULT NOW(),
    CONSTRAINT fk_clientes_pessoas
        FOREIGN KEY (id_cliente) REFERENCES pessoas (id_pessoa)
        ON DELETE CASCADE
);

COMMENT ON TABLE clientes IS 'Especialização de pessoas: quem contrata a locação de veículos.';
