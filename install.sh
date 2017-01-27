#!/usr/bin/env bash

REMOTE=${REMOTE:-https://github.com/lepisma/pkr.git}
CLONED=${CLONED:-/tmp/pkr}

# List of binaries to install
BINS=( pkr )

# Change PREFIX to binary path
[ -z "$PREFIX" ] && PREFIX=/usr/local/bin

install () {
    echo "+ Installing..."
    cd "$PREFIX"
    for bin in "$BINS"
    do
        echo "$password" | eval "$SUDO" cp "$CLONED/$bin" ./
        echo "$password" | eval "$SUDO" chmod +x "$bin"
    done

    # Don't bug me!
    MIRROR="'http://cran.us.r-project.org'"

    # Check for packrat installation
    Rscript -e "library(packrat)" > /dev/null 2>&1
    if [ $? -ne 0 ]
    then
        echo "+ Packrat not found. Installing..."
        # Install at default location
        Rscript -e "install.packages('packrat', repos=$MIRROR)" > /dev/null 2>&1
    fi

    # Install other dependencies
    echo "+ Installing pkr dependencies..."
    # Turn off packrat in case we are in a packrat project
    Rscript -e "packrat::off()" > /dev/null 2>&1
    Rscript -e "install.packages('devtools', repos=$MIRROR)" > /dev/null 2>&1
    Rscript -e "library(devtools); install_github('docopt/docopt.R')" > /dev/null 2>&1
    return $?
}

uninstall () {
    echo "+ Uninstalling any previous version..."
    cd "$PREFIX"
    for bin in "$BINS"
    do
        [ -e "$bin" ] && echo "$password" | eval "$SUDO" rm "$bin"
    done
    return $?
}

echo
echo "Installing pkr to $PREFIX"
echo

# Check for write access to installation directory
if [ -w "$PREFIX" ]
then
    SUDO=""
    password=""
else
    SUDO="sudo -S"
    echo -n "[sudo] enter password: "
    read -s password
    echo
    echo
fi

echo "$password" | eval "$SUDO" rm -rf "${CLONED}"

echo "+ Downloading latest version..."
git clone --depth=1 "${REMOTE}" "${CLONED}" > /dev/null 2>&1

uninstall
install

if [ $? -eq 0 ]
then
    echo
    echo "✓ All Done"
fi
