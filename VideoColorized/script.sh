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
    python3 --version
}

install_ffmpeg() {
    brew install ffmpeg
}

clone_repo() {
    cd $HOME
    git clone https://github.com/iamthaoly/colorized-python.git
}

install_requirements() {
    cd colorized-python
    pip3 -m venv venv
    source venv/bin/activate
    pip3 install -r requirements.txt
    
    pip3 install --no-deps fastai
}

main() {

    echo "Install completed!"
}

main