-- 1) Dado o nome / número de uma agência, deseja-se saber:

-- -------------------------------------------------------
-- 1.1 - Quais os funcionários, seus cargos e seus
-- endereços, cidades, seus salários e o número de
-- dependentes de cada um, podendo ser classificados por
-- ordem alfabética de nomes ou de salários;
-- -------------------------------------------------------
SELECT 
    f.nome,
    f.cargo,
    f.endereco,
    f.cidade,
    f.salario,
    nd.num_dependente
FROM
    ((SELECT 
        f.nome, COUNT(d.mat_funcionario) AS num_dependente
    FROM
        funcionario f
    -- Left Outer Join para inserir também funcionarios que não possuem dependentes
    LEFT OUTER JOIN dependente d ON d.mat_funcionario = f.matricula
    GROUP BY f.nome) nd
    JOIN funcionario f ON f.nome = nd.nome)
        JOIN
    agencia a ON f.lotacao = a.numero
WHERE -- Pode-se utilizar pesquisa por nome ou numero da agência
    a.nome = 'Haw7820'
    -- a.numero = 7820
-- Pode-se ordenar por nome ou por salário
ORDER BY f.nome;
-- ORDER BY f.salario;

-- -------------------------------------------------------
-- 1.2- Quais os clientes daquela agência, classificando-
-- -os por tipo de conta;
-- -------------------------------------------------------
SELECT 
	cli.nome AS nome_cliente, tipo_conta
FROM
    ((cliente cli
    JOIN conta_cliente cc ON cli.cpf = cc.cpf_cliente)
    JOIN agencia a ON a.numero = cc.num_agencia)
        JOIN
    conta con ON con.num_conta = cc.num_conta
WHERE -- Pode-se utilizar pesquisa por nome ou numero da agência
    a.nome = 'Haw7820'
    -- a.numero = 7820
order by tipo_conta, cli.nome;

-- -------------------------------------------------------
-- 1.3- Quais são as contas especiais com maior saldo
-- devedor (mostrar todas as contas, ordenando do maior
-- saldo devedor para o menor);
-- -------------------------------------------------------
SELECT 
    ca.num_conta, ca.saldo
FROM
    (SELECT 
        *
    FROM
        agencia a
    JOIN conta c ON c.num_agencia = a.numero
    WHERE -- Pode-se utilizar pesquisa por nome ou numero da agência
        -- a.nome = 'Ind2921') ca
        a.numero = 2921) ca
WHERE
    ca.saldo < 0 AND ca.tipo_conta = 'Conta Especial' -- Exibir somente os saldos devedores
ORDER BY ca.saldo; -- Ordenar por ordem crescente

-- -------------------------------------------------------
-- 1.4- Quais são as contas poupança com maior saldo
-- positivo, classificando-as;
-- -------------------------------------------------------
SELECT 
    ca.num_conta, ca.saldo
FROM
    (SELECT 
        *
    FROM
        agencia a
    JOIN conta c ON c.num_agencia = a.numero
    WHERE -- Pode-se utilizar pesquisa por nome ou numero da agência
        -- a.nome = 'Haw7820'
        a.numero = 7820) ca -- ca -> Conta-Agência
WHERE
    ca.tipo_conta = 'Conta Poupança'
ORDER BY ca.saldo DESC;

-- -------------------------------------------------------
-- 1.5- Quais as contas correntes com maior número de
-- transações na última semana (últimos 7 dias), no
-- último mês (últimos 30 dias) e no último ano (últimos
-- 365 dias);
-- -------------------------------------------------------
SELECT 
    c.num_conta, COUNT(*)
FROM
    ((conta c
    JOIN realiza r ON c.num_conta = r.num_conta)
    JOIN transacao t ON t.num_transacao = r.num_transacao)
WHERE
    c.tipo_conta = 'Conta Corrente'
        -- Ajustar para 7, 30 ou 365
        AND (TO_DAYS(NOW()) - TO_DAYS(t.data_hora)) < 7
GROUP BY c.num_conta;


-- 2) Dado um cliente (seu CPF), deseja-se saber:

-- -------------------------------------------------------
-- 2.1- Quais as contas do mesmo, com seus tipos, suas
-- agências, seus gerentes e seus saldos atuais;
-- -------------------------------------------------------
SELECT 
	cli.nome AS cliente,
    cc.num_conta,
    c.tipo_conta,
    a.nome AS agencia,
    f.nome AS gerente,
    c.saldo
FROM
    (((cliente cli
    JOIN conta_cliente cc ON cli.cpf = cc.cpf_cliente)
    JOIN conta c ON c.num_conta = cc.num_conta)
    JOIN agencia a ON a.numero = cc.num_agencia)
        JOIN
    funcionario f ON f.matricula = a.mat_gerente
WHERE -- Pesquisa por CPF do cliente
    cpf = '84484848484';


-- —---------------------------------------------------—
-- 2.2- Quais os nomes dos clientes e seus CPFs com 
-- os quais aquele cliente possui contas conjuntas;
-- —---------------------------------------------------—
SELECT 
    cli.nome AS cliente, cli.cpf AS cpf
FROM
    cliente cli
	JOIN conta_cliente cc ON cli.cpf = cc.cpf_cliente
WHERE
    cpf <> '79488487552'
	AND num_conta = SOME (SELECT 
		num_conta
	FROM
		conta_cliente
        WHERE
            cpf_cliente = '79488487552');


-- 3) Dada uma cidade, deseja-se saber:

-- -------------------------------------------------------
-- 3.1- Quais os nomes e endereços dos clientes que moram
-- naquela cidade, ordenando-os por idade;
-- -------------------------------------------------------
SELECT -- Cliente não possui campo endereço
    nome,
    YEAR(FROM_DAYS(TO_DAYS(CURDATE()) - TO_DAYS(data_nasc))) AS idade
FROM
    cliente
WHERE -- Pesquisa por cidade
    cidade = 'Sobral'
ORDER BY idade, nome; -- Ordena por idade e por nome.