-- MySQL Script generated by MySQL Workbench
-- Wed Nov  8 20:32:50 2017
-- Model: Equipe374876  Version: 1.0
-- MySQL Workbench Forward Engineering

-- -----------------------------------------------------
-- Data for table `funcionario`
-- -----------------------------------------------------
START TRANSACTION;
USE `Equipe374876`;
INSERT INTO `funcionario` (`matricula`, `nome`, `sexo`, `data_nasc`, `cidade`, `endereco`, `cargo`, `salario`, `senha`, `lotacao`) VALUES (1, 'Linda Levine', 'Feminino', '1974-03-01', 'Sobral', 'Rua Angelim', 'Gerente', 35678.09, '123456', 8714);
INSERT INTO `funcionario` (`matricula`, `nome`, `sexo`, `data_nasc`, `cidade`, `endereco`, `cargo`, `salario`, `senha`, `lotacao`) VALUES (2, 'Casey Benton', 'Masculino', '1964-01-11', 'Paraná', 'Rua Ararupe', 'Caixa', 8726.99, '112233', 8714);
INSERT INTO `funcionario` (`matricula`, `nome`, `sexo`, `data_nasc`, `cidade`, `endereco`, `cargo`, `salario`, `senha`, `lotacao`) VALUES (3, 'Stacey Molina', 'Feminino', '1968-02-23', 'Rio de Janeiro', 'Rua Cabral', 'Caixa', 17764.10, '123321', 7820);
INSERT INTO `funcionario` (`matricula`, `nome`, `sexo`, `data_nasc`, `cidade`, `endereco`, `cargo`, `salario`, `senha`, `lotacao`) VALUES (4, 'Omar Vazquez', 'Masculino', '1977-05-12', 'Campo Grande', 'Rua Jardim Veneza', 'Atendente', 15724.09, '147258', 8714);
INSERT INTO `funcionario` (`matricula`, `nome`, `sexo`, `data_nasc`, `cidade`, `endereco`, `cargo`, `salario`, `senha`, `lotacao`) VALUES (5, 'Lila Morin', 'Feminino', '1992-09-18', 'Goiânia', 'Rua João Peixoto', 'Atendente', 10757.62, '159357', 7820);
INSERT INTO `funcionario` (`matricula`, `nome`, `sexo`, `data_nasc`, `cidade`, `endereco`, `cargo`, `salario`, `senha`, `lotacao`) VALUES (6, 'William Huff', 'Masculino', '1961-02-05', 'Hawkings', 'Rua Doze', 'Gerente', 20471.79, '456987', 7820);
INSERT INTO `funcionario` (`matricula`, `nome`, `sexo`, `data_nasc`, `cidade`, `endereco`, `cargo`, `salario`, `senha`, `lotacao`) VALUES (7, 'Aphrodite Gates', 'Feminino', '1995-04-18', 'Montes Claros', 'Rua Ribeiro Gomes', 'Atendente', 16937.60, '153759', 7379);
INSERT INTO `funcionario` (`matricula`, `nome`, `sexo`, `data_nasc`, `cidade`, `endereco`, `cargo`, `salario`, `senha`, `lotacao`) VALUES (8, 'Tatyana Giles', 'Feminino', '1978-08-30', 'Teresina', 'Rua Paulo', 'Caixa', 12824.07, '426871', 7379);
INSERT INTO `funcionario` (`matricula`, `nome`, `sexo`, `data_nasc`, `cidade`, `endereco`, `cargo`, `salario`, `senha`, `lotacao`) VALUES (9, 'Rafael Roman', 'Masculino', '1995-11-29', 'Icó', 'Avenida Rio', 'Gerente', 23246.57, '014789', 7379);
INSERT INTO `funcionario` (`matricula`, `nome`, `sexo`, `data_nasc`, `cidade`, `endereco`, `cargo`, `salario`, `senha`, `lotacao`) VALUES (10, 'Fleur Everett', 'Feminino', '1971-10-18', 'Vitória', 'Rua do Frade', 'Atendente', 15724.09, '555000', 6436);
INSERT INTO `funcionario` (`matricula`, `nome`, `sexo`, `data_nasc`, `cidade`, `endereco`, `cargo`, `salario`, `senha`, `lotacao`) VALUES (11, 'Maxwell Mullins', 'Masculino', '1993-05-07', 'Goiânia', 'Rua Projetada 3', 'Caixa', 12948.51, '044990', 6436);
INSERT INTO `funcionario` (`matricula`, `nome`, `sexo`, `data_nasc`, `cidade`, `endereco`, `cargo`, `salario`, `senha`, `lotacao`) VALUES (12, 'Isaac Hill', 'Masculino', '1966-06-20', 'Brasília', 'Rua Mogno', 'Atendente', 8832.93, '123589', 2921);
INSERT INTO `funcionario` (`matricula`, `nome`, `sexo`, `data_nasc`, `cidade`, `endereco`, `cargo`, `salario`, `senha`, `lotacao`) VALUES (13, 'Austin Rose', 'Feminino', '1983-04-17', 'Londres', 'Rua Norma', 'Gerente', 31685.58, '235711', 6436);
INSERT INTO `funcionario` (`matricula`, `nome`, `sexo`, `data_nasc`, `cidade`, `endereco`, `cargo`, `salario`, `senha`, `lotacao`) VALUES (14, 'Danielle Valencia', 'Feminino', '1991-11-22', 'Salvador', 'Avenida Principal', 'Caixa', 25848.08, '963012', 2921);
INSERT INTO `funcionario` (`matricula`, `nome`, `sexo`, `data_nasc`, `cidade`, `endereco`, `cargo`, `salario`, `senha`, `lotacao`) VALUES (15, 'Geoffrey Olsen', 'Masculino', '1988-11-23', 'Indiana', 'Avenida Ênio Fabene', 'Gerente', 25069.00, '714581', 2921);

