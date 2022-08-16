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
    brew install python
#    res=$($BREW_PATH install python)
#    echo "$res"
    echo $(python3 --version)
    which python3
}

install_ffmpeg() {
    echo "----------------------"
    echo "3. ffmpeg"
    echo "Installing ffmpeg"
    brew install ffmpeg
    which ffmpeg
    ffmpeg -version | sed -n "s/ffmpeg version \([^ ]*\).*/\1/p;"
}

install_cmake() {
    echo "----------------------"
    echo "4. cmake"
    echo "Installing cmake"
    brew install cmake
    which cmake
    cmake --version
}

main() {
    install_brew
    install_python
    install_ffmpeg
    install_cmake
}

main
