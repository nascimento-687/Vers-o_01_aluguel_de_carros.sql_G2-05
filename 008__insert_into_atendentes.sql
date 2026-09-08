-- =====================================================================
-- Popula ATENDENTES a partir de pessoas já cadastradas.
-- Repare que 'juliana.pereira@email.com' aparece tanto aqui quanto em
-- clientes: é a prova de que a modelagem permite atendente = cliente.
-- =====================================================================

INSERT INTO atendentes (id_atendente, matricula, data_admissao)
SELECT p.id_pessoa, d.matricula, d.data_admissao
FROM pessoas p
JOIN (VALUES
    ('bruno.carvalho@email.com',  'AT-1001', DATE '2023-03-01'),
    ('juliana.pereira@email.com', 'AT-1002', DATE '2022-11-15'),
    ('otavio.ramos@email.com',    'AT-1003', DATE '2024-01-10')
) AS d(email, matricula, data_admissao) ON d.email = p.email
ON CONFLICT (id_atendente) DO NOTHING;

