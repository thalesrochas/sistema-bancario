const electron = require('electron');
const mysql = require('mysql');
const url = require('url');
const path = require('path');
const objectCompare = require('object-compare');

const app = electron.app;
const BrowserWindow = electron.BrowserWindow;
const ipcMain = electron.ipcMain;
const dialog = electron.dialog;

// Credenciais do DBA
const DBA = {matricula: 'dba', senha: 'dba'};

let mainWindow;
let newWindow;
let connection;

app.on('ready', function () {
    // Criação de nova tela com algumas configurações
    mainWindow = new BrowserWindow({
        resizable: false,
        maximizable: false,
        autoHideMenuBar: true,
        width: 1280,
        height: 761
    });
    
    // Inicia a aplicação com a tela de conexão ao banco de dados
    mainWindow.loadURL(url.format({
        pathname: path.join(__dirname, 'html/conectarBD.html'),
        protocol: 'file:',
        slashes: true
    }));

    // Encerra a aplicação quando a tela principal é fechada
    mainWindow.on('closed', function () {
        app.exit();
    });

    //mainWindow.openDevTools({detach: true});
    mainWindow.setMenu(null);
});

// Evento executa quando o usuário tenta iniciar conexão com o Banco de Dados
ipcMain.on('conectarBD', function (event, conexaoData) {
    console.log('Dados de conexão coletados:');
    console.log(conexaoData);
    
    // Iniciando conexão com o Banco de Dados
    connection = mysql.createConnection(conexaoData);
    
    // Verifica se a conexão foi bem sucedida
    connection.connect(function (err) {
        if (err) {
            console.error('Erro na conexão: ', err.stack);
            // Alert box com erro de conexão
            dialog.showMessageBox(mainWindow, {
                type: 'error',
                title: 'Erro de Conexão',
                message: 'Erro de Conexão',
                detail: 'Erro ao conectar com o Banco de Dados.\nVerifique os campos e tente novamente.'
            });
        }
        else {
            console.log('Conexão bem sucedida!\nConection ID: ' + connection.threadId);
            // Após a conexão bem sucedida, abrir tela de login do usuário
            mainWindow.loadURL(url.format({
                pathname: path.join(__dirname, 'html/mainWindow.html'),
                protocol: 'file:',
                slashes: true
            }));

            // Cria variável para descriptografia
            connection.query(`SELECT @chave:='374876';`, function(err, res, fiel){});
        }
    });
});

// Evento executa quando o botão 'Acessar!' é clicado na mainWindow.html
ipcMain.on('acessar', function (event, arg) {
    console.log(arg);
    // Carrega a tela de login
    mainWindow.loadURL(url.format({
        pathname: path.join(__dirname, 'html/telaLogin.html'),
        protocol: 'file:',
        slashes: true
    }));
});

// Evento executa quando usuário solicita login em telaLogin.html
ipcMain.on('userLogin', function (event, loginData) {
    console.log('Dados de login coletados:');
    console.log(loginData);
    
    // Testa se os dados correspondem a um DBA
    if (objectCompare(loginData, DBA)) {
        console.log('Login como DBA...');
        // Informe de usuário DBA
        dialog.showMessageBox(mainWindow, {
            type: 'none',
            title: 'Login feito por DBA',
            message: 'Login feito por DBA',
            detail: 'Acesso total aos dados.'
        });
        // Se for DBA, carrega tela de DBA
        mainWindow.loadURL(url.format({
            pathname: path.join(__dirname, 'html/agenciaDBA.html'),
            protocol: 'file:',
            slashes: true
        }));
    }
    else { // Executa uma query para buscar os dados de matricula e senha no banco
        connection.query('SELECT cargo, lotacao FROM funcionario WHERE matricula = ? AND AES_DECRYPT(senha, @chave) = ?;',
        [loginData.matricula, loginData.senha],
        function (error, results, fields) {
            console.log(results);

            if (results.length === 0) {
                // Exibe mensagem de erro de login, caso todos os testes falhem
                console.log('Erro no Login');
                dialog.showMessageBox(mainWindow, {
                    type: 'warning',
                    title: 'Erro de Login',
                    message: 'Erro de Login',
                    detail: 'Matrícula ou senha inválida!'
                });
            }
            // Procura qual o tipo de funcionário que logou no sistema e redireciona para sua determinada visão
            else {
                switch (results[0].cargo) {
                    case 'Gerente':
                        console.log('Gerente');
                        mainWindow.loadURL(url.format({
                            pathname: path.join(__dirname, 'html/funcionarioGerente.html'),
                            protocol: 'file:',
                            slashes: true
                        }));
                        break;
                    case 'Atendente':
                        console.log('Atendente');
                        mainWindow.loadURL(url.format({
                            pathname: path.join(__dirname, 'html/clienteAtendente.html'),
                            protocol: 'file:',
                            slashes: true
                        }));
                        break;
                    case 'Caixa':
                        console.log('Caixa');
                        mainWindow.loadURL(url.format({
                            pathname: path.join(__dirname, 'html/contaCaixa.html'),
                            protocol: 'file:',
                            slashes: true
                        }));
                        break;
                }
                mainWindow.webContents.on('did-finish-load', () => {
                    mainWindow.webContents.send('agencia', results[0].lotacao);
                });
            }
        });
    }
});