COMMIT;


-- -----------------------------------------------------
-- Data for table `agencia`
-- -----------------------------------------------------
START TRANSACTION;
USE `Equipe374876`;
INSERT INTO `agencia` (`numero`, `nome`, `mat_gerente`, `salario_montante`, `cidade`) VALUES (8714, 'Sob8714', 1, 60129.17, 'Sobral');
INSERT INTO `agencia` (`numero`, `nome`, `mat_gerente`, `salario_montante`, `cidade`) VALUES (7820, 'Haw7820', 6, 48993.51, 'Hawkings');
INSERT INTO `agencia` (`numero`, `nome`, `mat_gerente`, `salario_montante`, `cidade`) VALUES (6436, 'Lon6436', 13, 60358.18, 'Londres');
INSERT INTO `agencia` (`numero`, `nome`, `mat_gerente`, `salario_montante`, `cidade`) VALUES (7379, 'Ico7379', 9, 53008.24, 'Icó');
INSERT INTO `agencia` (`numero`, `nome`, `mat_gerente`, `salario_montante`, `cidade`) VALUES (2921, 'Ind2921', 15, 59750.01, 'Indiana');

COMMIT;


-- -----------------------------------------------------
-- Data for table `conta`
-- -----------------------------------------------------
START TRANSACTION;
USE `Equipe374876`;
INSERT INTO `conta` (`num_conta`, `num_agencia`, `saldo`, `senha`, `tipo_conta`) VALUES (164711, 2921, 2134.07, 012345, 'Conta Corrente');
INSERT INTO `conta` (`num_conta`, `num_agencia`, `saldo`, `senha`, `tipo_conta`) VALUES (784581, 7820, 2977.87, 123456, 'Conta Corrente');
INSERT INTO `conta` (`num_conta`, `num_agencia`, `saldo`, `senha`, `tipo_conta`) VALUES (015040, 8714, 425.30, 123321, 'Conta Corrente');
INSERT INTO `conta` (`num_conta`, `num_agencia`, `saldo`, `senha`, `tipo_conta`) VALUES (965824, 7379, 8468.72, 112233, 'Conta Corrente');
INSERT INTO `conta` (`num_conta`, `num_agencia`, `saldo`, `senha`, `tipo_conta`) VALUES (365256, 2921, 6386.33, 456789, 'Conta Corrente');
INSERT INTO `conta` (`num_conta`, `num_agencia`, `saldo`, `senha`, `tipo_conta`) VALUES (463126, 7820, 4601.23, 001122, 'Conta Corrente');
INSERT INTO `conta` (`num_conta`, `num_agencia`, `saldo`, `senha`, `tipo_conta`) VALUES (812821, 6436, 5221.67, 987654, 'Conta Corrente');
INSERT INTO `conta` (`num_conta`, `num_agencia`, `saldo`, `senha`, `tipo_conta`) VALUES (026226, 8714, 6826.80, 998877, 'Conta Corrente');
INSERT INTO `conta` (`num_conta`, `num_agencia`, `saldo`, `senha`, `tipo_conta`) VALUES (954152, 6436, 7816.48, 445566, 'Conta Corrente');
INSERT INTO `conta` (`num_conta`, `num_agencia`, `saldo`, `senha`, `tipo_conta`) VALUES (602510, 7379, 3920.84, 654321, 'Conta Corrente');
INSERT INTO `conta` (`num_conta`, `num_agencia`, `saldo`, `senha`, `tipo_conta`) VALUES (784154, 2921, 8624.33, 893281, 'Conta Poupança');
INSERT INTO `conta` (`num_conta`, `num_agencia`, `saldo`, `senha`, `tipo_conta`) VALUES (910511, 8714, 7100.62, 722253, 'Conta Poupança');
INSERT INTO `conta` (`num_conta`, `num_agencia`, `saldo`, `senha`, `tipo_conta`) VALUES (285172, 2921, 3302.16, 275873, 'Conta Poupança');
INSERT INTO `conta` (`num_conta`, `num_agencia`, `saldo`, `senha`, `tipo_conta`) VALUES (613817, 7820, 7037.16, 804452, 'Conta Poupança');
INSERT INTO `conta` (`num_conta`, `num_agencia`, `saldo`, `senha`, `tipo_conta`) VALUES (372129, 7820, 8368.54, 291175, 'Conta Poupança');
INSERT INTO `conta` (`num_conta`, `num_agencia`, `saldo`, `senha`, `tipo_conta`) VALUES (874163, 6436, 6248.51, 949284, 'Conta Poupança');
INSERT INTO `conta` (`num_conta`, `num_agencia`, `saldo`, `senha`, `tipo_conta`) VALUES (804089, 7379, 6758.68, 805277, 'Conta Poupança');
INSERT INTO `conta` (`num_conta`, `num_agencia`, `saldo`, `senha`, `tipo_conta`) VALUES (834440, 7379, 267.64, 826706, 'Conta Poupança');
INSERT INTO `conta` (`num_conta`, `num_agencia`, `saldo`, `senha`, `tipo_conta`) VALUES (830557, 6436, 342.81, 809916, 'Conta Poupança');
INSERT INTO `conta` (`num_conta`, `num_agencia`, `saldo`, `senha`, `tipo_conta`) VALUES (986479, 6436, 4231.43, 170035, 'Conta Poupança');
INSERT INTO `conta` (`num_conta`, `num_agencia`, `saldo`, `senha`, `tipo_conta`) VALUES (513279, 8714, -272.79, 348536, 'Conta Especial');
INSERT INTO `conta` (`num_conta`, `num_agencia`, `saldo`, `senha`, `tipo_conta`) VALUES (678050, 2921, 4937.15, 787316, 'Conta Especial');
INSERT INTO `conta` (`num_conta`, `num_agencia`, `saldo`, `senha`, `tipo_conta`) VALUES (779511, 2921, -131.49, 603226, 'Conta Especial');
INSERT INTO `conta` (`num_conta`, `num_agencia`, `saldo`, `senha`, `tipo_conta`) VALUES (363829, 2921, 1017.73, 865224, 'Conta Especial');
INSERT INTO `conta` (`num_conta`, `num_agencia`, `saldo`, `senha`, `tipo_conta`) VALUES (885015, 2921, -69.45, 671054, 'Conta Especial');
INSERT INTO `conta` (`num_conta`, `num_agencia`, `saldo`, `senha`, `tipo_conta`) VALUES (750483, 6436, 871.20, 521938, 'Conta Especial');
INSERT INTO `conta` (`num_conta`, `num_agencia`, `saldo`, `senha`, `tipo_conta`) VALUES (348913, 8714, -447.22, 462981, 'Conta Especial');
INSERT INTO `conta` (`num_conta`, `num_agencia`, `saldo`, `senha`, `tipo_conta`) VALUES (885720, 7379, 9910.29, 679315, 'Conta Especial');
INSERT INTO `conta` (`num_conta`, `num_agencia`, `saldo`, `senha`, `tipo_conta`) VALUES (487652, 7820, -35.66, 440435, 'Conta Especial');
INSERT INTO `conta` (`num_conta`, `num_agencia`, `saldo`, `senha`, `tipo_conta`) VALUES (387029, 7820, 1419.11, 744929, 'Conta Especial');

