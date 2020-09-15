#!/bin/bash


set -e

./check.sh
res=$?
if [[ ${res} != 0 ]]; then
    exit ${res}
fi

echo "Your ~/.vim and ~/.vimrc will be completely deleted to generate the new ones."
while true; do
    read -r -p "Continue? [Y/n] " input
    case $input in
        [yY][eE][sS]|[yY])
            break
            ;;
        [nN][oO]|[nN])
            echo 'Abort.'
            exit 1
            ;;
        *)
            echo "Invalid input..."
            ;;
    esac
done


rm -rf ~/.vim ~/.vimrc
mkdir ~/.vim 2>/dev/null

cp ./banner.txt ~/.vim/
cp ./type ~/.vim/.type
cp ./*.vim ~/.vim/
cp ./vimrc ~/.vim/vimrc
echo 'source ~/.vim/vimrc' > ~/.vimrc
cp -r ./templates ~/.vim/

grep -q vimg ~/.bashrc || cat vimg >> ~/.bashrc

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo "The proxy of Golang should be configured if you are in China:"
echo "set GOPROXY=\"https://goproxy.cn,direct\""
echo "set GO111MODULE=\"on\""
while true; do
    read -r -p "Continue? [Y/n] " input
    case $input in
        [yY][eE][sS]|[yY])
            go env -w GOPROXY=https://goproxy.cn,direct
            go env -w GO111MODULE=on
            break
            ;;
        [nN][oO]|[nN])
            break
            ;;
        *)
            echo "Invalid input..."
            ;;
    esac
done

GOPROXY=$(go env | grep GOPROXY | cut -d'=' -f2)
echo "Are you behind a proxy which is not trusted by ${GOPROXY}?"
while true; do
    read -r -p "[Y/n] " input
    case $input in
        [yY][eE][sS]|[yY])
            unset https_proxy
            break
            ;;
        [nN][oO]|[nN])
            break
            ;;
        *)
            echo "Invalid input..."
            ;;
    esac
done
vim --cmd 'let Giraffa=1' --cmd 'let install=1' -E -c PluginInstall -c GoInstallBinaries -c q -c q
go get -u github.com/jstemmer/gotags

go env -w GO111MODULE=off

git clone https://github.com/Valloric/YouCompleteMe.git ~/.vim/bundle/YouCompleteMe
./install_YCM.sh

echo "Done."
