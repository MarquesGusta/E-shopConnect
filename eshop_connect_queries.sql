-- ex1 liste os nomes e telefones dos usuários
SELECT name AS nome, phoneNumber AS telefone
FROM users;

-- ex2 liste os nomes de compradores
SELECT * FROM buyer;
SELECT name AS nome
FROM users
WHERE userid IN(SELECT fk_userid FROM buyer);

-- ex3 liste os nomes dos vendedores
SELECT * FROM seller;
SELECT name AS nome
FROM users
WHERE userid IN(SELECT fk_userid FROM seller);

-- ex4 listar infromações do cartão de crétido dos usuários
SELECT
	banco.pk_cardNumber,
    banco.expiryDate,
	banco.bank,
    credito.fk_userid,
    credito.organization
FROM
	bankcard AS banco
JOIN creditcard AS credito
ON banco.pk_cardNumber = credito.fk_cardNumber;

SHOW COLUMNS FROM bankcard;

-- ex4.2 listar infromações do cartão de debito dos usuários
SELECT 
	banco.pk_cardNumber,
    banco.expiryDate,
    banco.bank,
    debito.fk_userid
FROM
	bankcard AS banco
JOIN
	debitcard AS debito
ON
	banco.pk_cardNumber = debito.fk_cardNumber;

-- ex5 selecione os nomes dos produtos e seus preços
SELECT 
	name AS nome,
    price AS preco
FROM
	product AS produto;
    
-- ex6 selecione todos os produtos de uma deerminada marca
SELECT 
	produto.name AS nome,
    produto.price AS preco,
    produto.fk_brandName AS marca
FROM
	product AS produto
WHERE produto.fk_brandName = "Microsoft";

-- ex7 encontre o número de itens em cada pedido
SELECT
	fk_orderNumber AS ordem,
    SUM(quantity) AS qtde_itens
FROM
	Contain
GROUP BY 
	ordem
ORDER BY qtde_itens ASC;

-- ex8 calcule o total de vendas por loja
SELECT * FROM store;
SELECT * FROM product;
SELECT * FROM orderitem;

SELECT
	s.name AS store_name,
    SUM(o.price) AS total_sales
FROM
	store AS s
INNER JOIN
	product AS p
ON
	s.pk_sid = p.fk_sid
INNER JOIN
	orderItem AS o
ON p.pk_pid = o.fk_pid
GROUP BY
	store_name;
    
-- total de todas as lojas
SELECT
    SUM(o.price) AS total_sales
FROM
	store AS s
INNER JOIN
	product AS p
ON
	s.pk_sid = p.fk_sid
INNER JOIN
	orderItem AS o
ON p.pk_pid = o.fk_pid;

-- ex9 liste as avaliações dos produtos(grade) com seus nomes e conteúdo do usuário
SELECT
	p.name AS nome,
    c.grade AS avaliacao,
    c.content AS conteudo
FROM
	product AS p
INNER JOIN
	comments AS c
ON
	p.pk_pid = c.fk_pid;
    
-- ex10 selecione os nomes do compradores que fizeram pedidos
SELECT
	DISTINCT u.name AS nome
FROM
	buyer AS b
JOIN
	users AS u
ON
	b.fk_userid = u.userid
JOIN
	creditcard AS c
ON
	u.userid = c.fk_userid
JOIN
	payment AS p
ON
	c.fk_cardNumber = p.fk_cardNumber;
    
-- 11 encontrar vendedores que gerenciam varias lojas
SELECT
	u.name,
    s.fk_userid
FROM
	seller AS s
JOIN
	Manage AS m
ON
	s.fk_userid = m.fk_userid
JOIN
	users AS u
ON
	s.fk_userid = u.userid
GROUP BY
	s.fk_userid, u.userid
HAVING
	COUNT(m.fk_sid) > 1;
    
-- 12 liste nomes das lojas que oferecem produtos de uma determinada marca
SELECT DISTINCT
	p.name,
	s.name,
    b.pk_brandName
FROM
	Product AS p
JOIN
	store AS s
ON
	fk_sid = pk_sid
JOIN
	Brand AS b
ON
	p.fk_brandName = b.pk_brandName
WHERE
	b.pk_brandName = "Microsoft";
    
-- 13 Encontre  as  informações  de  entrega  de  um  pedido  específico  (por exemplo, orderNumber = 123)
SELECT
	o.pk_orderNumber AS numPedido,
    c.fk_itemId AS idPedido,
    a.pk_addrid AS identificador,
    a.name AS nomeCliente ,
    a.contactPhoneNumber AS numContato,
    a.province AS provincia,
    a.city AS cidade,
    a.streetAddr AS rua
FROM
	Orders AS o
JOIN
	Contain AS c
ON
	o.pk_orderNumber = c.fk_orderNumber
JOIN
	deliver_to AS d
ON
	o.pk_orderNumber = d.fk_orderNumber
JOIN
	address AS a
