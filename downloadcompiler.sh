COMPILER_VERSION=1.14.0
GITHUB_OWNER=sCrypt-Inc
GITHUB_REPO=compiler_dist
GITHUB_TAG="v$COMPILER_VERSION"
GITHUB_ASSET_FILENAME_WINDOWS="./scryptc/win32/scryptc.exe"
GITHUB_ASSET_FILENAME_LINUX="./scryptc/linux/scryptc"
GITHUB_ASSET_FILENAME_MACOS="./scryptc/mac/scryptc"
echo "$GITHUB_OWNER"
echo "$GITHUB_REPO"
echo "$GITHUB_TAG"

rm -rf "./scryptc"

mkdir -p "./scryptc/win32/"
mkdir -p "./scryptc/linux/"
mkdir -p "./scryptc/mac/"

#we just update tag.json locally when you change COMPILER_VERSION, because github api has daily limit.
#curl -sSL -J "https://api.github.com/repos/${GITHUB_OWNER}/${GITHUB_REPO}/releases/tags/${GITHUB_TAG}" > tag.json

GITHUB_LINUX_ASSET_URL=$(node parser.js Linux)
GITHUB_MACOS_ASSET_URL=$(node parser.js macOS)
GITHUB_WINDOWS_ASSET_URL=$(node parser.js Windows)





echo "$GITHUB_MACOS_ASSET_URL"
echo "$GITHUB_WINDOWS_ASSET_URL"
echo "$GITHUB_LINUX_ASSET_URL"

if [ $GITHUB_MACOS_ASSET_URL != "no_assets" ]; then 
    curl -L -J ${GITHUB_MACOS_ASSET_URL} -o ${GITHUB_ASSET_FILENAME_MACOS} -H 'Accept: application/octet-stream'
    chmod  u+x "$GITHUB_ASSET_FILENAME_MACOS"
    
fi

if [ $GITHUB_LINUX_ASSET_URL != "no_assets" ]; then 
    curl -L -J ${GITHUB_LINUX_ASSET_URL} -o ${GITHUB_ASSET_FILENAME_LINUX} -H 'Accept: application/octet-stream'
    chmod  u+x "$GITHUB_ASSET_FILENAME_LINUX"
fi

if [ $GITHUB_WINDOWS_ASSET_URL != "no_assets" ]; then 
    curl -L -J ${GITHUB_WINDOWS_ASSET_URL} -o ${GITHUB_ASSET_FILENAME_WINDOWS} -H 'Accept: application/octet-stream'
fi
