


const content = require("fs").readFileSync("./tag.json");

const tagInfo = JSON.parse(content);

if(!Array.isArray(tagInfo["assets"])) {
    console.log("no_assets")
    process.exit(0);
}

getAssetId(process.argv[2]);


function getAssetId(p) {
    for(let i=0; i< tagInfo["assets"].length; i++ ) {
        if(tagInfo["assets"][i].name.indexOf(p) > -1) {
            console.log(tagInfo["assets"][i].browser_download_url);
            process.exit(0);
            return;
        }
    }

    console.log("no_assets");
}
