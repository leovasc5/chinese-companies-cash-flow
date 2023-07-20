use supermercado;

CREATE VIEW supermercado.vw_pedidos_mensais AS 
    SELECT 
    	cons.id 'id_consumidor',
    	cons.nome 'consumidor', 
        perf.titulo 'perfil',
        STR_TO_DATE(CONCAT(DATE_FORMAT(ped.data_pedido, '%Y-%m'), '-01'), '%Y-%m-%d') 'data_pedido',
        STR_TO_DATE(CONCAT(DATE_FORMAT(ped.data_envio, '%Y-%m'), '-01'), '%Y-%m-%d') 'data_envio',
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
  