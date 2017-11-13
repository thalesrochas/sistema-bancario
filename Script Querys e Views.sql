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
        JOIN
    conta_poupanca cp ON ca.num_conta = cp.num_conta
ORDER BY ca.saldo;