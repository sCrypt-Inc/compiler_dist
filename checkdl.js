const { spawn, spawnSync } = require('child_process');
const { join } = require('path');
const { platform } = require('os');
const { exit } = require('process');

let FILENAME = "./scryptc/win32/scryptc.exe"

if (platform() === 'linux') {
    FILENAME = "./scryptc/linux/scryptc"
} else if (platform() === 'darwin') {
    FILENAME = "./scryptc/mac/scryptc"
}

const output = spawnSync(join(__dirname, FILENAME), ['version']).stdout.toString();

const content = require("fs").readFileSync("./tag.json");

const version = JSON.parse(content).tag_name.toString().substr(1);

console.log('version', version, 'output', output)


if(version.indexOf("beta") > -1) {
    console.warn('beta version skip check')
    exit(0)
}
if(output.indexOf(version) < 0){
    console.error('version check fail')
    exit(-1)
}
    