-- =====================================================================
-- Popula CLIENTES a partir de pessoas já cadastradas.
-- O JOIN é feito pelo e-mail (chave de negócio) em vez de "adivinhar"
-- o id_pessoa gerado pelo SERIAL -- assim o script continua correto
-- mesmo se a ordem/IDs de pessoas mudar entre execuções.
-- =====================================================================

INSERT INTO clientes (id_cliente, endereco, dados_bancarios)
SELECT p.id_pessoa, d.endereco, d.dados_bancarios
FROM pessoas p
JOIN (VALUES
    ('marina.souza@email.com',    'Rua das Flores, 123 - Porto Velho/RO',      'Banco 001 - Ag 1234 - CC 56789-0'),
    ('ricardo.lima@email.com',    'Av. Sete de Setembro, 500 - Porto Velho/RO', 'Banco 237 - Ag 4321 - CC 98765-4'),
    ('fernanda.alves@email.com',  'Rua Rio Madeira, 45 - Porto Velho/RO',       'Banco 104 - Ag 1111 - CC 22222-1'),
    ('juliana.pereira@email.com', 'Rua Tancredo Neves, 900 - Porto Velho/RO',   'Banco 341 - Ag 5555 - CC 33333-2')
) AS d(email, endereco, dados_bancarios) ON d.email = p.email
ON CONFLICT (id_cliente) DO NOTHING;
