-- =====================================================================
-- Popula CONTRATOS ligando cliente + atendente + veículo.
-- Os IDs são resolvidos via JOIN pelas chaves de negócio
-- (e-mail, matrícula, placa) -- nunca por número fixo de SERIAL.
-- CT-0004 é o contrato da Juliana Pereira: ela aparece como cliente
-- neste contrato, mesmo sendo atendente da empresa.
-- =====================================================================

INSERT INTO contratos (
    numero_contrato, data_contrato, forma_pagamento,
    id_cliente, id_atendente, id_veiculo,
    data_inicio, data_fim, valor_total
)
SELECT
    d.numero_contrato,
    d.data_contrato,
    d.forma_pagamento,
    cli.id_cliente,
    at.id_atendente,
    ve.id_veiculo,
    d.data_inicio,
    d.data_fim,
    d.valor_total
FROM (VALUES
    ('CT-0001', DATE '2026-08-01', 'CARTAO', 'marina.souza@email.com',    'AT-1001', 'ABC1D23', DATE '2026-08-01', DATE '2026-08-05', 480.00),
    ('CT-0002', DATE '2026-08-03', 'PIX',    'ricardo.lima@email.com',    'AT-1002', 'GHI7F89', DATE '2026-08-03', DATE '2026-08-06', 180.00),
    ('CT-0003', DATE '2026-08-10', 'PIX',    'fernanda.alves@email.com',  'AT-1003', 'MNO3H45', DATE '2026-08-10', DATE '2026-08-20', 1000.00),
    ('CT-0004', DATE '2026-08-15', 'CARTAO', 'juliana.pereira@email.com', 'AT-1001', 'JKL0G12', DATE '2026-08-15', DATE '2026-08-18', 1050.00)
) AS d(numero_contrato, data_contrato, forma_pagamento, cliente_email, atendente_matricula, veiculo_placa, data_inicio, data_fim, valor_total)
JOIN pessoas    pe  ON pe.email = d.cliente_email
JOIN clientes   cli ON cli.id_cliente = pe.id_pessoa
JOIN atendentes at  ON at.matricula = d.atendente_matricula
JOIN veiculos   ve  ON ve.placa = d.veiculo_placa
ON CONFLICT (numero_contrato) DO NOTHING;