COMMIT;


-- -----------------------------------------------------
-- Data for table `conta_poupanca`
-- -----------------------------------------------------
START TRANSACTION;
USE `Equipe374876`;
INSERT INTO `conta_poupanca` (`num_conta`, `taxa_juros`) VALUES (784154, 3.79);
INSERT INTO `conta_poupanca` (`num_conta`, `taxa_juros`) VALUES (910511, 2.19);
INSERT INTO `conta_poupanca` (`num_conta`, `taxa_juros`) VALUES (285172, 1.58);
INSERT INTO `conta_poupanca` (`num_conta`, `taxa_juros`) VALUES (613817, 3.46);
INSERT INTO `conta_poupanca` (`num_conta`, `taxa_juros`) VALUES (372129, 2.92);
INSERT INTO `conta_poupanca` (`num_conta`, `taxa_juros`) VALUES (874163, 0.84);
INSERT INTO `conta_poupanca` (`num_conta`, `taxa_juros`) VALUES (804089, 2.36);
INSERT INTO `conta_poupanca` (`num_conta`, `taxa_juros`) VALUES (834440, 3.76);
INSERT INTO `conta_poupanca` (`num_conta`, `taxa_juros`) VALUES (830557, 4.83);
INSERT INTO `conta_poupanca` (`num_conta`, `taxa_juros`) VALUES (986479, 0.85);

