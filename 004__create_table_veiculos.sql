-- =====================================================================
-- Tabela: veiculos
-- Frota disponível para locação. "tipo" e "status" usam CHECK em vez
-- de uma tabela de domínio à parte -- são poucos valores, fixos e
-- pouco prováveis de mudar, então o CHECK já garante a integridade
-- sem exigir um JOIN extra em toda consulta.
-- =====================================================================

CREATE TABLE IF NOT EXISTS veiculos (
    id_veiculo      SERIAL        PRIMARY KEY,
    placa           VARCHAR(8)    NOT NULL UNIQUE,
    marca           VARCHAR(50)   NOT NULL,
    modelo          VARCHAR(50)   NOT NULL,
    tipo            VARCHAR(20)   NOT NULL,
    valor_diaria    NUMERIC(10,2) NOT NULL,
    status          VARCHAR(20)   NOT NULL DEFAULT 'DISPONIVEL',
    criado_em       TIMESTAMP     NOT NULL DEFAULT NOW(),
    CONSTRAINT chk_veiculos_tipo
        CHECK (tipo IN ('MOTO', 'CAMINHAO', 'CARRO_PASSEIO')),
    CONSTRAINT chk_veiculos_status
        CHECK (status IN ('DISPONIVEL', 'ALUGADO', 'MANUTENCAO')),
    CONSTRAINT chk_veiculos_valor_diaria
        CHECK (valor_diaria > 0)
);

COMMENT ON TABLE veiculos IS 'Frota disponível para locação (motos, carros de passeio e caminhões).';