// Evento executa quando usuário navega entre as páginas do DBA
ipcMain.on('trocarTelaDBA', function (event, arg) {
    console.log('Trocar Tela\nDados coletados:');
    console.log(arg);
    
    // Seleciona qual tela deve-se carregar a partir do 'arg'
    mainWindow.loadURL(url.format({
        pathname: path.join(__dirname, 'html/' + arg + '.html'),
        protocol: 'file:',
        slashes: true
    }));
});

/* Evento ocorre quando a tela correspondente solicita os dados a serem
 * impressos na tabela.
 */
ipcMain.on('requestData', function (event, arg) {
    switch (arg) {
        // Seleciona os dados de todas as agências
        case 'agencia':
            connection.query('SELECT numero, nome, cidade FROM agencia;',
            function (error, results, fields) {
                console.log(results);
                console.log('Enviando dados de Agência...');
                mainWindow.webContents.on('did-finish-load', () => {
                    mainWindow.webContents.send('dataAgencia', results);
                });
                console.log('Dados enviados!');
            });
            break;

        // Seleciona os dados de todos os funcionários
        case 'funcionario':
            connection.query('SELECT matricula, nome, cargo FROM funcionario;',
            function (error, results, fields) {
                console.log(results);
                console.log('Enviando dados de Funcionário...');
                mainWindow.webContents.on('did-finish-load', () => {
                    mainWindow.webContents.send('dataFuncionario', results);
                });
                console.log('Dados enviados!');
            });
            break;

        // Seleciona os dados de todos os clientes
        case 'cliente':
            connection.query('SELECT cpf, nome, cidade FROM cliente;',
            function (error, results, fields) {
                console.log(results);
                console.log('Enviando dados de Cliente...');
                mainWindow.webContents.on('did-finish-load', () => {
                    mainWindow.webContents.send('dataCliente', results);
                });
                console.log('Dados enviados!');
            });
            break;

        // Seleciona os dados de todas as contas
        case 'conta':
            connection.query(`SELECT num_conta as numero,
            num_agencia as agencia, tipo_conta as tipo FROM conta;`,
            function (error, results, fields) {
                console.log(results);
                console.log('Enviando dados de Conta...');
                mainWindow.webContents.on('did-finish-load', () => {
                    mainWindow.webContents.send('dataConta', results);
                });
                console.log('Dados enviados!');
            });
            break;

        // Seleciona os dados de todas as cidades
        case 'cidade':
            connection.query(`SELECT cidade FROM funcionario UNION select CIDADE FROM cliente;`,
            function (error, results, fields) {
                console.log(results);
                console.log('Enviando dados de Cidade...');
                mainWindow.webContents.on('did-finish-load', () => {
                    mainWindow.webContents.send('dataCidade', results);
                });
                console.log('Dados enviados!');
            });
    }
});

// Requisito dos dados para a visão dos funcinoários dependendo da agência de cada um deles
ipcMain.on('requestDataRestrict', function (event, arg) {
    switch (arg.tabela) {
        // Seleciona os dados de todos os funcionários da agência
        case 'funcionario':
            connection.query('SELECT matricula, nome, cargo FROM funcionario WHERE lotacao = ?;', [arg.agencia],
            function (error, results, fields) {
                console.log(results);
                console.log('Enviando dados restritos de Funcionário...');
                mainWindow.webContents.send('dataFuncionario', results);
                console.log('Dados enviados!');
            });
            break;

        // Seleciona os dados de todos os clientes da agência
        case 'cliente':
            connection.query(`SELECT c.cpf, c.nome, c.cidade
            FROM cliente c JOIN conta_cliente cc ON c.cpf = cc.cpf_cliente
            WHERE num_agencia = ?;`, [arg.agencia],
            function (error, results, fields) {
                console.log(results);
                console.log('Enviando dados restritos de Cliente...');
                mainWindow.webContents.send('dataCliente', results);
                console.log('Dados enviados!');
            });
            break;

        // Seleciona os dados de todas as contas da agência
        case 'conta':
            connection.query(`SELECT num_conta as numero,
            num_agencia as agencia, tipo_conta as tipo FROM conta WHERE num_agencia = ?;`, [arg.agencia],
            function (error, results, fields) {
                console.log(results);
                console.log('Enviando dados restritos de Conta...');
                mainWindow.webContents.send('dataConta', results);
                console.log('Dados enviados!');
            });
            break;
    }
});

/* Evento ocorre quando o usuário clida em uma linha da tabela
 * para consultar todos os elementos de uma tupla da tabela.
 */
ipcMain.on('requestFields', function (event, arg) {
    connection.query('SELECT * FROM ' + arg.tabela + ' WHERE ' + arg.campo + ' = ?;', arg.id,
    function (error, results, fields) {
        console.log(results);
        // Envia os campos solicitados para o html que solicitou
        let evento;
        switch(arg.tabela) {
            case 'conta_do_cliente':
                evento = 'requestedContaDoCliente';
                break;

            case 'transacao_do_cliente':
                evento = 'requestedTransacaoDoCliente';
                break;

            case 'dependente':
                evento = 'requestedDependente';
                break;

            case 'contas_gerente':
                evento = 'requestedContasGerente';
                break;

            default:
                evento = 'fieldsRequested';
        }
        mainWindow.webContents.send(evento, results);
        console.log('Campos da tabela ' + arg.tabela + ' enviados.');
    });
});

// Requisita as senhas para serem exibidas, descriptografando-as
ipcMain.on('requestSenha', function (event, arg) {
    connection.query(`SELECT AES_DECRYPT(senha, @chave) AS senha
    FROM ${arg.tabela} WHERE ${arg.campo} = ?;`, arg.id,
    function (error, results, fields) {
        console.log(results);
        event.sender.send('senhaRequested', results);
    });
    console.log('Senha enviada!');
});