COMMIT;


-- -----------------------------------------------------
-- Data for table `conta_especial`
-- -----------------------------------------------------
START TRANSACTION;
USE `Equipe374876`;
INSERT INTO `conta_especial` (`num_conta`, `limite_credito`) VALUES (513279, 331);
INSERT INTO `conta_especial` (`num_conta`, `limite_credito`) VALUES (678050, 477);
INSERT INTO `conta_especial` (`num_conta`, `limite_credito`) VALUES (779511, 425);
INSERT INTO `conta_especial` (`num_conta`, `limite_credito`) VALUES (363829, 218);
INSERT INTO `conta_especial` (`num_conta`, `limite_credito`) VALUES (885015, 236);
INSERT INTO `conta_especial` (`num_conta`, `limite_credito`) VALUES (750483, 286);
INSERT INTO `conta_especial` (`num_conta`, `limite_credito`) VALUES (348913, 454);
INSERT INTO `conta_especial` (`num_conta`, `limite_credito`) VALUES (885720, 432);
INSERT INTO `conta_especial` (`num_conta`, `limite_credito`) VALUES (487652, 177);
INSERT INTO `conta_especial` (`num_conta`, `limite_credito`) VALUES (387029, 189);

COMMIT;


-- -----------------------------------------------------
-- Data for table `transacao`
-- -----------------------------------------------------
START TRANSACTION;
USE `Equipe374876`;
INSERT INTO `transacao` (`num_transacao`, `valor_transacao`, `data_hora`, `tipo`) VALUES (1, 2430.89, '2000-04-21 12:42:40', 'Estorno');
INSERT INTO `transacao` (`num_transacao`, `valor_transacao`, `data_hora`, `tipo`) VALUES (2, -944.64, '2000-09-24 12:34:21', 'Saque');
INSERT INTO `transacao` (`num_transacao`, `valor_transacao`, `data_hora`, `tipo`) VALUES (3, -2978.10, '2000-11-05 04:58:14', 'Transferência');
INSERT INTO `transacao` (`num_transacao`, `valor_transacao`, `data_hora`, `tipo`) VALUES (4, 2978.10, '2000-11-05 04:58:14', 'Transferência');
INSERT INTO `transacao` (`num_transacao`, `valor_transacao`, `data_hora`, `tipo`) VALUES (5, 1536.86, '2001-08-27 02:20:39', 'Depósito');
INSERT INTO `transacao` (`num_transacao`, `valor_transacao`, `data_hora`, `tipo`) VALUES (6, -4182.24, '2001-11-11 02:46:07', 'Saque');
INSERT INTO `transacao` (`num_transacao`, `valor_transacao`, `data_hora`, `tipo`) VALUES (7, 4044.63, '2002-02-24 06:15:42', 'Depósito');
INSERT INTO `transacao` (`num_transacao`, `valor_transacao`, `data_hora`, `tipo`) VALUES (8, -1509.83, '2002-08-19 15:33:26', 'Saque');
INSERT INTO `transacao` (`num_transacao`, `valor_transacao`, `data_hora`, `tipo`) VALUES (9, -331.63, '2003-03-09 17:59:54', 'Transferência');
INSERT INTO `transacao` (`num_transacao`, `valor_transacao`, `data_hora`, `tipo`) VALUES (10, 331.63, '2003-03-09 17:59:54', 'Transferência');
INSERT INTO `transacao` (`num_transacao`, `valor_transacao`, `data_hora`, `tipo`) VALUES (11, 1118.84, '2003-10-16 06:48:07', 'Estorno');
INSERT INTO `transacao` (`num_transacao`, `valor_transacao`, `data_hora`, `tipo`) VALUES (12, 3623.83, '2004-01-01 02:31:21', 'Depósito');
INSERT INTO `transacao` (`num_transacao`, `valor_transacao`, `data_hora`, `tipo`) VALUES (13, -2802.90, '2004-03-01 11:25:47', 'Transferência');
INSERT INTO `transacao` (`num_transacao`, `valor_transacao`, `data_hora`, `tipo`) VALUES (14, 2802.90, '2004-03-01 11:25:47', 'Transferência');
INSERT INTO `transacao` (`num_transacao`, `valor_transacao`, `data_hora`, `tipo`) VALUES (15, -333.92, '2005-03-11 11:09:28', 'Transferência');
INSERT INTO `transacao` (`num_transacao`, `valor_transacao`, `data_hora`, `tipo`) VALUES (16, 333.92, '2005-03-11 11:09:28', 'Transferência');
INSERT INTO `transacao` (`num_transacao`, `valor_transacao`, `data_hora`, `tipo`) VALUES (17, -2383.09, '2007-11-13 17:15:15', 'Saque');
INSERT INTO `transacao` (`num_transacao`, `valor_transacao`, `data_hora`, `tipo`) VALUES (18, 432.42, '2009-09-21 23:36:49', 'Depósito');
INSERT INTO `transacao` (`num_transacao`, `valor_transacao`, `data_hora`, `tipo`) VALUES (19, -1682.85, '2011-03-25 02:33:36', 'Saque');
INSERT INTO `transacao` (`num_transacao`, `valor_transacao`, `data_hora`, `tipo`) VALUES (20, 3495.94, '2012-05-18 21:11:11', 'Estorno');
INSERT INTO `transacao` (`num_transacao`, `valor_transacao`, `data_hora`, `tipo`) VALUES (21, 1522.92, '2013-12-17 05:36:54', 'Estorno');
INSERT INTO `transacao` (`num_transacao`, `valor_transacao`, `data_hora`, `tipo`) VALUES (22, -4003.64, '2015-09-02 09:28:27', 'Transferência');
INSERT INTO `transacao` (`num_transacao`, `valor_transacao`, `data_hora`, `tipo`) VALUES (23, 4003.64, '2015-09-02 09:28:27', 'Transferência');
INSERT INTO `transacao` (`num_transacao`, `valor_transacao`, `data_hora`, `tipo`) VALUES (24, -2163.08, '2017-10-25 01:27:48', 'Transferência');
INSERT INTO `transacao` (`num_transacao`, `valor_transacao`, `data_hora`, `tipo`) VALUES (25, 2163.08, '2017-10-25 01:27:48', 'Transferência');
INSERT INTO `transacao` (`num_transacao`, `valor_transacao`, `data_hora`, `tipo`) VALUES (26, 250.00, '2017-11-01 04:19:00', 'Depósito');
INSERT INTO `transacao` (`num_transacao`, `valor_transacao`, `data_hora`, `tipo`) VALUES (27, 235.62, '2017-11-07 10:15:24', 'Estorno');
INSERT INTO `transacao` (`num_transacao`, `valor_transacao`, `data_hora`, `tipo`) VALUES (28, -415.75, '2017-11-10 23:24:59', 'Saque');
INSERT INTO `transacao` (`num_transacao`, `valor_transacao`, `data_hora`, `tipo`) VALUES (29, 368.24, '2017-11-12 05:02:12', 'Depósito');
INSERT INTO `transacao` (`num_transacao`, `valor_transacao`, `data_hora`, `tipo`) VALUES (30, 953.25, '2017-11-15 21:51:42', 'Depósito');

