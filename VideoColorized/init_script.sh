clone_repo() {
    echo "----------------------"

    echo "Clone the repo..."
    cd $HOME
    git clone https://github.com/iamthaoly/colorized-python.git
}

install_requirements() {
    echo "----------------------"
    echo "Install the requirements..."
    cd colorized-python
    python3 -m venv venv
    source venv/bin/activate
    pip3 install -r requirements.txt
    
    pip3 install --no-deps fastai==1.0.60
}

main() {
    clone_repo
    install_requirements
    echo "Install completed!"
}

main
