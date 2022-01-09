-- Referência
-- https://docs.microsoft.com/pt-br/sql/t-sql/statements/merge-transact-sql?view=sql-server-ver15

USE TesteA
GO

MERGE dbo.TabelaB AS Destino
USING
(SELECT * FROM dbo.TabelaA) AS Origem
ON (Origem.Id = Destino.Id) -- chaves para comparação

-- Se as chaves forem iguais nas 2 tabelas, atualiza a de destino.
WHEN MATCHED THEN
    UPDATE SET Destino.Id = Origem.Id,
               Destino.Nome = Origem.Nome,
               Destino.Cidade = Origem.Cidade

-- Se não existe na origem, apenas no destino, apaga linha da origem.
WHEN NOT MATCHED BY SOURCE THEN
    DELETE

-- Se a chave não existe no destino, insere.
WHEN NOT MATCHED BY TARGET THEN
    INSERT VALUES
           (Origem.Id, Origem.Nome, Origem.Cidade)
OUTPUT $action,
       Inserted.*,
       Deleted.*;
