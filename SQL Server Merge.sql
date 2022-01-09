USE TesteA
GO

MERGE dbo.TabelaB AS Destino
USING
(SELECT * FROM dbo.TabelaA) AS Origem
ON (Origem.Id = Destino.Id) -- chaves para comparação

-- Se o registro existe nas 2 tabelas
WHEN MATCHED THEN
    UPDATE SET Destino.Id = Origem.Id,
               Destino.Nome = Origem.Nome,
               Destino.Cidade = Origem.Cidade

-- Se não existe na origem, apenas no destino, apaga linha da origem.
WHEN NOT MATCHED BY SOURCE THEN
    DELETE

-- Se o registro não existe no destino, insere.
WHEN NOT MATCHED BY TARGET THEN
    INSERT VALUES
           (Origem.Id, Origem.Nome, Origem.Cidade)
OUTPUT $action,
       Inserted.*,
       Deleted.*;
