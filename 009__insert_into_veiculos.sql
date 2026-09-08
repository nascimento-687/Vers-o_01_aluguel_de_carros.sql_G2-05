-- =====================================================================
-- Popula a frota com um exemplo de cada tipo de veículo aceito
-- (moto, carro de passeio e caminhão).
-- =====================================================================

INSERT INTO veiculos (placa, marca, modelo, tipo, valor_diaria, status) VALUES
    ('ABC1D23', 'Fiat',       'Argo',       'CARRO_PASSEIO', 120.00, 'DISPONIVEL'),
    ('DEF4E56', 'Chevrolet',  'Onix',       'CARRO_PASSEIO', 110.00, 'DISPONIVEL'),
    ('GHI7F89', 'Honda',      'CG 160',     'MOTO',           60.00, 'DISPONIVEL'),
    ('JKL0G12', 'Mercedes',   'Accelo 815', 'CAMINHAO',      350.00, 'DISPONIVEL'),
    ('MNO3H45', 'Volkswagen', 'Gol',        'CARRO_PASSEIO', 100.00, 'ALUGADO')
ON CONFLICT (placa) DO NOTHING;
