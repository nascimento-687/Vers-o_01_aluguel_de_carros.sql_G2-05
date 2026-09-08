
-- =====================================================================
-- Regra de negócio: veículos de contratos já encerrados (data_fim no
-- passado) devem voltar a ficar disponíveis para nova locação.
--
-- O UPDATE altera apenas veículos que ainda estão com status = 'ALUGADO'
-- e cujo contrato já terminou.
--
-- O script é idempotente: após a primeira execução, os veículos
-- atualizados ficam como 'DISPONIVEL', portanto uma nova execução não
-- altera novamente essas mesmas linhas.
-- =====================================================================

UPDATE veiculos ve
SET status = 'DISPONIVEL'
FROM contratos c
WHERE c.id_veiculo = ve.id_veiculo
  AND c.data_fim < CURRENT_DATE
  AND ve.status = 'ALUGADO';
```
