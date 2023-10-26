-- ex 2.a
SELECT
	name AS nome
FROM
	product;
    
-- ex 2.b
SELECT
	name AS nome
FROM
	users;
    
-- ex 2.c
SELECT
	name AS nome
FROM
	store;
    
-- ex 2.d
SELECT
	streetAddr AS rua,
    name AS nome
FROM
	address;
    
-- ex 2.e
SELECT
	name AS nome
FROM
	product
WHERE
	type = "laptop";
    
-- ex2.f
SELECT
	streetAddr AS endereco,
    startTime AS ini,
    endTime AS final
FROM
	servicepoint AS s
WHERE
	s.city = (SELECT city FROM users WHERE userid = 5);
    
-- ex2.g
SELECT
	SUM(quantity) AS quantidade
FROM
	Save_to_Shopping_Cart
JOIN
	Product
ON
	fk_pid = pk_pid
JOIN
	store
ON
	fk_sid = pk_sid
WHERE(pk_sid = 8);

-- ex2.h
SELECT
	content AS comentario
FROM
	Comments
JOIN
	Product
ON
	fk_pid = pk_pid
WHERE(pk_pid = 123456789);