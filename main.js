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
        autoHideMenuBar: true
    });

    // Inicia a aplicação com a tela de conexão ao banco de dados
    mainWindow.loadURL(url.format({
        pathname: 'html/conectarBD.html',
        protocol: 'file:',
        slashes: true
    }));

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
            connection.query(`SELECT matricula, senha, cargo
                FROM funcionario;`, function (error, results, fields) {
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

    // Limpa a variável quando a tela é fechada
    mainWindow.on('closed', function () {
        mainWindow = null;
    });
});