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
INSERT INTO `conta` (`num_conta`, `num_agencia`, `saldo`, `senha`) VALUES (164711, 2921, 2134.07, 012345);
INSERT INTO `conta` (`num_conta`, `num_agencia`, `saldo`, `senha`) VALUES (784581, 7820, 2977.87, 123456);
INSERT INTO `conta` (`num_conta`, `num_agencia`, `saldo`, `senha`) VALUES (015040, 8714, 425.30, 123321);
INSERT INTO `conta` (`num_conta`, `num_agencia`, `saldo`, `senha`) VALUES (965824, 7379, 8468.72, 112233);
INSERT INTO `conta` (`num_conta`, `num_agencia`, `saldo`, `senha`) VALUES (365256, 2921, 6386.33, 456789);
INSERT INTO `conta` (`num_conta`, `num_agencia`, `saldo`, `senha`) VALUES (463126, 7820, 4601.23, 001122);
INSERT INTO `conta` (`num_conta`, `num_agencia`, `saldo`, `senha`) VALUES (812821, 6436, 5221.67, 987654);
INSERT INTO `conta` (`num_conta`, `num_agencia`, `saldo`, `senha`) VALUES (026226, 8714, 6826.80, 998877);
INSERT INTO `conta` (`num_conta`, `num_agencia`, `saldo`, `senha`) VALUES (954152, 6436, 7816.48, 445566);
INSERT INTO `conta` (`num_conta`, `num_agencia`, `saldo`, `senha`) VALUES (602510, 7379, 3920.84, 654321);

COMMIT;


-- -----------------------------------------------------
-- Data for table `conta_poupanca`
-- -----------------------------------------------------
START TRANSACTION;
USE `Equipe374876`;
INSERT INTO `conta_poupanca` (`num_conta`, `taxa_juros`) VALUES (365256, 1.03);
INSERT INTO `conta_poupanca` (`num_conta`, `taxa_juros`) VALUES (463126, 3.50);
INSERT INTO `conta_poupanca` (`num_conta`, `taxa_juros`) VALUES (812821, 2.73);

COMMIT;


-- -----------------------------------------------------
-- Data for table `conta_especial`
-- -----------------------------------------------------
START TRANSACTION;
USE `Equipe374876`;
INSERT INTO `conta_especial` (`num_conta`, `limite_credito`) VALUES (026226, 300.00);
INSERT INTO `conta_especial` (`num_conta`, `limite_credito`) VALUES (954152, 250.00);
INSERT INTO `conta_especial` (`num_conta`, `limite_credito`) VALUES (602510, 275.00);

COMMIT;


-- -----------------------------------------------------
-- Data for table `transacao`
-- -----------------------------------------------------
START TRANSACTION;
USE `Equipe374876`;
INSERT INTO `transacao` (`num_transacao`, `valor_transacao`, `data_hora`, `tipo`) VALUES (1, 500.00, '2015-12-02 18:03:20', 'Transferência');
INSERT INTO `transacao` (`num_transacao`, `valor_transacao`, `data_hora`, `tipo`) VALUES (2, 1200.00, '2016-03-22 07:09:36', 'Depósito');
INSERT INTO `transacao` (`num_transacao`, `valor_transacao`, `data_hora`, `tipo`) VALUES (3, 1785.25, '2016-09-04 16:57:45', 'Saque');
INSERT INTO `transacao` (`num_transacao`, `valor_transacao`, `data_hora`, `tipo`) VALUES (4, 55.00, '2017-04-30 14:30:13', 'Estorno');
INSERT INTO `transacao` (`num_transacao`, `valor_transacao`, `data_hora`, `tipo`) VALUES (5, 2456.35, '2017-05-24 11:15:17', 'Saque');

COMMIT;


-- -----------------------------------------------------
-- Data for table `realiza`
-- -----------------------------------------------------
START TRANSACTION;
USE `Equipe374876`;
INSERT INTO `realiza` (`num_transacao`, `num_conta`) VALUES (1, 015040);
INSERT INTO `realiza` (`num_transacao`, `num_conta`) VALUES (2, 812821);
INSERT INTO `realiza` (`num_transacao`, `num_conta`) VALUES (3, 602510);
INSERT INTO `realiza` (`num_transacao`, `num_conta`) VALUES (4, 965824);
INSERT INTO `realiza` (`num_transacao`, `num_conta`) VALUES (5, 164711);

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
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('41587462518', 164711, 7820);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('88544517866', 784581, 7820);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('59944568461', 015040, 7820);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('58549135133', 965824, 7379);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('19416568746', 365256, 2921);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('84154951621', 463126, 6436);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('47948651514', 812821, 6436);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('84984561515', 026226, 7379);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('79488487552', 954152, 7379);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('98963112021', 602510, 8714);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('84484848484', 965824, 7379);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('84415154845', 784581, 7820);
INSERT INTO `conta_cliente` (`cpf_cliente`, `num_conta`, `num_agencia`) VALUES ('72975957917', 812821, 6436);

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

COMMIT;