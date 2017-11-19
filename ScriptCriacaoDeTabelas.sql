-- MySQL Script generated by MySQL Workbench
-- Wed Nov  8 20:32:23 2017
-- Model: Equipe374876  Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Equipe374876
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Equipe374876` ;

-- -----------------------------------------------------
-- Schema Equipe374876
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Equipe374876` DEFAULT CHARACTER SET utf8 ;
USE `Equipe374876` ;

-- -----------------------------------------------------
-- Table `funcionario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `funcionario` ;

CREATE TABLE IF NOT EXISTS `funcionario` (
  `matricula` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(50) NOT NULL,
  `sexo` ENUM('Feminino', 'Masculino') NOT NULL,
  `data_nasc` DATE NOT NULL,
  `cidade` VARCHAR(45) NULL,
  `endereco` VARCHAR(45) NULL,
  `cargo` ENUM('Atendente', 'Caixa', 'Gerente') NOT NULL,
  `salario` DECIMAL(8,2) NOT NULL DEFAULT 0.00,
  `senha` VARCHAR(20) NOT NULL,
  `lotacao` INT NOT NULL,
  PRIMARY KEY (`matricula`),
  INDEX `fk_Funcionario_Agencia_idx` (`lotacao` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agencia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `agencia` ;

CREATE TABLE IF NOT EXISTS `agencia` (
  `numero` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `mat_gerente` INT NOT NULL,
  `salario_montante` DECIMAL(12,2) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`numero`),
  INDEX `fk_Agencia_Funcionario1_idx` (`mat_gerente` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `conta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `conta` ;

