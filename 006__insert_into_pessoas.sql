-- =====================================================================
-- Popula PESSOAS com indivíduos que depois viram cliente, atendente,
-- ou os dois (Juliana Pereira é o exemplo de atendente que também é
-- cliente, validando a regra de negócio do enunciado).
--
-- ON CONFLICT (cpf) DO NOTHING deixa o script seguro para rodar mais
-- de uma vez sem gerar erro de duplicidade.
-- =====================================================================

INSERT INTO pessoas (cpf, nome, sobrenome, email) VALUES
    ('11122233344', 'Marina',   'Souza',    'marina.souza@email.com'),
    ('22233344455', 'Ricardo',  'Lima',     'ricardo.lima@email.com'),
    ('33344455566', 'Fernanda', 'Alves',    'fernanda.alves@email.com'),
    ('44455566677', 'Bruno',    'Carvalho', 'bruno.carvalho@email.com'),
    ('55566677788', 'Juliana',  'Pereira',  'juliana.pereira@email.com'),
    ('66677788899', 'Otavio',   'Ramos',    'otavio.ramos@email.com')
ON CONFLICT (cpf) DO NOTHING;