// Evento é chamado quando é solicitada a deleção de uma tupla de uma tabela
ipcMain.on('delete', function (event, arg) {
    // Tenta realizar a deleção
    connection.query('DELETE FROM ' + arg.tabela + ' WHERE ' + arg.campo + ' = ?;', arg.id,
    function (error, results, fields) {
        if (error) {
            // Exibe caixa de mensagem caso tenha ocorrido erro na deleção
            dialog.showMessageBox(mainWindow, {
                type: 'error',
                title: 'Erro ao Remover ' + arg.nome_tabela,
                message: arg.nome_tabela + ' ' + arg.nome + ' não pode ser removido!',
                detail: arg.detail
            });
            console.log(arg.nome_tabela + ' ' + arg.nome + ' não pode ser removido!');
        }
        else {
            // Caso tenha sido removido com sucesso, informa ao usuário
            dialog.showMessageBox(mainWindow, {
                type: 'info',
                title: 'Remoção Confirmada',
                message: arg.nome_tabela + ' ' + arg.nome + ' foi removido com sucesso!'
            });
            // Atualiza os dados da página após a remoção
            mainWindow.webContents.reload();
            console.log('Campo da tabela ' + arg.tabela + ', id: ' + arg.id +  ', deletado.');
        }
    });
});

// Evento de remoção de dependentes
ipcMain.on('deleteDependente', function (event, arg) {
    // Tenta realizar a deleção
    connection.query('DELETE FROM dependente WHERE mat_funcionario = ? and nome_dependente = ?', arg,
    function (error, results, fields) {
        if (error) {
            // Exibe caixa de mensagem caso tenha ocorrido erro na deleção
            dialog.showMessageBox(mainWindow, {
                type: 'error',
                title: 'Erro ao Remover ' + arg[1],
                message: 'O dependente ' + arg[1] + ' não pode ser removido!'
            });
            console.log('O dependente ' + arg[1] + ' não pode ser removido!');
        }
        else {
            // Caso tenha sido removido com sucesso, informa ao usuário
            dialog.showMessageBox(mainWindow, {
                type: 'info',
                title: 'Remoção Confirmada',
                message: 'O dependente ' + arg[1] + ' foi removido com sucesso!'
            });
            // Atualiza os dados da página após a remoção
            mainWindow.send('dependenteRemovido', '');
            console.log('O dependente ' + arg[1] + ' foi removido com sucesso!');
        }
    });
});

// Evento de desligamento do cliente da sua conta
ipcMain.on('deleteClienteDaConta', function (event, arg) {
    connection.query('DELETE FROM conta_cliente WHERE num_conta = ? AND cpf_cliente = ?;', arg,
    function (error, results, fields) {
        if (error) {
            // Exibe caixa de mensagem caso tenha ocorrido erro na deleção
            dialog.showMessageBox(mainWindow, {
                type: 'error',
                title: 'Erro ao Desvincular ' + arg[1],
                message: 'O Cliente ' + arg[1] + ' não pode ser desvinculado!'
            });
            console.log('O cliente ' + arg[1] + ' não pode ser desvinculado!');
        }
        else {
            // Caso tenha sido removido com sucesso, informa ao usuário
            dialog.showMessageBox(mainWindow, {
                type: 'info',
                title: 'Desvínculo Confirmado',
                message: 'O cliente ' + arg[1] + ' foi desvinculado com sucesso!'
            });
            // Atualiza os dados da página após a remoção
            mainWindow.send('clienteDaContaRemovido', '');
            console.log('O cliente ' + arg[1] + ' foi desvinculado com sucesso!');
        }
    });
});

// Evento ocorre quando usuário solicita a inserção de tuplas em alguma tabela
ipcMain.on('abrirTela', function (event, arg){
    // Criação de nova tela com algumas configurações
    newWindow = new BrowserWindow({
        parent: mainWindow,
        modal: true,
        resizable: false,
        maximizable: false,
        autoHideMenuBar: true,
        width: 800,
        height: 665
    });

    newWindow.setMenu(null);
    
    // Carrega a tela correspondente
    newWindow.loadURL(url.format({
        pathname: path.join(__dirname, 'html/' + arg.tela + '.html'),
        protocol: 'file:',
        slashes: true
    }));

    // Envia para a tela o maior ID da tabela associada
    newWindow.webContents.on('did-finish-load', () => {
        switch (arg.tipo) {
            case 'insert':
                connection.query('SELECT MAX(' + arg.args.campo + ') AS max FROM ' + arg.args.tabela + ';',
                function (error, results, fields) {
                    console.log('Maior número de ' + arg.args.tabela + ': ' + results[0].max);
                    newWindow.webContents.send('max', results[0].max);
                });
                break;

            case 'associar':
                connection.query('SELECT * FROM ' + arg.args.tabela +
                ' WHERE ' + arg.args.campo + ' = ?;', arg.args.id,
                function (error, results, fields) {
                    if (arg.args.trans) {
                        connection.query('SELECT MAX(num_transacao) AS max FROM transacao;',
                        function (error, maxTransacao, fields) {
                            console.log(maxTransacao['0'].max);
                            newWindow.webContents.send('campos', [results, maxTransacao['0'].max]);
                        });
                    }
                    else {
                        console.log(results);
                        newWindow.webContents.send('campos', results);
                    }
                });
        }
    });

    // Recarrega os dados da janela principal após uma inserção/atualização
    newWindow.on('closed', function () {
        mainWindow.webContents.reload();
    });
});