ON
	d.fk_addrid = a.pk_addrid;
    
select * from address;

-- 14 Calcule o valor médio das compras dos compradores.
SELECT
	AVG(totalAmount)
FROM
	Orders;

SELECT
	u.name,
    AVG(o.totalAmount)
FROM
	users AS u
JOIN
	creditcard AS c
ON
	u.userid = fk_userid
JOIN
	Payment AS p
ON
	c.fk_cardNumber = p.fk_cardNumber
JOIN
	Orders AS o
ON
	p.fk_orderNumber = o.pk_orderNumber
GROUP BY
	u.name;

-- 15 Liste as marcas que têm pontos de serviço em uma determinada cidade (por exemplo, "Nova York").
SELECT DISTINCT
	b.pk_brandName,
    s.city
FROM
	Brand AS b
JOIN
	After_Sales_Service_At AS a
ON
	b.pk_brandName = a.fk_brandName
JOIN
	ServicePoint AS s
ON
	a.fk_spid = s.pk_spid
WHERE
	(SELECT s.city = "Montreal");
    
-- 16 Encontre o nome e o endereço das lojas com uma classificação de cliente superior a 4.
SELECT
	s.name,
    s.streetaddr
FROM
	store AS s
WHERE
	(s.customerGrade > 4);
    
-- 17.Liste os produtos com estoque esgotado
SELECT
	p.name AS em_falta
FROM
	Product AS p
WHERE
	p.amount = 0;
    
-- 18.Encontre os produtos mais caros em cada marca
SELECT
	p.fk_brandName AS marca,
    MAX(p.price) AS preco,
    GROUP_CONCAT(p.name) AS produto
FROM
	Product AS p
GROUP BY
	p.fk_brandName;
	
	
-- 19.Calcule o total de pedidos em que um determinado cartão de crédito (por exemplo, cardNumber = '1234567890')foi usado
SELECT
	COUNT(p.fk_cardNumber)
FROM
	creditcard AS c
JOIN
	Payment AS p
ON
	c.fk_cardNumber = p.fk_cardNumber
WHERE
	p.fk_cardNumber = 4902921234028831
GROUP BY
	p.fk_cardNumber;

-- 20.Liste  os  nomes  e  números  de  telefone  dos  usuários  que  não  fizeram pedidos
SELECT DISTINCT
	u.name,
    u.phoneNumber
FROM
	users AS u
JOIN
	creditcard AS c
ON
	u.userid = c.fk_userid
LEFT JOIN
	Payment AS p
ON
	c.fk_cardNumber = p.fk_cardNumber
WHERE
	c.fk_cardNumber NOT IN(SELECT fk_cardNumber FROM Payment);

-- 21.Liste os nomes dos produtos que foram revisados por compradores com uma classificação superior a 4
SELECT distinct
	p.name,
    c.grade
FROM
	Product as p
JOIN
	Comments as c
WHERE
	grade > 4;

-- 22.Encontre os nomes dos vendedores que não gerenciam nenhuma loja
SELECT distinct
	u.name,
    u.userid
FROM
	users AS u
JOIN
	seller AS s
ON
	u.userid = s.fk_userid
LEFT JOIN
	manage AS m
ON
	s.fk_userid = m.fk_userid
WHERE
	s.fk_userid NOT IN (SELECT fk_userid FROM manage);

-- 23.Liste os nomes dos compradores que fizeram pelo menos 3 pedidos.
SELECT
	u.name,
	COUNT(u.name) AS qtd
FROM
	users AS u
JOIN
	creditcard AS c
ON
	u.userid = c.fk_userid
right JOIN
	Payment AS p
ON
	c.fk_cardNumber = p.fk_cardNumber
GROUP BY
	u.name
HAVING
	qtd >= 3;

-- 24.Encontre o total de pedidos pagos com cartão de crédito versus cartão de débito
SELECT
	count(c.fk_cardNumber) AS credito,
    count(d.fk_cardNumber) AS debito
FROM
	Payment AS p
right JOIN
	creditcard AS c
ON
	p.fk_cardNumber = c.fk_cardNumber
left JOIN
	debitcard AS d
ON
	p.fk_cardNumber = d.fk_cardNumber
GROUP BY
	c.fk_cardNumber, d.fk_cardNumber;

-- 25.Liste as marcas (brandName) que não têm produtos na loja com ID 1
-- 26.Calcule a quantidade média de produtos disponíveis em todas as lojas
-- 27.Encontre os nomes das lojas que não têm produtos em estoque (amount = 0)
-- 28.Liste os nomes dos vendedores que gerenciam uma loja localizada em "São Paulo"
-- 29.Encontre  o  número  total  de  produtos  de  uma  marca  específica  (por exemplo, "Sony") disponíveis em todas as lojas
-- 30.Calcule  o  valor  total  de  todas  as  compras  feitas  por  um  comprador específico (por exemplo, userid = 1).