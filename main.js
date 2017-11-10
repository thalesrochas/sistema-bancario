const electron = require('electron');
const mysql = require('mysql');
const url = require('url');

const app = electron.app;
const BrowserWindow = electron.BrowserWindow;
const ipcMain = electron.ipcMain;

let mainWindow;

app.on('ready', function () {
    mainWindow = new BrowserWindow({});

    mainWindow.loadURL(url.format({
        pathname: 'html/mainWindow.html',
        protocol: 'file:',
        slashes: true
    }));

    mainWindow.on('closed', function () {
        mainWindow = null;
    });
});