COMMIT;


-- -----------------------------------------------------
-- Data for table `realiza`
-- -----------------------------------------------------
START TRANSACTION;
USE `Equipe374876`;
INSERT INTO `realiza` (`num_transacao`, `num_conta`) VALUES (1, 164711);
INSERT INTO `realiza` (`num_transacao`, `num_conta`) VALUES (2, 784581);
INSERT INTO `realiza` (`num_transacao`, `num_conta`) VALUES (3, 015040);
INSERT INTO `realiza` (`num_transacao`, `num_conta`) VALUES (4, 965824);
INSERT INTO `realiza` (`num_transacao`, `num_conta`) VALUES (5, 365256);
INSERT INTO `realiza` (`num_transacao`, `num_conta`) VALUES (6, 463126);
INSERT INTO `realiza` (`num_transacao`, `num_conta`) VALUES (7, 812821);
INSERT INTO `realiza` (`num_transacao`, `num_conta`) VALUES (8, 026226);
INSERT INTO `realiza` (`num_transacao`, `num_conta`) VALUES (9, 954152);
INSERT INTO `realiza` (`num_transacao`, `num_conta`) VALUES (10, 602510);
INSERT INTO `realiza` (`num_transacao`, `num_conta`) VALUES (11, 784154);
INSERT INTO `realiza` (`num_transacao`, `num_conta`) VALUES (12, 910511);
INSERT INTO `realiza` (`num_transacao`, `num_conta`) VALUES (13, 285172);
INSERT INTO `realiza` (`num_transacao`, `num_conta`) VALUES (14, 613817);
INSERT INTO `realiza` (`num_transacao`, `num_conta`) VALUES (15, 372129);
INSERT INTO `realiza` (`num_transacao`, `num_conta`) VALUES (16, 874163);
INSERT INTO `realiza` (`num_transacao`, `num_conta`) VALUES (17, 804089);
INSERT INTO `realiza` (`num_transacao`, `num_conta`) VALUES (18, 834440);
INSERT INTO `realiza` (`num_transacao`, `num_conta`) VALUES (19, 830557);
INSERT INTO `realiza` (`num_transacao`, `num_conta`) VALUES (20, 986479);
INSERT INTO `realiza` (`num_transacao`, `num_conta`) VALUES (21, 678050);
INSERT INTO `realiza` (`num_transacao`, `num_conta`) VALUES (22, 363829);
INSERT INTO `realiza` (`num_transacao`, `num_conta`) VALUES (23, 750483);
INSERT INTO `realiza` (`num_transacao`, `num_conta`) VALUES (24, 885720);
INSERT INTO `realiza` (`num_transacao`, `num_conta`) VALUES (25, 387029);
INSERT INTO `realiza` (`num_transacao`, `num_conta`) VALUES (26, 164711);
INSERT INTO `realiza` (`num_transacao`, `num_conta`) VALUES (27, 784581);
INSERT INTO `realiza` (`num_transacao`, `num_conta`) VALUES (28, 463126);
INSERT INTO `realiza` (`num_transacao`, `num_conta`) VALUES (29, 602510);
INSERT INTO `realiza` (`num_transacao`, `num_conta`) VALUES (30, 602510);

