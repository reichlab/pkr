#!/usr/bin/env bash

REMOTE=${REMOTE:-https://github.com/lepisma/pkr.git}
DEST=${DEST:-/tmp/pkr}

# List of binaries
BINS=( pkr )

# Change PREFIX to binary path
[ -z $PREFIX ] && PREFIX=/usr/local/bin

install () {
    uninstall
    echo "Installing to $PREFIX"
    cd $PREFIX
    for bin in $BINS
    do
        cp "$DEST/bin/$bin" ./
        chmod +x $bin
    done
    return $?
}

uninstall () {
    echo -e "\nUninstalling any previous version..."
    cd $PREFIX
    for bin in $BINS
    do
        [ -e $bin ] && rm $bin
    done
    return $?
}

# Main entry point
rm -rf "${DEST}"

echo "Downloading latest version..."
git clone --depth=1 "${REMOTE}" "${DEST}" > /dev/null 2>&1

install

echo "Done"