// Evento para capturar todos os números de agência
ipcMain.on('requestAgencias', function (event, arg) {
    connection.query('SELECT numero FROM agencia;',
    function (error, results, fields) {
        console.log(results);
        console.log('Enviando dados de Agência...');
        newWindow.webContents.on('did-finish-load', () => {
            // Os números de agência são enviados para a tela que solicitou
            newWindow.webContents.send('dataAgencia', results);
        });
        console.log('Dados enviados!');
    });
});

// Evento é chamado quando o usuário solicitar pesquisa em uma tela
ipcMain.on('pesquisar', function (event, arg) {
    switch (arg.tabela) {
        // Seleciona os dados de todas as agências
        case 'agencia':
            connection.query(`SELECT numero, nome, cidade FROM agencia
            WHERE numero LIKE ? OR nome LIKE ? OR cidade LIKE ?;`,
            ['%' + arg.txt + '%', '%' + arg.txt + '%', '%' + arg.txt + '%'],
            function (error, results, fields) {
                console.log(results);
                console.log('Enviando dados de Agência...');
                mainWindow.webContents.send('dataAgencia', results);
                console.log('Dados enviados!');
            });
            break;

        // Seleciona os dados de todos os funcionários
        case 'funcionario':
            connection.query(`SELECT matricula, nome, cargo FROM funcionario
            WHERE matricula LIKE ? OR nome LIKE ? OR cargo LIKE ?;`,
            ['%' + arg.txt + '%', '%' + arg.txt + '%', '%' + arg.txt + '%'],
            function (error, results, fields) {
                console.log(results);
                console.log('Enviando dados de Funcionário...');
                mainWindow.webContents.send('dataFuncionario', results);
                console.log('Dados enviados!');
            });
            break;

        // Seleciona os dados de todos os clientes
        case 'cliente':
            connection.query(`SELECT cpf, nome, cidade FROM cliente
            WHERE cpf LIKE ? OR nome LIKE ? OR cidade LIKE ?;`,
            ['%' + arg.txt + '%', '%' + arg.txt + '%', '%' + arg.txt + '%'],
            function (error, results, fields) {
                console.log(results);
                console.log('Enviando dados de Cliente...');
                mainWindow.webContents.send('dataCliente', results);
                console.log('Dados enviados!');
            });
            break;

        // Seleciona os dados de todas as contas
        case 'conta':
            connection.query(`SELECT num_conta as numero,
            num_agencia as agencia, tipo_conta as tipo FROM conta
            WHERE num_conta LIKE ? OR num_agencia LIKE ? OR tipo_conta LIKE ?;`,
            ['%' + arg.txt + '%', '%' + arg.txt + '%', '%' + arg.txt + '%'],
            function (error, results, fields) {
                console.log(results);
                console.log('Enviando dados de Conta...');
                mainWindow.webContents.send('dataConta', results);
                console.log('Dados enviados!');
            });
            break;

        // Seleciona os dados de todas as cidades
        case 'cidade':
            connection.query(`SELECT cidade FROM funcionario WHERE cidade LIKE ?
            UNION
            SELECT cidade FROM cliente WHERE cidade LIKE ?;`, ['%' + arg.txt + '%', '%' + arg.txt + '%'],
            function (error, results, fields) {
                console.log(results);
                console.log('Enviando dados de Cidade...');
                mainWindow.webContents.send('dataCidade', results);
                console.log('Dados enviados!');
            });
    }
});

// Evento de pesquisa para as visões dos funcionários
// Funciona de acordo com a agência que está acessando
ipcMain.on('pesquisaRestrita', function (event, arg) {
    switch (arg.tabela) {
        // Seleciona os dados de todos os funcionários
        case 'funcionario':
            connection.query(`SELECT matricula, nome, cargo FROM funcionario
            WHERE (matricula LIKE ? OR nome LIKE ? OR cargo LIKE ?) AND lotacao = ?;`,
            ['%' + arg.txt + '%', '%' + arg.txt + '%', '%' + arg.txt + '%', arg.agencia],
            function (error, results, fields) {
                console.log(results);
                console.log('Enviando dados restritos de Funcionário...');
                mainWindow.webContents.send('dataFuncionario', results);
                console.log('Dados enviados!');
            });
            break;

        // Seleciona os dados de todos os clientes
        case 'cliente':
            connection.query(`SELECT cpf, nome, cidade FROM cliente c JOIN conta_cliente cc ON c.cpf = cc.cpf_cliente
            WHERE (c.cpf LIKE ? OR c.nome LIKE ? OR c.cidade LIKE ?) AND cc.num_agencia = ?;`,
            ['%' + arg.txt + '%', '%' + arg.txt + '%', '%' + arg.txt + '%', arg.agencia],
            function (error, results, fields) {
                console.log(results);
                console.log('Enviando dados restritos de Cliente...');
                mainWindow.webContents.send('dataCliente', results);
                console.log('Dados enviados!');
            });
            break;

        // Seleciona os dados de todas as contas
        case 'conta':
            connection.query(`SELECT num_conta as numero,
            num_agencia as agencia, tipo_conta as tipo FROM conta
            WHERE (num_conta LIKE ? OR num_agencia LIKE ? OR tipo_conta LIKE ?) AND num_agencia = ?;`,
            ['%' + arg.txt + '%', '%' + arg.txt + '%', '%' + arg.txt + '%', arg.agencia],
            function (error, results, fields) {
                console.log(results);
                console.log('Enviando dados de Conta...');
                mainWindow.webContents.send('dataConta', results);
                console.log('Dados enviados!');
            });
            break;
    }
});