COMMIT;


-- -----------------------------------------------------
-- Data for table `cliente`
-- -----------------------------------------------------
START TRANSACTION;
USE `Equipe374876`;
INSERT INTO `cliente` (`cpf`, `rg`, `nome`, `data_nasc`, `cidade`) VALUES ('41587462518', '541284628-186484', 'Dustin Henderson', '1971-04-18', 'Hawkings');
INSERT INTO `cliente` (`cpf`, `rg`, `nome`, `data_nasc`, `cidade`) VALUES ('88544517866', '522492566-562452', 'Will Byers', '1971-08-28', 'Hawkings');
INSERT INTO `cliente` (`cpf`, `rg`, `nome`, `data_nasc`, `cidade`) VALUES ('59944568461', '795121463-284186', 'Mike Wheeler', '1971-12-01', 'Hawkings');
INSERT INTO `cliente` (`cpf`, `rg`, `nome`, `data_nasc`, `cidade`) VALUES ('58549135133', '784931658-194716', 'Frida Kahlo', '1945-11-03', 'Icó');
INSERT INTO `cliente` (`cpf`, `rg`, `nome`, `data_nasc`, `cidade`) VALUES ('19416568746', '116511188-516659', 'Margaret Hamilton', '1922-05-05', 'Indiana');
INSERT INTO `cliente` (`cpf`, `rg`, `nome`, `data_nasc`, `cidade`) VALUES ('84154951621', '162195165-156744', 'Brenda Chapman', '1959-08-26', 'Beason');
INSERT INTO `cliente` (`cpf`, `rg`, `nome`, `data_nasc`, `cidade`) VALUES ('47948651514', '847151635-845145', 'Irena Sendler', '1960-04-04', 'Londres');
INSERT INTO `cliente` (`cpf`, `rg`, `nome`, `data_nasc`, `cidade`) VALUES ('84984561515', '988787845-545447', 'Nelson Mandela', '1959-08-25', 'Icó');
INSERT INTO `cliente` (`cpf`, `rg`, `nome`, `data_nasc`, `cidade`) VALUES ('79488487552', '788484841-112224', 'Kelgilson Gomes', '1976-01-01', 'Icó');
INSERT INTO `cliente` (`cpf`, `rg`, `nome`, `data_nasc`, `cidade`) VALUES ('98963112021', '022132315-212121', 'Fred Mercury', '1965-02-23', 'Sobral');
INSERT INTO `cliente` (`cpf`, `rg`, `nome`, `data_nasc`, `cidade`) VALUES ('84484848484', '878451512-021661', 'Alan Turing', '1943-07-18', 'Indiana');
INSERT INTO `cliente` (`cpf`, `rg`, `nome`, `data_nasc`, `cidade`) VALUES ('56691223322', '987426124-517516', 'Gretchen Queen', '1996-09-21', 'Sobral');
INSERT INTO `cliente` (`cpf`, `rg`, `nome`, `data_nasc`, `cidade`) VALUES ('15975764216', '324164251-572726', 'Xuxa Meneguel', '1923-10-31', 'Meruoca');
INSERT INTO `cliente` (`cpf`, `rg`, `nome`, `data_nasc`, `cidade`) VALUES ('71279279197', '622167515-979159', 'Margareth Thacher', '1930-11-04', 'Londres');
INSERT INTO `cliente` (`cpf`, `rg`, `nome`, `data_nasc`, `cidade`) VALUES ('79497859457', '878795151-845153', 'Machado de Assis', '1919-05-05', 'Beason');
INSERT INTO `cliente` (`cpf`, `rg`, `nome`, `data_nasc`, `cidade`) VALUES ('76151230215', '034261597-177597', 'Clark Kent', '1987-12-26', 'Sobral');
INSERT INTO `cliente` (`cpf`, `rg`, `nome`, `data_nasc`, `cidade`) VALUES ('84415154845', '474164879-997499', 'Evaristo Costa', '1978-06-13', 'Meruoca');
INSERT INTO `cliente` (`cpf`, `rg`, `nome`, `data_nasc`, `cidade`) VALUES ('72975957917', '127915974-979459', 'Anne Hathway', '1987-03-28', 'Pereiro');
INSERT INTO `cliente` (`cpf`, `rg`, `nome`, `data_nasc`, `cidade`) VALUES ('97548749742', '416164126-597794', 'Theodoro Bertotti', '1963-05-08', 'Ouro Preto');
INSERT INTO `cliente` (`cpf`, `rg`, `nome`, `data_nasc`, `cidade`) VALUES ('32623126547', '619761674-527777', 'Beyonce  Knowles', '1959-08-25', 'Gramado');

