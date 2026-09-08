-- =====================================================================
-- Exemplo de UPDATE pontual: cliente do contrato CT-0002 pediu para
-- trocar a forma de pagamento de PIX (já é PIX no cadastro original,
-- então simulamos a troca inversa: de CARTAO para PIX no CT-0001).
-- A cláusula "AND forma_pagamento <> 'PIX'" torna o script idempotente.
-- =====================================================================

UPDATE contratos
SET forma_pagamento = 'PIX'
WHERE numero_contrato = 'CT-0001'
  AND forma_pagamento <> 'PIX';
