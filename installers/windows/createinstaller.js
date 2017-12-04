const createWindowsInstaller = require('electron-winstaller').createWindowsInstaller;
const path = require('path');

getInstallerConfig().then(createWindowsInstaller).catch((error) => {
    console.error(error.message || error);
    process.exit(1);
});

function getInstallerConfig() {
    console.log('creating windows installer');
    const rootPath = path.join('./');
    const outPath = path.join(rootPath, 'release-builds');

    return Promise.resolve({
        appDirectory: path.join(outPath, 'nullbank-win32-ia32/'),
        authors: 'Francisco Thales, Maria Raquel, Francisco Mauro',
        noMsi: true,
        outputDirectory: path.join(outPath, 'windows-installer'),
        exe: 'nullbank.exe',
        setupExe: 'NullBank-374876.exe',
        setupIcon: path.join(rootPath, 'img', 'icon.ico')
    });
}