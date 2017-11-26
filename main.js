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

    // Limpa a variável quando a tela é fechada
    mainWindow.on('closed', function () {
        mainWindow = null;
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
        // Informe com messageBox
        dialog.showMessageBox({
            type: 'none',
            title: 'Login feito por DBA',
            message: 'Login feito por DBA',
            detail: 'Acesso total aos dados.'
        });
        // Se for, carrega tela de DBA
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
    
    mainWindow.loadURL(url.format({
        pathname: 'html/' + arg + '.html',
        protocol: 'file:',
        slashes: true
    }));
});

ipcMain.on('requestData', function (event, arg) {
    switch (arg) {
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

ipcMain.on('requestFields', function (event, arg) {
    connection.query('SELECT * FROM ' + arg.tabela + ' WHERE ' + arg.campo + ' = ?;', arg.id,
    function (error, results, fields) {
        console.log(results);
        // Envia os campos solicitados para o html que solicitou
        mainWindow.webContents.send('fieldsRequested', results);
        console.log('Campos da tabela ' + arg.tabela + ' enviados.');
    });
});

ipcMain.on('delete', function (event, arg) {
    connection.query('DELETE FROM ' + arg.tabela + ' WHERE ' + arg.campo + ' = ?;', arg.id,
    function (error, results, fields) {
        if (error) {
            dialog.showMessageBox({
                type: 'error',
                title: 'Erro ao Remover Agência',
                message: 'A Agência ' + arg.id + ' não pode ser removida!',
                detail: 'Podem haver funcionários lotados nessa agência.'
            });
            console.log('A Agência ' + arg.id + ' não pode ser removida!');
        }
        else {
            dialog.showMessageBox({
                type: 'info',
                title: 'Remoção Confirmada',
                message: 'A Agência ' + arg.id + ' foi removida com sucesso!'
            });
            mainWindow.webContents.reload();
            console.log('Campo da tabela ' + arg.tabela + ', id: ' + arg.id +  ', deletado.');
        }
    });
});

ipcMain.on('abrirTela', function (event,arg){
    // Criação de nova tela com algumas configurações
    let newWindow = new BrowserWindow({
        resizable: false,
        maximizable: false,
        autoHideMenuBar: true,
        width: 800,
        height: 665
    });
    
    // Inicia a aplicação com a tela de conexão ao banco de dados
    newWindow.loadURL(url.format({
        pathname: 'html/' + arg + '.html',
        protocol: 'file:',
        slashes: true
    }));
});