// Evento para inserção de clientes na tabela cliente
ipcMain.on('insertCliente', function (event, arg) {
    console.log(arg);
    connection.query('INSERT INTO cliente VALUES (?, ?, ?, ?, ?, ?);', arg,
    function (error, results, fields) {
        event.sender.send('clienteInserido', error);
    });
});

// Evento para inserção de contas na tabela conta, assim como nas tabelas de especialização
ipcMain.on('insertConta', function (event, arg) {
    console.log(arg);
    connection.query('INSERT INTO conta VALUES (?, ?, ?, AES_ENCRYPT(?, @chave), ?);', arg.slice(0,5),
    function (error, results, fields) {
        event.sender.send('contaInserida', error);
    });

    switch(arg[4]) { // Tipo de Conta
        case 'Conta Corrente':
            connection.query('INSERT INTO conta_corrente VALUES (?);', arg[0],
            function (error, results, fields) {});
            break;
        
        case 'Conta Poupança':
            connection.query('INSERT INTO conta_poupanca VALUES (?, ?);', [arg[0], arg[6]],
            function (error, results, fields) {});
            break;

        case 'Conta Especial':
            connection.query('INSERT INTO conta_especial VALUES (?, ?);', [arg[0], arg[5]],
            function (error, results, fields) {});
            break;
    }
});

// Evento para associar uma conta a um cliente
ipcMain.on('insertContaCliente', function (event, arg) {
    console.log(arg);
    connection.query('INSERT INTO conta_cliente VALUES (?, ?, ?)', arg,
    function (error, results, fields) {
        event.sender.send('contaClienteInserido', error);
    });
});

// Evento para a inserção de funcionários na tabela funcionário
ipcMain.on('insertFuncionario', function (event, arg) {
    console.log(arg);

    // Verifica se o novo funcionário é um Gerente
    if (arg[6] == 'Gerente') {
        // Verifica se a agência já possui um gerente
        connection.query('SELECT mat_gerente FROM agencia WHERE numero = ?;', [arg[9]],
        function (error1, results, fields) {
            console.log(results[0].mat_gerente);
            // Ocorre um erro se a agência já tiver um gerente
            if (!(results[0].mat_gerente == null)) {
                dialog.showMessageBox(newWindow, {
                    type: 'error',
                    title: 'Erro ao Cadastrar Funcionário',
                    message: 'Erro ao Cadastrar Funcionário!',
                    detail: 'Esta Agência já possui um Gerente!'
                });
            }
            // Se não houver gerente, insira o gerente em funcionario e associe na tabela agência
            else {
                connection.query(`INSERT INTO funcionario VALUES (?, ?, ?, ?, ?, ?, ?, ?, AES_ENCRYPT(?, @chave), ?);`, arg,
                function (error2, results, fields) {
                    if (error2 == null) {
                        connection.query(`UPDATE agencia SET mat_gerente = ? WHERE numero = ?`, [arg[0], arg[9]],
                        function (error3, results, fields) {
                            event.sender.send('funcionarioInserido', error3);
                        });
                    }
                    else {
                        event.sender.send('funcionarioInserido', error2);
                    }
                });
            }
        });
    }
    // Se o funcionário não for gerente, insira na tabela funcionario
    else {
        connection.query(`INSERT INTO funcionario VALUES (?, ?, ?, ?, ?, ?, ?, ?, AES_ENCRYPT(?, @chave), ?);`, arg,
        function (error4, results, fields) {
            event.sender.send('funcionarioInserido', error4);
        });
    }
});

// Evento para inserção de dependentes na tabela dependente
ipcMain.on('insertDependente', function (event, arg) {
    console.log(arg);
    connection.query(`INSERT INTO dependente VALUES (?, ?, ?, ?,
        YEAR(FROM_DAYS(TO_DAYS(CURDATE()) - TO_DAYS(?))));`, arg,
    function (error, results, fields) {
        event.sender.send('dependenteInserido', error);
    });
});