COMMIT;


-- -----------------------------------------------------
-- Data for table `conta_cliente`
-- -----------------------------------------------------
START TRANSACTION;
USE `Equipe374876`;
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('41587462518', 164711, 2921);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('32623126547', 784581, 7820);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('32623126547', 015040, 8714);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('79497859457', 965824, 7379);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('88544517866', 365256, 2921);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('41587462518', 463126, 7820);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('79488487552', 812821, 6436);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('84484848484', 026226, 8714);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('98963112021', 954152, 6436);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('76151230215', 602510, 7379);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('59944568461', 784154, 2921);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('15975764216', 910511, 8714);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('58549135133', 285172, 2921);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('79488487552', 613817, 7820);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('79497859457', 372129, 7820);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('84484848484', 874163, 6436);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('84415154845', 804089, 7379);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('72975957917', 834440, 7379);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('56691223322', 830557, 6436);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('15975764216', 986479, 6436);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('84154951621', 513279, 8714);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('19416568746', 678050, 2921);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('84154951621', 779511, 2921);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('47948651514', 363829, 2921);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('84984561515', 885015, 2921);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('71279279197', 750483, 6436);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('71279279197', 348913, 8714);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('97548749742', 885720, 7379);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('84484848484', 487652, 7820);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('59944568461', 387029, 7820);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('79488487552', 365256, 2921);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('84984561515', 954152, 6436);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('84415154845', 613817, 7820);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('19416568746', 834440, 7379);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('15975764216', 779511, 2921);

COMMIT;


