-- =====================================================================
-- Tabela: contratos
-- Núcleo do sistema: liga um cliente, o atendente que fechou o
-- negócio e o veículo alugado, com forma de pagamento e vigência.
--
-- Decisões de design:
--  * id_atendente é NOT NULL: todo contrato é fechado por um
--    atendente da empresa (não está no enunciado, mas é a regra de
--    negócio mais realista -- documentado aqui para transparência).
--  * ON DELETE RESTRICT em cliente/atendente/veículo: um contrato é
--    um registro histórico, então não pode "sumir" um cliente ou
--    veículo que já tenha contrato associado.
--  * chk_contratos_periodo garante que a vigência faz sentido
--    (data_fim sempre depois de data_inicio).
-- =====================================================================

CREATE TABLE IF NOT EXISTS contratos (
    id_contrato         SERIAL        PRIMARY KEY,
    numero_contrato     VARCHAR(20)   NOT NULL UNIQUE,
    data_contrato       DATE          NOT NULL DEFAULT CURRENT_DATE,
    forma_pagamento     VARCHAR(10)   NOT NULL,
    id_cliente          INTEGER       NOT NULL,
    id_atendente        INTEGER       NOT NULL,
    id_veiculo          INTEGER       NOT NULL,
    data_inicio         DATE          NOT NULL,
    data_fim            DATE          NOT NULL,
    valor_total         NUMERIC(10,2) NOT NULL,
    criado_em           TIMESTAMP     NOT NULL DEFAULT NOW(),
    CONSTRAINT fk_contratos_clientes
        FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
        ON DELETE RESTRICT,
    CONSTRAINT fk_contratos_atendentes
        FOREIGN KEY (id_atendente) REFERENCES atendentes (id_atendente)
        ON DELETE RESTRICT,
    CONSTRAINT fk_contratos_veiculos
        FOREIGN KEY (id_veiculo) REFERENCES veiculos (id_veiculo)
        ON DELETE RESTRICT,
    CONSTRAINT chk_contratos_forma_pagamento
        CHECK (forma_pagamento IN ('CARTAO', 'PIX')),
    CONSTRAINT chk_contratos_periodo
        CHECK (data_fim > data_inicio),
    CONSTRAINT chk_contratos_valor
        CHECK (valor_total > 0)
);

COMMENT ON TABLE contratos IS 'Contratos de locação, ligando cliente, atendente e veículo.';
