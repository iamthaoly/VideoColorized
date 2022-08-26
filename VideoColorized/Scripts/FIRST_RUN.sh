
main() {
    # Avoid error with path that contains white spaces.
    sudo installer -vers
#    echo "Before cd"
#    pwd
    cd "`dirname -- "$0"`"
    echo "After cd"
    pwd
    ls -ah
    sh brew_script.sh
    sudo sh init_script.sh
}

main
