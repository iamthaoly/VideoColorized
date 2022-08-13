clone_repo() {
    echo "----------------------"

    echo "Clone the repo..."
    cd $HOME
    git clone https://github.com/iamthaoly/colorized-python.git
}

activate() {
    sudo $HOME/colorized-python/venv/bin/activate
}

install_requirements() {
    echo "----------------------"
    echo "Install the requirements..."
    cd colorized-python
    
    echo "Create a virtual environment"
    python3 -m venv venv
<!--    ./venv/bin/activate-->
    activate
    pip3 install -r requirements.txt
    pip3 install --no-deps fastai==1.0.60
}

main() {
    clone_repo
    install_requirements
    echo "Install completed!"
}

main
