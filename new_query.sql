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
	servicepoint