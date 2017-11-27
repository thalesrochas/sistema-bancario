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
        mainWindow.webContents.send('fieldsRequested', results);
        console.log('Campos da tabela ' + arg.tabela + ' enviados.');
    });
});

/* Evento ocorre quando o usuário clida em uma linha da tabela
 * para consultar todos os elementos de uma tupla da tabela.
 */
ipcMain.on('requestContaDoCliente', function (event, arg) {
    connection.query('SELECT * FROM ' + arg.tabela + ' WHERE ' + arg.campo + ' = ?;', arg.id,
    function (error, results, fields) {
        console.log(results);
        // Envia os campos solicitados para o html que solicitou
        mainWindow.webContents.send('requestedContaDoCliente', results);
        console.log('Campos da tabela ' + arg.tabela + ' enviados.');
    });
});

/* Evento ocorre quando o usuário clida em uma linha da tabela
 * para consultar todos os elementos de uma tupla da tabela.
 */
ipcMain.on('requestTransacaoDoCliente', function (event, arg) {
    connection.query('SELECT * FROM ' + arg.tabela + ' WHERE ' + arg.campo + ' = ?;', arg.id,
    function (error, results, fields) {
        console.log(results);
        // Envia os campos solicitados para o html que solicitou
        mainWindow.webContents.send('requestedTransacaoDoCliente', results);
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
        connection.query('SELECT MAX(' + arg.campo + ') AS max FROM ' + arg.tabela + ';',
        function(error, results, fields) {
            console.log('Maior número de ' + arg.tabela + ': ' + results[0].max);
            newWindow.webContents.send('max', results[0].max);
        });
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
    connection.query('INSERT INTO cliente VALUES (?, ?, ?, ?, ?, ?)', arg,
    function (error, results, fields) {
        event.sender.send('clienteInserido', error);
    });
});

ipcMain.on('insertConta', function (event, arg) {
    console.log(arg);
    connection.query('INSERT INTO conta VALUES (?, ?, ?, ?, ?)', arg.slice(0,5),
    function (error, results, fields) {
        event.sender.send('contaInserida', error);
    });
});