// Evento para realizar nova transação
// Insere dados na tabela transacao e realiza
ipcMain.on('novaTransacao', function (event, arg) {
    console.log(arg);

    switch (arg[2]) {
        case 'Transferência':
            connection.beginTransaction(function (err) {
                connection.query(`INSERT INTO transacao VALUES (?, ?, NOW(), ?), (?, ?, NOW(), ?);`,
                [arg[0], -arg[1], arg[2], Number(arg[0])+1, arg[1], arg[2]], function (err, res, fiel) {});

                connection.query(`INSERT INTO realiza VALUES (?, ?), (?, ?);`,
                [arg[0], arg[3], Number(arg[0])+1, arg[4]],
                function (error, results, fields) {
                    console.log(error);
                    // ER_NO_REFERENCED_ROW_2 - conta não existe
                    // ER_SIGNAL_EXCEPTION -- Saldo insuficiente
                    if (error !== null) {
                        if (error.code == 'ER_SIGNAL_EXCEPTION') {
                            dialog.showMessageBox(mainWindow, {
                                type: 'error',
                                title: 'Transação mal Sucedida',
                                message: 'Transferência não Realizada!',
                                detail: 'Saldo do cliente insuficiente.'
                            });
                            // Se der erro, desfaça as isnerções das tabelas
                            return connection.rollback(function () {});
                        }
                        else {
                            dialog.showMessageBox(mainWindow, {
                                type: 'error',
                                title: 'Transação mal Sucedida',
                                message: 'Transferência não Realizada!',
                                detail: 'A conta beneficiária ' + arg[4] + ' não existe.'
                            });
                            // Se der erro, desfaça as isnerções das tabelas
                            return connection.rollback(function () {});
                        }
                    }
                    // Se não houver erros, confirme a inclusão dos dados
                    connection.commit(function (err) {
                        if (err) {
                            // Se der erro, desfaça as isnerções das tabelas
                            return connection.rollback(function () {});
                        }
                        dialog.showMessageBox(mainWindow, {
                            type: 'info',
                            title: 'Transação bem Sucedida',
                            message: 'Transferência realizada com sucesso!',
                            detail: 'Os saldos dos clientes foram atualizados.'
                        });
                    });
                });
            });
            newWindow.close();
            break;

        case 'Saque':
            connection.beginTransaction(function (err) {
                connection.query(`INSERT INTO transacao VALUES (?, ?, NOW(), ?);`,
                [arg[0], -arg[1], arg[2]], function (err, res, fiel) {});
    
                connection.query(`INSERT INTO realiza VALUES (?, ?);`,
                [arg[0], arg[3]],
                function (error, results, fields) {
                    if (error) {
                        dialog.showMessageBox(mainWindow, {
                            type: 'error',
                            title: 'Transação mal Sucedida',
                            message: 'Saque Indisponível!',
                            detail: 'Saldo do cliente insuficiente.'
                        });
                        // Se der erro, desfaça as isnerções das tabelas
                        return connection.rollback(function () {});
                    }
                    // Se não houver erros, confirme a inclusão dos dados
                    connection.commit(function(error) {
                        if (error) {
                            // Se der erro, desfaça as isnerções das tabelas
                            return connection.rollback(function () {});
                        }
                        dialog.showMessageBox(mainWindow, {
                            type: 'info',
                            title: 'Transação bem Sucedida',
                            message: 'Saque realizado com sucesso!',
                            detail: 'O saldo do cliente foi atualizado.'
                        });
                    });
                });
            });
            newWindow.close();
            break;

        case 'Depósito':
            connection.beginTransaction(function (err) {
                connection.query(`INSERT INTO transacao VALUES (?, ?, NOW(), ?);`,
                [arg[0], arg[1], arg[2]], function (err, res, fiel) {});
                
                connection.query(`INSERT INTO realiza VALUES (?, ?);`,
                [arg[0], arg[3]],
                function (error, results, fields) {
                    if (error) {
                        dialog.showMessageBox(mainWindow, {
                            type: 'error',
                            title: 'Transação mal Sucedida',
                            message: 'Depósito Indisponível!'
                        });
                        // Se der erro, desfaça as isnerções das tabelas
                        return connection.rollback(function () {});
                    }
                    // Se não houver erros, confirme a inclusão dos dados
                    connection.commit(function (error) {
                        if (error) {
                            // Se der erro, desfaça as isnerções das tabelas
                            return connection.rollback(function () {});
                        }
                        dialog.showMessageBox(mainWindow, {
                            type: 'info',
                            title: 'Transação bem Sucedida',
                            message: 'Depósito realizado com sucesso!',
                            detail: 'O saldo do cliente foi atualizado.'
                        });
                    });
                });
            });
            newWindow.close();
            break;

        case 'Estorno':
            connection.beginTransaction(function (err) {
                connection.query(`INSERT INTO transacao VALUES (?, ?, NOW(), ?);`,
                [arg[0], arg[1], arg[2]], function (err, res, fiel) {});
                
                connection.query(`INSERT INTO realiza VALUES (?, ?);`,
                [arg[0], arg[3]],
                function (error, results, fields) {
                    if (error) {
                        dialog.showMessageBox(mainWindow, {
                            type: 'error',
                            title: 'Transação mal Sucedida',
                            message: 'Estorno Indisponível!'
                        });
                        // Se der erro, desfaça as isnerções das tabelas
                        return connection.rollback(function () {});
                    }
                    // Se não houver erros, confirme a inclusão dos dados
                    connection.commit(function (error) {
                        if (error) {
                            // Se der erro, desfaça as isnerções das tabelas
                            return connection.rollback(function () {});
                        }
                        dialog.showMessageBox(mainWindow, {
                            type: 'info',
                            title: 'Transação bem Sucedida',
                            message: 'Cliente Estornado!',
                            detail: 'O saldo do cliente foi atualizado.'
                        }); 
                    });
                });
            });
            newWindow.close();
            break;
    }
});

// Evento atualiza os dados das contas
ipcMain.on('updateConta', function (event, arg) {
    console.log(arg);
    connection.query('UPDATE conta SET saldo = ?, senha = AES_ENCRYPT(?, @chave), tipo_conta = ? WHERE num_conta = ?',
    [arg[2], arg[3], arg[4], arg[0]],
    function (error, results, fields) {
        connection.query('DELETE FROM conta_corrente WHERE num_conta = ?', arg[0],
        function (error, results, fields) {});
        connection.query('DELETE FROM conta_poupanca WHERE num_conta = ?', arg[0],
        function (error, results, fields) {});
        connection.query('DELETE FROM conta_especial WHERE num_conta = ?', arg[0],
        function (error, results, fields) {});

        switch(arg[4]) { // Tipo de Conta
            case 'Conta Corrente':
                connection.query('INSERT INTO conta_corrente VALUES (?);', arg[0],
                function (error, results, fields) {});
                break;
            
            case 'Conta Poupança':
                connection.query('INSERT INTO conta_poupanca VALUES (?, ?);', [arg[0], arg[6]],
                function (error, results, fields) {});
                break;
        
            case 'Conta Especial':
                connection.query('INSERT INTO conta_especial VALUES (?, ?);', [arg[0], arg[5]],
                function (error, results, fields) {});
                break;
        }

        event.sender.send('contaUpdated', error);
    });
});

