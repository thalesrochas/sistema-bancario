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