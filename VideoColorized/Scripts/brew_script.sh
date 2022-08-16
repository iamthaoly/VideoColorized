BREW_PATH=/usr/local/bin/brew

install_brew() {
    echo "----------------------"
    echo "1. Homebrew"
    if test ! $(which brew); then
    echo "Homebrew's not installed. Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
    echo "Homebrew's installed."
    echo $(brew -v)
    echo ""
    echo "Updating homebrew..."
    brew update
    
    echo ""
    fi
}

install_python() {
    echo "----------------------"
    echo "2. Python"
    echo $("$BREW_PATH install python")
    
    echo $(python3 --version)
}

install_ffmpeg() {
    echo "----------------------"
    echo "3. ffmpeg"
    echo "Installing ffmpeg"
    $BREW_PATH install ffmpeg
}

install_cmake() {
    echo "----------------------"
    echo "4. cmake"
    echo "Installing cmake"
    $BREW_PATH install cmake
}

main() {
    install_brew
    install_python
    install_ffmpeg
    install_cmake
}

main
