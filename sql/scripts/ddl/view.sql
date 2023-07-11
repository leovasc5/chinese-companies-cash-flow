CREATE VIEW vw_pedidos AS 
    SELECT 
    	cons.id 'id_consumidor',
    	cons.nome 'consumidor', 
        perf.titulo 'perfil',
        ped.data_pedido 'data_de_pedido',
        ped.data_envio 'data_de_envio',
    	ende.codigo_postal 'codigo_postal',
        ende.cidade 'cidade',
        ende.estado 'estado',
        ende.pais 'pais',
        ende.regiao 'regiao',
        tr.titulo 'modo_transporte',
        prod.id 'id_produto',
        prod.nome 'produto',
        ped.id 'id_pedido',
        assoc.preco 'preco',
        sub.titulo 'sub_categoria',
        cat.titulo 'categoria'
    FROM 
    	supermercado.consumidor cons
    JOIN 
    	perfil perf ON cons.id_perfil = perf.id
    JOIN
    	pedido ped ON ped.id_consumidor = cons.id
    JOIN 
    	endereco ende ON ped.id_endereco = ende.id
    JOIN
    	transporte tr ON ped.id_transporte = tr.id
    JOIN
    	produto_pedido assoc ON assoc.id_pedido = ped.id
    JOIN
    	produto prod ON prod.id = assoc.id_produto
    JOIN
    	subcategoria sub ON sub.id = prod.id_subcategoria
    JOIN
    	categoria cat ON cat.id = sub.id_categoria
    ORDER BY ped.data_pedido;
    
SELECT * FROM vw_pedidos;