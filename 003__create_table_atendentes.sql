-- =====================================================================
-- Tabela: atendentes
-- Especialização de PESSOAS: dados exclusivos de quem trabalha na
-- empresa. Uma pessoa que já é cliente pode também virar atendente
-- (e vice-versa) simplesmente ganhando um registro nesta tabela,
-- sem duplicar CPF/nome/e-mail.
-- =====================================================================

CREATE TABLE IF NOT EXISTS atendentes (
    id_atendente    INTEGER     PRIMARY KEY,
    matricula       VARCHAR(20) NOT NULL UNIQUE,
    data_admissao   DATE        NOT NULL DEFAULT CURRENT_DATE,
    CONSTRAINT fk_atendentes_pessoas
        FOREIGN KEY (id_atendente) REFERENCES pessoas (id_pessoa)
        ON DELETE CASCADE
);

COMMENT ON TABLE atendentes IS 'Especialização de pessoas: quem trabalha na empresa atendendo clientes.';
