const electron = require('electron');
const mysql = require('mysql');
const url = require('url');
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
        pathname: 'html/conectarBD.html',
        protocol: 'file:',
        slashes: true
    }));

    // Encerra a aplicação quando a tela principal é fechada
    mainWindow.on('closed', function () {
        app.exit();
    });
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
            dialog.showMessageBox({
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
                pathname: 'html/mainWindow.html',
                protocol: 'file:',
                slashes: true
            }));
        }
    });
});

// Evento executa quando o botão 'Acessar!' é clicado na mainWindow.html
ipcMain.on('acessar', function (event, arg) {
    console.log(arg);
    // Carrega a tela de login
    mainWindow.loadURL(url.format({
        pathname: 'html/telaLogin.html',
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
        dialog.showMessageBox({
            type: 'none',
            title: 'Login feito por DBA',
            message: 'Login feito por DBA',
            detail: 'Acesso total aos dados.'
        });
        // Se for DBA, carrega tela de DBA
        mainWindow.loadURL(url.format({
            pathname: 'html/agenciaDBA.html',
            protocol: 'file:',
            slashes: true
        }));
    }
    else { // Executa uma query para buscar os dados de matricula e senha no banco
        connection.query('SELECT matricula, senha, cargo FROM funcionario;',
        function (error, results, fields) {
            // Se houver alguma tupla correspondente no banco
            if (results.some(element => element.matricula == loginData.matricula &&
            element.senha == loginData.senha)) {
                // TODO Abrir tela de usuário correspondente
                dialog.showMessageBox({
                    type: 'none',
                    message: 'Abrir nova tela',
                    detail: 'Abrir uma nova tela de acordo com o cargo do funcionário.'
                });
            }
            else {
                // Exibe mensagem de erro de login, caso todos os testes falhem
                dialog.showMessageBox({
                    type: 'warning',
                    title: 'Erro de Login',
                    message: 'Erro de Login',
                    detail: 'Matrícula ou senha inválida!'
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
        pathname: 'html/' + arg + '.html',
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

        default:
            evento = 'fieldsRequested';
        }
        mainWindow.webContents.send(evento, results);
        console.log('Campos da tabela ' + arg.tabela + ' enviados.');
    });
});

// Evento é chamado quando é solicitada a deleção de uma tupla de uma tabela
ipcMain.on('delete', function (event, arg) {
    // Tenta realizar a deleção
    connection.query('DELETE FROM ' + arg.tabela + ' WHERE ' + arg.campo + ' = ?;', arg.id,
    function (error, results, fields) {
        if (error) {
            // Exibe caixa de mensagem caso tenha ocorrido erro na deleção
            dialog.showMessageBox({
                type: 'error',
                title: 'Erro ao Remover ' + arg.nome_tabela,
                message: arg.nome_tabela + ' ' + arg.nome + ' não pode ser removido!',
                detail: arg.detail
            });
            console.log(arg.nome_tabela + ' ' + arg.nome + ' não pode ser removido!');
        }
        else {
            // Caso tenha sido removido com sucesso, informa ao usuário
            dialog.showMessageBox({
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

ipcMain.on('deleteDependente', function (event, arg) {
    // Tenta realizar a deleção
    connection.query('DELETE FROM dependente WHERE mat_funcionario = ? and nome_dependente = ?', arg,
    function (error, results, fields) {
        if (error) {
            // Exibe caixa de mensagem caso tenha ocorrido erro na deleção
            dialog.showMessageBox({
                type: 'error',
                title: 'Erro ao Remover ' + arg[1],
                message: 'O dependente ' + arg[1] + ' não pode ser removido!'
            });
            console.log('O dependente ' + arg[1] + ' não pode ser removido!');
        }
        else {
            // Caso tenha sido removido com sucesso, informa ao usuário
            dialog.showMessageBox({
                type: 'info',
                title: 'Remoção Confirmada',
                message: 'O dependente ' + arg[1] + ' foi removido com sucesso!'
            });
            // Atualiza os dados da página após a remoção
            mainWindow.webContents.reload();
            console.log('O dependente ' + arg[1] + ' foi removido com sucesso!');
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
    
    // Carrega a tela correspondente
    newWindow.loadURL(url.format({
        pathname: 'html/' + arg.tela + '.html',
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

    newWindow.on('closed', function () {
        mainWindow.webContents.reload();
    });
});

ipcMain.on('requestAgencias', function (event, arg) {
    connection.query('SELECT numero FROM agencia;',
    function (error, results, fields) {
        console.log(results);
        console.log('Enviando dados de Agência...');
        newWindow.webContents.on('did-finish-load', () => {
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
    }
});

ipcMain.on('insertCliente', function (event, arg) {
    console.log(arg);
    connection.query('INSERT INTO cliente VALUES (?, ?, ?, ?, ?, ?);', arg,
    function (error, results, fields) {
        event.sender.send('clienteInserido', error);
    });
});

ipcMain.on('insertConta', function (event, arg) {
    console.log(arg);
    connection.query('INSERT INTO conta VALUES (?, ?, ?, ?, ?);', arg.slice(0,5),
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

ipcMain.on('insertContaCliente', function (event, arg) {
    console.log(arg);
    connection.query('INSERT INTO conta_cliente VALUES (?, ?, ?)', arg,
    function (error, results, fields) {
        event.sender.send('contaClienteInserido', error);
    });
});

ipcMain.on('insertDependente', function (event, arg) {
    console.log(arg);
    connection.query(`INSERT INTO dependente VALUES (?, ?, ?, ?, YEAR(FROM_DAYS(TO_DAYS(CURDATE()) - TO_DAYS(?))));`, arg,
    function (error, results, fields) {
        event.sender.send('dependenteInserido', error);
    });
});