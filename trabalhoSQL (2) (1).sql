use sakila;
#1
# A função COUNT(*) vai retornar a quantidade de filmes que queremos especificar da tabela film.
# O AS ele ta sendo utilizado para renomear a tabela para quantidade_filmes.
# O JOIN film_actor ON film.film_id = film_actor.film_id: Vai realizar uma  junção entre as tabelas film e film_actor usando a condição de que o film_id na tabela film seja igual ao film_id na tabela film_actor. Resumo: relaciona os filmes e os atores pelos seus IDS.
# O JOIN actor ON film_actor.actor_id = actor.actor_id : Vai adicionar uma junção entre as tabelas actor e film_actor usando a condição de que o actor_id na tabela film_actor seja igual ao actor_id na tabela actor. Resumo: relacionando os atores aos registros da tabela actor.
# O WHERE actor.first_name = 'Nick' AND actor.last_name = 'Wahlberg', é uma condição que vai filtrar o first_name para Nick e o last_name para Wahlberg. Resumo: retornando apenas os resultados onde o primeiro nome seja Nick e o sobrenome seja Wahlberg.
SELECT COUNT(*) AS quantidade_filmes
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
WHERE actor.first_name = 'Nick' AND actor.last_name = 'Wahlberg';
#2
# O SELECT category.name, COUNT(*) AS quantidade_filmes, seleciona o nome da tabela category e usa a funcao COUNT(*) para fazer a contagem.
# O AS ele ta sendo utilizado para renomear a tabela para quantidade_filmes.
# O JOIN film_category ON film.film_id = film_category.film_id :Vai realizar uma  junção entre as tabelas film e film_category usando a condição de que o film_id na tabela film seja igual ao film_id na tabela film_category. Resumo: relaciona os filmes e as categorias pelos seus IDS.
# O JOIN category ON film_category.category_id = category.category_id, Vai adicionar uma junção entre as tabelas film_category e category, usando a condição de que o category_id na tabela film_category seja igual ao category_id na tabela category. Resumo: relacionando as categorias aos registros da tabela category.
# O GROUP BY category.name: Vai agrupar todos os registros de acordo com os nomes da categoria.
SELECT category.name, COUNT(*) AS quantidade_filmes
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name;
#3
# SELECT tá selecionando duas colunas da tabela actor, especificamente os nomes e sobrenomes dos atores.
# FROM ta indicando que a tabela principal da qual os dados são extraídos é a tabela actor.
# JOIN film_actor ON actor.actor_id = film_actor.actor_id: Realiza uma junção entre as tabelas actor e film_actor usando a condição de que o actor_id na tabela actor seja igual ao actor_id na tabela film_actor. Resumo: relaciona os atores aos filmes que já participaram.
#JOIN film ON film_actor.film_id = film.film_id: Adiciona outra junção entre as tabelas film_actor e film usando o film_id como condição. Resumo: relaciona os filmes aos registros da tabela film. 
#WHERE"" LIKE é uma condição que filtra os filmes. Ela seleciona apenas os filmes que possuem o nome "Baby".
SELECT actor.first_name, actor.last_name
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
WHERE film.title LIKE '%Baby%';
#4
#SELECT film.title, COUNT(actor.actor_id) AS quantidade_atores: A consulta seleciona o título do filme da tabela film e conta o número de atores associados a cada filme usando a função COUNT(actor.actor_id).# FROM, aqui a consulta começa com a tabela film, que é a base para as junções subsequentes.
#JOIN film_category ON film.film_id = film_category.film_id: Realiza uma junção entre as tabelas film e film_category usando o film_id como condição. Resumo: relaciona os filmes às suas categorias. 
#JOIN film_actor ON film.film_id = film_actor.film_id: Adiciona outra junção entre as tabelas film e film_actor usando o film_id como condição. Resumo: relaciona os filmes aos atores que participaram dos filmes. 
#WHERE film_category.category_id = (SELECT category_id FROM category WHERE name = 'Games'): Define uma condição de filtro para incluir apenas os filmes da categoria 'Games'.É feito comparando o category_id da tabela film_category com o category_id da categoria 'Games'.
# GROUP BY : Vai agrupar os resultados de acordo com o título do filme. 
# ORDER BY: Os resultados são ordenados pela contagem de atores (quantidade_atores) em ordem decrescente.
SELECT film.title, COUNT(actor.actor_id) AS quantidade_atores
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN film_actor ON film.film_id = film_actor.film_id
WHERE film_category.category_id = (SELECT category_id FROM category WHERE name = 'Games')
GROUP BY film.title
ORDER BY quantidade_atores DESC;
#5
#SELECT category.name, SUM(payment.amount) AS total_pagamentos: A consulta seleciona o nome da categoria da tabela category e calcula a soma dos valores na coluna amount da tabela payment usando a função SUM().
#JOIN rental ON payment.rental_id = rental.rental_id: Realiza uma junção entre as tabelas payment e rental usando a condição de que o rental_id na tabela payment seja igual ao rental_id na tabela rental. Resumo: relaciona os pagamentos com os aluguéis.
#JOIN inventory ON rental.inventory_id = inventory.inventory_id: Adiciona outra junção entre as tabelas rental e inventory usando o inventory_id como condição. Resumo: relaciona os aluguéis com o inventário.
#JOIN film ON inventory.film_id = film.film_id: Realiza uma junção entre as tabelas inventory e film usando o film_id como condição. Resumo: relaciona o inventário com os filmes.
#JOIN film_category ON film.film_id = film_category.film_id: Adiciona outra junção entre as tabelas film e film_category usando o film_id como condição. Resumo: relaciona os filmes com as categorias.
#JOIN category ON film_category.category_id = category.category_id: Realiza uma junção entre as tabelas film_category e category usando o category_id como condição. Resumo: relaciona as categorias com os registros da tabela category.
#GROUP BY category.name: Vai agrupar os resultados de acordo com os nomes das categorias.
SELECT category.name, SUM(payment.amount) AS total_pagamentos
FROM payment
JOIN rental ON payment.rental_id = rental.rental_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name; 
#6
#SELECT CONCAT(actor.first_name, ' ', actor.last_name) AS actor_name, SUM(payment.amount) AS total_pagamentos: A consulta seleciona o nome completo do ator concatenando os campos first_name e last_name da tabela actor usando a função CONCAT(). Além disso, ela calcula a soma dos valores na coluna amount da tabela payment usando a função SUM().
#JOIN rental ON payment.rental_id = rental.rental_id: Realiza uma junção entre as tabelas payment e rental usando a condição de que o rental_id na tabela payment seja igual ao rental_id na tabela rental. Resumo: relaciona os pagamentos com os aluguéis.
#JOIN inventory ON rental.inventory_id = inventory.inventory_id: Adiciona outra junção entre as tabelas rental e inventory usando o inventory_id como condição. Resumo: relaciona os aluguéis com o inventário.
#JOIN film_actor ON inventory.film_id = film_actor.film_id: Realiza uma junção entre as tabelas inventory e film_actor usando o film_id como condição. Resumo: relaciona o inventário aos atores dos filmes.
#JOIN actor ON film_actor.actor_id = actor.actor_id: Adiciona outra junção entre as tabelas film_actor e actor usando o actor_id como condição. Resumo: relaciona os atores aos registros da tabela actor.
#GROUP BY actor_name: Vai agrupar os resultados de acordo com os nomes dos atores.
SELECT CONCAT(actor.first_name, ' ', actor.last_name) AS actor_name, SUM(payment.amount) AS total_pagamentos
FROM payment
JOIN rental ON payment.rental_id = rental.rental_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film_actor ON inventory.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
GROUP BY actor_name; 
#7
#SELECT country.country, SUM(payment.amount) AS total_pagamentos: A consulta seleciona o nome do país da tabela country e calcula a soma dos valores na coluna amount da tabela payment usando a função SUM().
#FROM payment: a tabela consultada será a payment.
# JOIN customer ON payment.customer_id = customer.customer_id: Realiza uma junção entre as tabelas payment e customer usando a condição de que o customer_id na tabela payment seja igual ao customer_id na tabela customer. Resumo: relaciona os pagamentos aos clientes.
# JOIN address ON customer.address_id = address.address_id: Vai adicionar uma junção entre as tabelas customer e address usando o address_id como condição. Resumo: relaciona os clientes aos seus endereços.
# JOIN city ON address.city_id = city.city_id: Realiza uma junção entre as tabelas address e city usando o city_id como condição. Resumo: relaciona os endereços às cidades.
# JOIN country ON city.country_id = country.country_id: Adiciona mais uma junção, desta vez entre as tabelas city e country, usando o country_id como condição. Resumo: relaciona as cidades aos países.
# GROUP BY country.country: Vai agrupar os resultados de acordo com os nomes dos países.
SELECT country.country, SUM(payment.amount) AS total_pagamentos
FROM payment
JOIN customer ON payment.customer_id = customer.customer_id
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
GROUP BY country.country; 
#8
#SELECT film.title, SUM(payment.amount) AS total_pagamentos: A consulta seleciona o título do filme da tabela film e calcula a soma dos valores na coluna amount da tabela payment usando a função SUM(). 
#JOIN rental ON payment.rental_id = rental.rental_id: Realiza uma junção entre as tabelas payment e rental usando a condição de que o rental_id na tabela payment seja igual ao rental_id na tabela rental. Resumo: relaciona os pagamentos com os aluguéis.
#JOIN inventory ON rental.inventory_id = inventory.inventory_id: Adiciona outra junção entre as tabelas rental e inventory usando o inventory_id como condição. Resumo: relaciona os aluguéis com o inventário.
#JOIN film ON inventory.film_id = film.film_id: Realiza uma junção entre as tabelas inventory e film usando o film_id como condição. Resumo: relaciona o inventário com os filmes.
#GROUP BY film.title: Vai agrupar os resultados de acordo com o titulo dos filmes.
SELECT film.title, SUM(payment.amount) AS total_pagamentos
FROM payment
JOIN rental ON payment.rental_id = rental.rental_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
GROUP BY film.title;