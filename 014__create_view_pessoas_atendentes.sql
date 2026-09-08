-- =====================================================================
-- View de apoio (extra): lista todas as pessoas indicando se atuam
-- como cliente, atendente, ou os dois -- deixa visível na prática a
-- especialização Pessoa -> Cliente/Atendente usada na modelagem.
-- =====================================================================

CREATE OR REPLACE VIEW vw_pessoas_papeis AS
SELECT
    p.id_pessoa,
    p.cpf,
    p.nome,
    p.sobrenome,
    p.email,
    (c.id_cliente   IS NOT NULL) AS eh_cliente,
    (a.id_atendente IS NOT NULL) AS eh_atendente
FROM pessoas p
LEFT JOIN clientes   c ON c.id_cliente   = p.id_pessoa
LEFT JOIN atendentes a ON a.id_atendente = p.id_pessoa;