// Evento atualiza os dados dos clientes
ipcMain.on('updateCliente', function (event, arg) {
    console.log(arg);
    connection.query(`UPDATE cliente SET rg = ?, nome = ?,
    data_nasc = ?, cidade = ?, endereco = ? WHERE cpf = ?`,
    [arg[1], arg[2], arg[3], arg[4], arg[5], arg[0]],
    function (error, results, fields) {
        // Informa para a janela que o cliente foi atualizado
        event.sender.send('clienteUpdated', error);
    });
});

// Evento atualiza os dados dos funcionários
ipcMain.on('updateFuncionario', function (event, arg) {
    console.log(arg);
    connection.query(`UPDATE funcionario SET nome = ?, sexo = ?,
    data_nasc = ?, cidade = ?, endereco = ?, salario = ?, senha = AES_ENCRYPT(?, @chave) WHERE matricula = ?`,
    [arg[1], arg[2], arg[3], arg[4], arg[5], arg[7], arg[8], arg[0]],
    function (error, results, fields) {
        // Informa para a janela que o funcionário foi atualizado
        event.sender.send('funcionarioUpdated', error);
    });
});

// Evento realiza e envia as querys paras as janelas que solicitaram
// As querys estão comentadas no arquivo 'ScriptQuerys.sql'
ipcMain.on('requestQuery', function (event, arg) {
    console.log(arg);
    switch (arg.query) {
        case '1.1':
            connection.query(`
            SELECT 
                f.nome, f.cargo, f.endereco, f.cidade, f.salario, nd.num_dependente
            FROM
                ((SELECT 
                    f.nome, COUNT(d.mat_funcionario) AS num_dependente
                FROM
                    funcionario f
                LEFT OUTER JOIN dependente d ON d.mat_funcionario = f.matricula
                GROUP BY f.nome) nd
                JOIN funcionario f ON f.nome = nd.nome)
                    JOIN
                agencia a ON f.lotacao = a.numero
            WHERE
                a.numero = ${arg.id}
            ORDER BY ${arg.order};`,
            function (error, results, fields) {
                console.log([results, arg.order]);
                console.log('Enviando dados q1.1...');
                mainWindow.webContents.send('q1.1', [results, arg.order]);
            });
            break;
        
        case '1.2':
            connection.query(`
            SELECT 
                cli.nome AS nome_cliente, tipo_conta
            FROM
                ((cliente cli
                JOIN conta_cliente cc ON cli.cpf = cc.cpf_cliente)
                JOIN agencia a ON a.numero = cc.num_agencia)
                    JOIN
                conta con ON con.num_conta = cc.num_conta
            WHERE
                a.numero = ${arg.id}
            order by tipo_conta, cli.nome;`,
            function (error, results, fields) {
                console.log(results);
                console.log('Enviando dados q1.2...');
                mainWindow.webContents.send('q1.2', results);
            });
            break;

        case '1.3':
            connection.query(`
            SELECT 
                ca.num_conta, ca.saldo
            FROM
                (SELECT 
                    *
                FROM
                    agencia a
                JOIN conta c ON c.num_agencia = a.numero
                WHERE
                    a.numero = ${arg.id}) ca
            WHERE
                ca.saldo < 0 AND ca.tipo_conta = 'Conta Especial'
            ORDER BY ca.saldo;`,
            function (error, results, fields) {
                console.log(results);
                console.log('Enviando dados q1.3...');
                mainWindow.webContents.send('q1.3', results);
            });
            break;

        case '1.4':
            connection.query(`
            SELECT 
                ca.num_conta, ca.saldo
            FROM
                (SELECT 
                    *
                FROM
                    agencia a
                JOIN conta c ON c.num_agencia = a.numero
                WHERE
                    a.numero = ${arg.id}) ca
            WHERE
                ca.tipo_conta = 'Conta Poupança'
            ORDER BY ca.saldo DESC;`,
            function (error, results, fields) {
                console.log(results);
                console.log('Enviando dados q1.4...');
                mainWindow.webContents.send('q1.4', results);
            });
            break;

        case '1.5':
            connection.query(`
            SELECT 
                c.num_conta, COUNT(*) AS num_transacoes
            FROM
                ((conta c
                JOIN realiza r ON c.num_conta = r.num_conta)
                JOIN transacao t ON t.num_transacao = r.num_transacao)
            WHERE
                c.tipo_conta = 'Conta Corrente'
                    AND c.num_agencia = ${arg.id}
                    AND (TO_DAYS(NOW()) - TO_DAYS(t.data_hora)) <= ${arg.order}
            GROUP BY c.num_conta;`,
            function (error, results, fields) {
                console.log(results);
                console.log('Enviando dados q1.5...');
                mainWindow.webContents.send('q1.5', results);
            });
            break;

        case '1.6':
            connection.query(`
            SELECT
                c.num_conta, SUM(ABS(t.valor_transacao)) AS valor_total
            FROM
                ((conta c
                JOIN realiza r ON c.num_conta = r.num_conta)
                JOIN transacao t ON t.num_transacao = r.num_transacao)
            WHERE
                c.num_agencia = ${arg.id}
                    AND (TO_DAYS(NOW()) - TO_DAYS(t.data_hora)) <= ${arg.order}
            GROUP BY c.num_conta
            ORDER BY valor_total DESC;`,
            function (error, results, fields) {
                console.log(results);
                console.log('Enviando dados q1.6...');
                mainWindow.webContents.send('q1.6', results);
            });
            break;
            
        case '2.1':
            connection.query(`
            SELECT cli.nome AS cliente, cc.num_conta, c.tipo_conta, a.nome AS agencia, f.nome AS gerente, c.saldo
            FROM
                (((cliente cli
                JOIN conta_cliente cc ON cli.cpf = cc.cpf_cliente)
                JOIN conta c ON c.num_conta = cc.num_conta)
                JOIN agencia a ON a.numero = cc.num_agencia)
                    JOIN
                funcionario f ON f.matricula = a.mat_gerente
            WHERE
                cpf = ${arg.id};`,
            function (error, results, fields) {
                console.log(results);
                console.log('Enviando dados q2.1...');
                mainWindow.webContents.send('q2.1', results);
            });
            break;

        case '2.2':
            connection.query(`
            SELECT 
                cli.nome AS cliente, cli.cpf AS cpf
            FROM
                cliente cli
                JOIN conta_cliente cc ON cli.cpf = cc.cpf_cliente
            WHERE
                cpf <> ${arg.id}
                AND num_conta = SOME (SELECT 
                    num_conta
                FROM
                    conta_cliente
                    WHERE
                        cpf_cliente = ${arg.id});`,
            function (error, results, fields) {
                console.log(results);
                console.log('Enviando dados q2.2...');
                mainWindow.webContents.send('q2.2', results);
            });
            break;

        case '2.3':
            connection.query(`
            SELECT 
                cc.num_conta, COUNT(t.num_transacao) AS num_transacoes
            FROM
                (((conta_cliente cc
                JOIN conta c ON cc.num_conta = c.num_conta)
                LEFT OUTER JOIN realiza r ON c.num_conta = r.num_conta)
                LEFT OUTER JOIN transacao t ON r.num_transacao = t.num_transacao)
            WHERE
                cc.cpf_cliente = ${arg.id}
                    AND c.tipo_conta = 'Conta Corrente'
                    AND (TO_DAYS(NOW()) - TO_DAYS(t.data_hora)) <= ${arg.order}
            GROUP BY cc.num_conta
            ORDER BY num_transacoes DESC;`,
            function (error, results, fields) {
                console.log(results);
                console.log('Enviando dados q2.3...');
                mainWindow.webContents.send('q2.3', results);
            });
            break;

        case '2.4':
            connection.query(`
            SELECT 
                cc.num_conta, SUM(ABS(t.valor_transacao)) AS valor_total
            FROM
                (((conta_cliente cc
                JOIN conta c ON cc.num_conta = c.num_conta)
                JOIN realiza r ON c.num_conta = r.num_conta)
                JOIN transacao t ON r.num_transacao = t.num_transacao)
            WHERE -- Pesquisa por CPF do cliente
                cc.cpf_cliente = ${arg.id}
                    AND (TO_DAYS(NOW()) - TO_DAYS(t.data_hora)) <= ${arg.order}
            GROUP BY cc.num_conta
            ORDER BY valor_total DESC;`,
            function (error, results, fields) {
                console.log(results);
                console.log('Enviando dados q2.4..');
                mainWindow.webContents.send('q2.4', results);
            });
            break;

        case '3.1':
            connection.query(`
            SELECT
                nome,
                endereco,
                YEAR(FROM_DAYS(TO_DAYS(CURDATE()) - TO_DAYS(data_nasc))) AS idade
            FROM
                cliente
            WHERE
                cidade = ?
            ORDER BY idade, nome;`, arg.id,
            function (error, results, fields) {
                console.log(results);
                console.log('Enviando dados q3.1..');
                mainWindow.webContents.send('q3.1', results);
            });
            break;

        case '3.2':
            connection.query(`
            SELECT
                a.nome AS nome_agencia,
                f.nome AS nome_funcionario,
                f.endereco,
                f.cargo,
                f.salario
            FROM 
                funcionario f 
                JOIN agencia a ON f.lotacao = a.numero
            WHERE
                a.cidade = ?
            ORDER BY
                a.nome, f.cargo, f.salario;`, arg.id,
            function (error, results, fields) {
                console.log(results);
                console.log('Enviando dados q3.2..');
                mainWindow.webContents.send('q3.2', results);
            });
            break;

        case '3.3':
            connection.query(`
            SELECT 
                nome,
                salario_montante
            FROM 
                agencia 
            WHERE
                cidade = ?
            ORDER BY 
                salario_montante;`, arg.id,
            function (error, results, fields) {
                console.log(results);
                console.log('Enviando dados q3.3..');
                mainWindow.webContents.send('q3.3', results);
            });
            break;
    }
});

// Evento envia os dados de extrato para a tela que solicitou
ipcMain.on('requestExtrato', function (event, arg) {
    console.log(arg);
    connection.query(`SELECT * FROM ${arg.tabela} WHERE num_conta = ?`, [arg.id],
    function (error, results, fields) {
        mainWindow.webContents.send('requestedTransacaoDoCliente', results);
    });
});