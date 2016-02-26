# Copy TMP Configs
cp config.tmp.json config.json

# Make Log Directory
mkdir logs

# Activate Submodules
git submodule init
git submodule update

# Install NPM Libraries
npm install
