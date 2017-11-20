-- MySQL Script generated by MySQL Workbench
-- Sat Nov 11 16:57:00 2017
-- Model: Equipe374876  Version: 1.0
-- MySQL Workbench Forward Engineering

-- -----------------------------------------------------
-- Triggers
-- -----------------------------------------------------
DELIMITER $$

USE `Equipe374876`$$
DROP TRIGGER IF EXISTS `salario_1500_bef_ins` $$
USE `Equipe374876`$$
CREATE DEFINER = CURRENT_USER TRIGGER `Equipe374876`.`salario_1500_bef_ins` BEFORE INSERT ON `funcionario` FOR EACH ROW
BEGIN
	IF NEW.salario < 1500.00 THEN
		SIGNAL SQLSTATE'45000' SET MESSAGE_TEXT = 'O salário não pode ser menor que R$1500,00!';
    END IF;
END;$$


USE `Equipe374876`$$
DROP TRIGGER IF EXISTS `salario_montante_aft_ins` $$
USE `Equipe374876`$$
CREATE DEFINER = CURRENT_USER TRIGGER `Equipe374876`.`salario_montante_aft_ins` AFTER INSERT ON `funcionario` FOR EACH ROW
BEGIN
	UPDATE agencia a
	SET a.salario_montante = (SELECT
			SUM(f.salario)
		FROM
			funcionario f
		GROUP BY f.lotacao
		HAVING f.lotacao = NEW.lotacao)
	WHERE
		a.numero = NEW.lotacao;
END;$$


USE `Equipe374876`$$
DROP TRIGGER IF EXISTS `salario_1500_bef_upd` $$
USE `Equipe374876`$$
CREATE DEFINER = CURRENT_USER TRIGGER `Equipe374876`.`salario_1500_bef_upd` BEFORE UPDATE ON `funcionario` FOR EACH ROW
BEGIN
	IF NEW.salario < 1500.00 THEN
		SIGNAL SQLSTATE'45000' SET MESSAGE_TEXT = 'O salário não pode ser menor que R$1500,00!';
    END IF;
END;$$


USE `Equipe374876`$$
DROP TRIGGER IF EXISTS `salario_montante_aft_upd` $$
USE `Equipe374876`$$
CREATE DEFINER = CURRENT_USER TRIGGER `Equipe374876`.`salario_montante_aft_upd` AFTER UPDATE ON `funcionario` FOR EACH ROW
BEGIN
	UPDATE agencia a
	SET a.salario_montante = (SELECT
			SUM(f.salario)
		FROM
			funcionario f
		GROUP BY f.lotacao
		HAVING f.lotacao = NEW.lotacao)
	WHERE
		a.numero = NEW.lotacao;
END;$$


USE `Equipe374876`$$
DROP TRIGGER IF EXISTS `salario_montante_aft_del` $$
USE `Equipe374876`$$
CREATE DEFINER = CURRENT_USER TRIGGER `Equipe374876`.`salario_montante_aft_del` AFTER DELETE ON `funcionario` FOR EACH ROW
BEGIN
	UPDATE agencia a
	SET a.salario_montante = (SELECT
			SUM(f.salario)
		FROM
			funcionario f
		GROUP BY f.lotacao
		HAVING f.lotacao = OLD.lotacao)
	WHERE
		a.numero = OLD.lotacao;
END;$$

-- Falta verificar se é uma conta especial para permitir saldo negativo.
-- Consertar Problema: A trigger não permite inserir na tabela ´realiza´ quando o saque é maior que o saldo.
--                     Porém, não remove a tupla correspondente da tabela ´transacao´.
-- Possível solução: Utilizar START TRANSACTION, ROLLBACK e COMMIT na aplicação.
USE `Equipe374876`$$
DROP TRIGGER IF EXISTS `update_saldo_cliente_aft_ins` $$
USE `Equipe374876`$$
CREATE DEFINER = CURRENT_USER TRIGGER `Equipe374876`.`update_saldo_cliente_aft_ins` AFTER INSERT ON `realiza` FOR EACH ROW
BEGIN
	IF (SELECT valor_transacao FROM transacao t WHERE t.num_transacao = NEW.num_transacao) < -(SELECT saldo FROM conta c WHERE c.num_conta = NEW.num_conta) THEN
        DELETE FROM transacao
		WHERE
			num_transacao = NEW.num_transacao;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Saldo Insuficiente!';
	ELSE
		UPDATE conta
		SET
			saldo = saldo + (SELECT
					valor_transacao
				FROM
					transacao t
				WHERE
					t.num_transacao = NEW.num_transacao)
		WHERE
			num_conta = NEW.num_conta;
	END IF;
END;$$


USE `Equipe374876`$$
DROP TRIGGER IF EXISTS `conta_conjunta_agencia_bfr_ins` $$
USE `Equipe374876`$$
CREATE DEFINER = CURRENT_USER TRIGGER `Equipe374876`.`conta_conjunta_agencia_bfr_ins` BEFORE INSERT ON `conta_cliente` FOR EACH ROW
BEGIN
	IF (SELECT COUNT(*) FROM conta_cliente WHERE num_conta = NEW.num_conta GROUP BY num_conta) = 2 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Esta conta já possui dois clientes!';
    END IF;
    
    IF (SELECT COUNT(*) FROM conta_cliente WHERE num_agencia = NEW.num_agencia AND cpf_cliente = NEW.cpf_cliente) = 1 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Este cliente já possui uma conta nesta agência!';
	END IF;
END;$$


USE `Equipe374876`$$
DROP TRIGGER IF EXISTS `cinco_dependentes_bef_ins` $$
USE `Equipe374876`$$
CREATE DEFINER = CURRENT_USER TRIGGER `Equipe374876`.`cinco_dependentes_bef_ins` BEFORE INSERT ON `dependente` FOR EACH ROW
BEGIN
	IF (SELECT COUNT(d.mat_funcionario) FROM funcionario f JOIN dependente d ON d.mat_funcionario = f.matricula WHERE d.mat_funcionario = NEW.mat_funcionario) = 5 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Este funcionario já possui cinco dependentes!';
    END IF;
END;$$


USE `Equipe374876`$$
DROP TRIGGER IF EXISTS `transferencia_aft_ins` $$
USE `Equipe374876`$$
CREATE DEFINER = CURRENT_USER TRIGGER `Equipe374876`.`transferencia_aft_ins` AFTER INSERT ON `transacao` FOR EACH ROW
BEGIN
	INSERT INTO `transacao` (`valor_transacao`, `data_hora`, `tipo`) VALUES (-NEW.valor_transacao, now(), "Transferência");
END;$$

DELIMITER ;