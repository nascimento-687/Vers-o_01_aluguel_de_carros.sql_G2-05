-- =====================================================================
-- Regra de negócio: veículo de contrato já encerrado (data_fim no
-- passado) deve voltar a ficar disponível para nova locação.
-- Idempotente: na segunda execução não há mais veículos com
-- status = 'ALUGADO' associados a contratos vencidos, então o UPDATE
-- simplesmente não afeta nenhuma linha.
-- =====================================================================

UPDATE veiculos ve
SET status = 'DISPONIVEL'
FROM contratos c
WHERE c.id_veiculo = ve.id_veiculo
  AND c.data_fim < CURRENT_DATE
  AND ve.status = 'ALUGADO';
