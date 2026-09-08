# Aluguel de Carros — Projeto de Banco de Dados (PostgreSQL)

## 1. Apresentação do projeto

**Tema:** Aluguel de Carros

**Objetivo geral:** desenvolver o banco de dados relacional de um sistema de locação de veículos voltado a motoristas de aplicativo. O sistema controla a frota (motos, carros de passeio e caminhões), os clientes que alugam os veículos, os atendentes que fecham os contratos e os próprios contratos de locação, com sua forma de pagamento e período de vigência.

**Público-alvo:** empresas de locação de veículos que atendem motoristas de aplicativos de transporte/entrega, e que precisam controlar disponibilidade da frota, histórico de contratos e dados de clientes e atendentes — inclusive quando uma mesma pessoa acumula os dois papéis.

## 2. Modelagem — Diagrama Entidade-Relacionamento

Decisão de modelagem: o enunciado exige que **atendentes também possam ser clientes**. Para não duplicar CPF, nome e e-mail em duas tabelas independentes, usei **especialização** (generalização/especialização): `pessoas` é a superclasse com os dados comuns, e `clientes`/`atendentes` são subclasses — cada uma tem sua chave primária compartilhada com `pessoas` (relacionamento 1:1 opcional). Uma pessoa pode ter registro só em `clientes`, só em `atendentes`, nos dois, ou em nenhum ainda.

```mermaid
erDiagram
    PESSOAS ||--o| CLIENTES : "pode ser"
    PESSOAS ||--o| ATENDENTES : "pode ser"
    CLIENTES ||--o{ CONTRATOS : "contrata"
    ATENDENTES ||--o{ CONTRATOS : "atende"
    VEICULOS ||--o{ CONTRATOS : "é alugado em"

    PESSOAS {
        int id_pessoa PK
        varchar cpf UK
        varchar nome
        varchar sobrenome
        varchar email UK
    }
    CLIENTES {
        int id_cliente PK_FK
        varchar endereco
        varchar dados_bancarios
    }
    ATENDENTES {
        int id_atendente PK_FK
        varchar matricula UK
        date data_admissao
    }
    VEICULOS {
        int id_veiculo PK
        varchar placa UK
        varchar marca
        varchar modelo
        varchar tipo
        varchar status
        numeric valor_diaria
    }
    CONTRATOS {
        int id_contrato PK
        varchar numero_contrato UK
        date data_contrato
        varchar forma_pagamento
        int id_cliente FK
        int id_atendente FK
        int id_veiculo FK
        date data_inicio
        date data_fim
        numeric valor_total
    }
```

### Outras decisões de design

| Decisão | Justificativa |
|---|---|
| `tipo` de veículo e `forma_pagamento` como `CHECK` em vez de tabela de domínio | São poucos valores, fixos e pouco prováveis de mudar — o `CHECK` já garante integridade sem exigir `JOIN` extra em toda consulta. |
| `status` do veículo (`DISPONIVEL` / `ALUGADO` / `MANUTENCAO`) | Não estava explícito no enunciado, mas é necessário para o sistema saber quais veículos podem ser alugados — demonstrado nos scripts de `UPDATE`. |
| `contratos.id_atendente` como `NOT NULL` | Assunção de negócio: todo contrato é fechado por um atendente da empresa. |
| `ON DELETE CASCADE` de `clientes`/`atendentes` para `pessoas` | Se a pessoa é removida, os papéis dela deixam de existir junto. |
| `ON DELETE RESTRICT` de `contratos` para `clientes`/`atendentes`/`veiculos` | Contrato é registro histórico: não pode "sumir" o cliente/veículo de um contrato existente. Validado no script `013`. |
| `numero_contrato`, `cpf`, `email`, `placa`, `matricula` com `UNIQUE` | Chaves de negócio que não podem se repetir, além da chave primária técnica (`SERIAL`). |

## 3. Estrutura do repositório

```
.
├── README.md
└── scripts/
    ├── 001__create_table_pessoas.sql
    ├── 002__create_table_clientes.sql
    ├── 003__create_table_atendentes.sql
    ├── 004__create_table_veiculos.sql
    ├── 005__create_table_contratos.sql
    ├── 006__insert_into_pessoas.sql
    ├── 007__insert_into_clientes.sql
    ├── 008__insert_into_atendentes.sql
    ├── 009__insert_into_veiculos.sql
    ├── 010__insert_into_contratos.sql
    ├── 011__update_veiculos_status.sql
    ├── 012__update_contratos_forma_pagamento.sql
    ├── 013__delete_from_contratos.sql
    └── 014__create_view_pessoas_atendentes.sql
```

Convenção de nomes: `[versão]__[ação]_[descrição/objeto].sql`. Todos os scripts foram testados em **PostgreSQL 16** e são seguros para rodar mais de uma vez (`CREATE TABLE IF NOT EXISTS`, `CREATE OR REPLACE VIEW` e `INSERT ... ON CONFLICT DO NOTHING`).

## 4. Como executar

```bash
# 1) Criar o banco
createdb aluguel_carros

# 2) Rodar todos os scripts em ordem
for f in scripts/*.sql; do
  psql -d aluguel_carros -f "$f"
done
```

Ou, um a um, na ordem numérica indicada acima com `psql -d aluguel_carros -f scripts/001__create_table_pessoas.sql`, e assim por diante.

## 5. O que cada fase de scripts demonstra

- **001–005 (DDL):** criação das 5 tabelas, com chaves primárias, estrangeiras, `UNIQUE`, `NOT NULL` e `CHECK`.
- **006–010 (DML - INSERT):** carga de dados de exemplo cobrindo todos os relacionamentos, incluindo uma pessoa (Juliana Pereira) que é cliente **e** atendente ao mesmo tempo.
- **011–012 (DML - UPDATE):** atualização automática do status do veículo quando o contrato vence, e alteração pontual da forma de pagamento de um contrato.
- **013 (DML - DELETE):** exclusão simples de um registro de teste, e uma validação de que a restrição `ON DELETE RESTRICT` realmente impede excluir um cliente com contrato ativo.
- **014 (extra):** view `vw_pessoas_papeis`, que lista cada pessoa indicando se ela é cliente, atendente, ou os dois.