CREATE TABLE IF NOT EXISTS `conta` (
  `num_conta` INT NOT NULL AUTO_INCREMENT,
  `num_agencia` INT NOT NULL,
  `saldo` DECIMAL(11,2) NOT NULL DEFAULT 0.00,
  `senha` INT(6) NOT NULL,
  `tipo_conta` ENUM('Conta Corrente', 'Conta Poupança', 'Conta Especial') NOT NULL,
  PRIMARY KEY (`num_conta`),
  INDEX `fk_Contas_Agencia1_idx` (`num_agencia` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `conta_poupanca`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `conta_poupanca` ;

CREATE TABLE IF NOT EXISTS `conta_poupanca` (
  `num_conta` INT NOT NULL,
  `taxa_juros` DECIMAL(5,2) NOT NULL DEFAULT 0.00,
  INDEX `fk_Poupança_Contas1_idx` (`num_conta` ASC),
  PRIMARY KEY (`num_conta`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `conta_especial`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `conta_especial` ;

CREATE TABLE IF NOT EXISTS `conta_especial` (
  `num_conta` INT NOT NULL,
  `limite_credito` DECIMAL(7,2) NOT NULL DEFAULT 0.00,
  INDEX `fk_Conta especial_Contas1_idx` (`num_conta` ASC),
  PRIMARY KEY (`num_conta`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `transacao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transacao` ;

CREATE TABLE IF NOT EXISTS `transacao` (
  `num_transacao` INT NOT NULL AUTO_INCREMENT,
  `valor_transacao` DECIMAL(10,2) NOT NULL,
  `data_hora` DATETIME NOT NULL,
  `tipo` ENUM('Saque', 'Estorno', 'Transferência', 'Depósito') NOT NULL,
  PRIMARY KEY (`num_transacao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `realiza`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `realiza` ;

CREATE TABLE IF NOT EXISTS `realiza` (
  `num_transacao` INT NOT NULL,
  `num_conta` INT NOT NULL,
  PRIMARY KEY (`num_transacao`, `num_conta`),
  INDEX `fk_Transacoes_has_Contas_Contas1_idx` (`num_conta` ASC),
  INDEX `fk_Transacoes_has_Contas_Transacoes1_idx` (`num_transacao` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cliente` ;

CREATE TABLE IF NOT EXISTS `cliente` (
  `cpf` CHAR(11) NOT NULL,
  `rg` VARCHAR(25) NOT NULL,
  `nome` VARCHAR(50) NOT NULL,
  `data_nasc` DATE NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `endereco` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cpf`),
  UNIQUE INDEX `RG_UNIQUE` (`rg` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `conta_cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `conta_cliente` ;

CREATE TABLE IF NOT EXISTS `conta_cliente` (
  `cpf_cliente` CHAR(11) NOT NULL,
  `num_conta` INT NOT NULL,
  `num_agencia` INT NOT NULL,
  INDEX `fk_Cliente-Conta_Clientes1_idx` (`cpf_cliente` ASC),
  INDEX `fk_Cliente-Conta_Contas1_idx` (`num_conta` ASC),
  INDEX `fk_Cliente-Conta_agencia1_idx` (`num_agencia` ASC),
  PRIMARY KEY (`cpf_cliente`, `num_conta`, `num_agencia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dependente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dependente` ;

CREATE TABLE IF NOT EXISTS `dependente` (
  `mat_funcionario` INT NOT NULL,
  `nome_dependente` VARCHAR(50) NOT NULL,
  `parentesco` ENUM('Filho', 'Cônjuge', 'Genitor') NOT NULL,
  `data_nasc` DATE NOT NULL,
  `idade` INT NULL,
  PRIMARY KEY (`mat_funcionario`, `nome_dependente`),
  INDEX `fk_Dependente_Funcionario1_idx` (`mat_funcionario` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `conta_corrente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `conta_corrente` ;

CREATE TABLE IF NOT EXISTS `conta_corrente` (
  `num_conta` INT NOT NULL,
  PRIMARY KEY (`num_conta`))
ENGINE = InnoDB;

USE `Equipe374876` ;

-- -----------------------------------------------------
-- Placeholder table for view `contas_gerente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `contas_gerente` (`mat_gerente` INT, `nome_cliente` INT, `tipo_conta` INT, `saldo` INT);

-- -----------------------------------------------------
-- Placeholder table for view `extrato_7dias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `extrato_7dias` (`num_conta` INT, `num_transacao` INT, `data_hora` INT, `tipo` INT, `valor_transacao` INT);

-- -----------------------------------------------------
-- Placeholder table for view `extrato_30dias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `extrato_30dias` (`num_conta` INT, `num_transacao` INT, `data_hora` INT, `tipo` INT, `valor_transacao` INT);

-- -----------------------------------------------------
-- Placeholder table for view `extrato_365dias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `extrato_365dias` (`num_conta` INT, `num_transacao` INT, `data_hora` INT, `tipo` INT, `valor_transacao` INT);

-- -----------------------------------------------------
-- View `contas_gerente`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `contas_gerente` ;
DROP TABLE IF EXISTS `contas_gerente`;
USE `Equipe374876`;
CREATE  OR REPLACE VIEW `contas_gerente` AS
    SELECT 
        a.mat_gerente,
        cli.nome AS nome_cliente,
        c.tipo_conta,
        c.saldo
    FROM
        (((conta_cliente cc
        JOIN agencia a ON cc.num_agencia = a.numero)
        JOIN cliente cli ON cc.cpf_cliente = cli.cpf)
        JOIN conta c ON cc.num_conta = c.num_conta);

-- -----------------------------------------------------
-- View `extrato_7dias`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `extrato_7dias` ;
DROP TABLE IF EXISTS `extrato_7dias`;
USE `Equipe374876`;
CREATE  OR REPLACE VIEW `extrato_7dias` AS
    SELECT 
        c.num_conta,
        t.num_transacao,
        t.data_hora,
        t.tipo,
        t.valor_transacao
    FROM
        ((conta c
        JOIN realiza r ON c.num_conta = r.num_conta)
        JOIN transacao t ON t.num_transacao = r.num_transacao)
    WHERE
        (TO_DAYS(NOW()) - TO_DAYS(t.data_hora)) <= 7
    ORDER BY c.num_conta, t.data_hora;

-- -----------------------------------------------------
-- View `extrato_30dias`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `extrato_30dias` ;
DROP TABLE IF EXISTS `extrato_30dias`;
USE `Equipe374876`;
CREATE  OR REPLACE VIEW `extrato_30dias` AS
    SELECT 
        c.num_conta,
        t.num_transacao,
        t.data_hora,
        t.tipo,
        t.valor_transacao
    FROM
        ((conta c
        JOIN realiza r ON c.num_conta = r.num_conta)
        JOIN transacao t ON t.num_transacao = r.num_transacao)
    WHERE
        (TO_DAYS(NOW()) - TO_DAYS(t.data_hora)) <= 30
    ORDER BY c.num_conta, t.data_hora;

-- -----------------------------------------------------
-- View `extrato_365dias`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `extrato_365dias` ;
DROP TABLE IF EXISTS `extrato_365dias`;
USE `Equipe374876`;
CREATE  OR REPLACE VIEW `extrato_365dias` AS
    SELECT 
        c.num_conta,
        t.num_transacao,
        t.data_hora,
        t.tipo,
        t.valor_transacao
    FROM
        ((conta c
        JOIN realiza r ON c.num_conta = r.num_conta)
        JOIN transacao t ON t.num_transacao = r.num_transacao)
    WHERE
        (TO_DAYS(NOW()) - TO_DAYS(t.data_hora)) <= 365
    ORDER BY c.num_conta, t.data_hora;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;