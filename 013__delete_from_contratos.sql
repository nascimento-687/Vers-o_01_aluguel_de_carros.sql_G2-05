
-- =====================================================================
-- 1) Exclusão simples: um contrato de teste (CT-9999), cadastrado por
--    engano, é inserido e em seguida removido.
-- =====================================================================

INSERT INTO contratos (
    numero_contrato, data_contrato, forma_pagamento,
    id_cliente, id_atendente, id_veiculo,
    data_inicio, data_fim, valor_total
)
SELECT
    'CT-9999', CURRENT_DATE, 'PIX',
    cli.id_cliente, at.id_atendente, ve.id_veiculo,
    CURRENT_DATE, CURRENT_DATE + 1, 50.00
FROM pessoas pe
JOIN clientes cli ON cli.id_cliente = pe.id_pessoa
JOIN atendentes at ON at.matricula = 'AT-1001'
JOIN veiculos ve ON ve.placa = 'GHI7F89'
WHERE pe.email = 'ricardo.lima@email.com'
ON CONFLICT (numero_contrato) DO NOTHING;

DELETE FROM contratos
WHERE numero_contrato = 'CT-9999';

-- =====================================================================
-- 2) Validação da integridade referencial: a FK de contratos para
--    clientes usa ON DELETE RESTRICT, então excluir um cliente que
--    ainda possui contrato vinculado DEVE falhar.
--
--    O bloco DO $$ ... $$ captura o erro esperado e registra um aviso,
--    permitindo que o restante do script continue normalmente.
-- =====================================================================

DO $$
BEGIN
    DELETE FROM clientes
    WHERE id_cliente = (
        SELECT id_pessoa
        FROM pessoas
        WHERE email = 'marina.souza@email.com'
    );

    RAISE NOTICE 'Atenção: exclusão foi permitida (não deveria acontecer com contrato vinculado).';

EXCEPTION WHEN foreign_key_violation THEN
    RAISE NOTICE 'OK: exclusão bloqueada como esperado -- cliente possui contrato(s) vinculado(s).';
END $$;

