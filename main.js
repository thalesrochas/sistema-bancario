const electron = require('electron');
const mysql = require('mysql');
const url = require('url');

const app = electron.app;
const BrowserWindow = electron.BrowserWindow;
const ipcMain = electron.ipcMain;
const dialog = electron.dialog;

let mainWindow;
let connection;

app.on('ready', function () {
    mainWindow = new BrowserWindow({});

    mainWindow.loadURL(url.format({
        pathname: 'html/conectarBD.html',
        protocol: 'file:',
        slashes: true
    }));

    // Evento executa quando o usuário tenta iniciar conexão com o Banco de Dados
    ipcMain.on('conectarBD', function (event, conexao) {
        console.log('Dados de conexão coletados:');
        console.log(conexao);

        // Iniciando conexão com o Banco de Dados
        connection = mysql.createConnection(conexao);

        // Verifica se a conexão foi bem sucedida
        connection.connect(function (err) {
            if (err) {
                console.error('Erro na conexão: ', err.stack);
                // Alert box com erro de conexão
                dialog.showErrorBox('Erro de Conexão',
                    'Erro ao conectar com o Banco de Dados.\nVerifique os campos e tente novamente.');
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

    mainWindow.on('closed', function () {
        mainWindow = null;
    });
});