-- -----------------------------------------------------
-- Data for table `dependente`
-- -----------------------------------------------------
START TRANSACTION;
USE `Equipe374876`;
INSERT INTO `dependente` (`mat_funcionario`, `nome_dependente`, `parentesco`, `data_nasc`, `idade`) VALUES (2, 'Luiz Giovanni', 'Filho', '1995-06-14', 22);
INSERT INTO `dependente` (`mat_funcionario`, `nome_dependente`, `parentesco`, `data_nasc`, `idade`) VALUES (13, 'Alexandre Barros', 'Cônjuge', '1979-04-14', 38);
INSERT INTO `dependente` (`mat_funcionario`, `nome_dependente`, `parentesco`, `data_nasc`, `idade`) VALUES (3, 'Heitor Dias', 'Filho', '1993-09-11', 24);
INSERT INTO `dependente` (`mat_funcionario`, `nome_dependente`, `parentesco`, `data_nasc`, `idade`) VALUES (10, 'Sophia Moura', 'Filho', '1992-11-18', 24);
INSERT INTO `dependente` (`mat_funcionario`, `nome_dependente`, `parentesco`, `data_nasc`, `idade`) VALUES (10, 'Elisa Moura', 'Genitor', '1953-08-22', 64);
INSERT INTO `dependente` (`mat_funcionario`, `nome_dependente`, `parentesco`, `data_nasc`, `idade`) VALUES (8, 'Henry Campos', 'Genitor', '1947-08-19', 70);
INSERT INTO `dependente` (`mat_funcionario`, `nome_dependente`, `parentesco`, `data_nasc`, `idade`) VALUES (6, 'Gabrielly Hadassa', 'Cônjuge', '1966-03-01', 51);
INSERT INTO `dependente` (`mat_funcionario`, `nome_dependente`, `parentesco`, `data_nasc`, `idade`) VALUES (12, 'Agatha Gomes', 'Cônjuge', '1972-12-24', 44);
INSERT INTO `dependente` (`mat_funcionario`, `nome_dependente`, `parentesco`, `data_nasc`, `idade`) VALUES (8, 'Sophie Campos', 'Filho', '1999-04-24', 18);
INSERT INTO `dependente` (`mat_funcionario`, `nome_dependente`, `parentesco`, `data_nasc`, `idade`) VALUES (1, 'Bruno Cavalcanti', 'Filho', '1994-10-18', 23);
INSERT INTO `dependente` (`mat_funcionario`, `nome_dependente`, `parentesco`, `data_nasc`, `idade`) VALUES (10, 'Júlia Schiavon', 'Filho', '1995-10-21', 22);
INSERT INTO `dependente` (`mat_funcionario`, `nome_dependente`, `parentesco`, `data_nasc`, `idade`) VALUES (7, 'Evaristo Costa', 'Filho', '2016-10-28', 1);
INSERT INTO `dependente` (`mat_funcionario`, `nome_dependente`, `parentesco`, `data_nasc`, `idade`) VALUES (9, 'Jackson Chang', 'Genitor', '1968-01-29', 49);
INSERT INTO `dependente` (`mat_funcionario`, `nome_dependente`, `parentesco`, `data_nasc`, `idade`) VALUES (5, 'Ignacia Gilbert', 'Genitor', '1959-09-03', 58);
INSERT INTO `dependente` (`mat_funcionario`, `nome_dependente`, `parentesco`, `data_nasc`, `idade`) VALUES (1, 'Chancellor Hull', 'Cônjuge', '1968-05-22', 49);
INSERT INTO `dependente` (`mat_funcionario`, `nome_dependente`, `parentesco`, `data_nasc`, `idade`) VALUES (6, 'Britanney Michael', 'Genitor', '1938-10-23', 79);
INSERT INTO `dependente` (`mat_funcionario`, `nome_dependente`, `parentesco`, `data_nasc`, `idade`) VALUES (9, 'Kessie Byrd', 'Cônjuge', '1997-03-03', 20);
INSERT INTO `dependente` (`mat_funcionario`, `nome_dependente`, `parentesco`, `data_nasc`, `idade`) VALUES (7, 'Jena Mcfadden', 'Genitor', '1969-02-27', 48);
INSERT INTO `dependente` (`mat_funcionario`, `nome_dependente`, `parentesco`, `data_nasc`, `idade`) VALUES (7, 'Lawrence Jackson', 'Filho', '2017-11-07', 0);
INSERT INTO `dependente` (`mat_funcionario`, `nome_dependente`, `parentesco`, `data_nasc`, `idade`) VALUES (6, 'Olga Houston', 'Filho', '1991-06-22', 26);
INSERT INTO `dependente` (`mat_funcionario`, `nome_dependente`, `parentesco`, `data_nasc`, `idade`) VALUES (15, 'Imogene Parks', 'Genitor', '1956-08-29', 61);
INSERT INTO `dependente` (`mat_funcionario`, `nome_dependente`, `parentesco`, `data_nasc`, `idade`) VALUES (6, 'Olivia Collins', 'Filho', '1987-06-29', 30);
INSERT INTO `dependente` (`mat_funcionario`, `nome_dependente`, `parentesco`, `data_nasc`, `idade`) VALUES (1, 'Kaye Delaney', 'Filho', '1997-03-03', 20);
INSERT INTO `dependente` (`mat_funcionario`, `nome_dependente`, `parentesco`, `data_nasc`, `idade`) VALUES (9, 'Tasha Aguilar', 'Filho', '2017-10-29', 0);
INSERT INTO `dependente` (`mat_funcionario`, `nome_dependente`, `parentesco`, `data_nasc`, `idade`) VALUES (4, 'Gary Wooten', 'Genitor', '1998-05-07', 19);

COMMIT;


-- -----------------------------------------------------
-- Data for table `conta_corrente`
-- -----------------------------------------------------
START TRANSACTION;
USE `Equipe374876`;
INSERT INTO `conta_corrente` (`num_conta`) VALUES (164711);
INSERT INTO `conta_corrente` (`num_conta`) VALUES (784581);
INSERT INTO `conta_corrente` (`num_conta`) VALUES (015040);
INSERT INTO `conta_corrente` (`num_conta`) VALUES (965824);
INSERT INTO `conta_corrente` (`num_conta`) VALUES (365256);
INSERT INTO `conta_corrente` (`num_conta`) VALUES (463126);
INSERT INTO `conta_corrente` (`num_conta`) VALUES (812821);
INSERT INTO `conta_corrente` (`num_conta`) VALUES (026226);
INSERT INTO `conta_corrente` (`num_conta`) VALUES (954152);
INSERT INTO `conta_corrente` (`num_conta`) VALUES (602510);

COMMIT;