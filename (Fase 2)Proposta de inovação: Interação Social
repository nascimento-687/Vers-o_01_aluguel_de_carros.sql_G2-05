CREATE TABLE avaliacoes (
    id_avaliacao SERIAL PRIMARY KEY,

    id_cliente INT NOT NULL,
    id_contrato INT NOT NULL,

    nota INT NOT NULL
        CHECK (nota BETWEEN 1 AND 5),

    comentario VARCHAR(500),

    data_avaliacao DATE NOT NULL DEFAULT CURRENT_DATE,

    FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente),

    FOREIGN KEY (id_contrato)
        REFERENCES contratos(id_contrato),

    UNIQUE (id_contrato)
);


CREATE TABLE curtidas (
    id_curtida SERIAL PRIMARY KEY,

    id_avaliacao INT NOT NULL,
    id_cliente INT NOT NULL,

    data_curtida DATE NOT NULL DEFAULT CURRENT_DATE,

    FOREIGN KEY (id_avaliacao)
        REFERENCES avaliacoes(id_avaliacao)
        ON DELETE CASCADE,

    FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente)
        ON DELETE CASCADE,

    -- O mesmo cliente não pode curtir duas vezes
    -- a mesma avaliação.
    UNIQUE (id_avaliacao, id_cliente)
);
INSERT INTO avaliacoes
(id_cliente, id_contrato, nota, comentario)
VALUES
(1, 1, 5, 'Carro excelente e muito confortável.'),
(2, 2, 4, 'Boa experiência, o veículo estava em bom estado.'),
(3, 3, 5, 'Gostei muito do atendimento e do veículo.'),
(5, 4, 4, 'O veículo atendeu bem às minhas necessidades.');
INSERT INTO curtidas
(id_avaliacao, id_cliente)
VALUES
(1, 2),
(1, 3),
(2, 1),
(3, 5),
(4, 1);
SELECT
    p.nome || ' ' || p.sobrenome AS cliente,
    v.marca || ' ' || v.modelo AS veiculo,
    a.nota,
    a.comentario,
    COUNT(cu.id_curtida) AS curtidas,
    a.data_avaliacao

FROM avaliacoes a

JOIN pessoas p
    ON a.id_cliente = p.id_pessoa

JOIN contratos c
    ON a.id_contrato = c.id_contrato

JOIN veiculos v
    ON c.id_veiculo = v.id_veiculo

LEFT JOIN curtidas cu
    ON a.id_avaliacao = cu.id_avaliacao

GROUP BY
    p.nome,
    p.sobrenome,
    v.marca,
    v.modelo,
    a.nota,
    a.comentario,
    a.data_avaliacao

ORDER BY
    curtidas DESC;
