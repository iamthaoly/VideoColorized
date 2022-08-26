ECHO=/bin/echo

clone_repo() {
    $ECHO "----------------------"
    $ECHO "Clone the repo..."
    cd $HOME
    sudo rm -rf colorized-python
    git clone https://github.com/iamthaoly/colorized-python.git
}

activate() {
    . $HOME/colorized-python/venv/bin/activate
}

install_requirements() {
    $ECHO "----------------------"
    $ECHO "Install the requirements..."
    cd $HOME/colorized-python
    
    $ECHO "Create a virtual environment"
    python3 -m venv venv
    activate
    pip3 install -r requirements.txt --default-timeout=100 future
    pip3 install --no-deps fastai==1.0.60
}

download_models() {
    cd $HOME/colorized-python/
    $ECHO "Current dir"
    pwd
    mkdir -p 'models'
    if [ -e "models/ColorizeVideo_gen.pth" ]
    then
        $ECHO "Model file existed."
    else
        $ECHO "Model file is not existed. Downloading..."
        curl https://data.deepai.org/deoldify/ColorizeVideo_gen.pth -o models/ColorizeVideo_gen.pth
    fi
}

runConvert() {
    cd $HOME/colorized-python
    python3 runner.py
}

main() {
    clone_repo
    install_requirements
    download_models
    $ECHO "COMPLETED!"
}

($ECHO "I am a script! 123">&2)2>&1
main 2>&1
