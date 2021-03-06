Giraffa-vim
==========================


### Introduction ###
Giraffa-vim can build a vim-plugin-based environment for golang. It will install and configure YouCompleteMe, vim-go and some other plugins.<br>
It allows you to search and replace words, comment and uncomment codes.<br>
It allows you to jump to definition recusively.<br>
It allows you to format codes with `gofmt`.


### Tested OS list
Ubuntu 16.04<br>
Ubuntu 18.04<br>
CentOS 7


### Installation ###
Giraffa-vim supports only vim 8.<br>
Execute `./check.sh` to check if the environment is suitable for the installation.<br>
Execute `./install.sh` to do the installation.


##### Issues #####
a) As some Golang tools will be installed while executing `./install.sh`, you need to make sure that the environment variables of Golang are configured correctly before this installation. Here is my `~/.bashrc`:
```
export GOROOT=/usr/local/go
export GOPATH=`$GOROOT/bin/go env GOPATH`
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
```
b) Golang has some issue in China, so if you are in China, please pay attention to the yes-or-no questions while installing.

c) `go env -w GO111MODULE=auto` or `go env -w GO111MODULE=on` may be necessary to enable `<F12>`.

### General Usage ###
Execute `source ~/.bashrc` after the installation to make `vimc` work.<br>
To start a go project, execute `vimc` at the root of the project.<br>

##### Normal Mode
`:Q<CR>`: quit vim and all plugins<br>
`:W<CR>`: save all & `:Q<CR>`<br>
`<C-k>` : save<br>

`\tg`: open or close the window of taglist<br>

`<F5>`: go to shell, equivalent to `:term<CR>`<br>
`gg=G`: format the current file with `gofmt`<br>

`mh`: move cursor to left window<br>
`mj`: move cursor to bottom window<br>
`mk`: move cursor to top window<br>
`ml`: move cursor to right window<br>
`mw`: move cursor to window below/right of the current one<br>
`mt`: move cursor to top-left window<br>
`mb`: move cursor to bottom-right window<br>
`mp`: move cursor to previous window<br>

`+`: increase width of window towards left<br>
`-`: decrease width of window towards right<br>

`\cc`: comment one line<br>
`\cv`: comment one line with next delimiter<br>
`\cm`: comment multi lines<br>
`\c$`: comment to end of line<br>
`\cu`: uncomment<br>

`<C-p>`: search file in project<br>

`:Grep [keyword]<CR>`: search the keyword in project<br>
`\vv`: search the word under cursor in project<br>
`:Replace [keyword]<CR>`: replace the word under cursor with `keyword` in project<br>
`:Replace [target] [keyword]<CR>`: replace the word `target` with `keyword` in project<br>
`:UndoReplace<CR>`: undo `:Replace`<br>
`cgt`: save changes and close all tabs except the first, then close the bottom-right window<br>
`:ccl<CR>`: close `Grep` window<br>

`\'` : wrap selected part by "'", if no part is selected, the word under cursor will be wrapped<br>
`\\'`: remove the closest "'" wrapped the part in which the cursor is<br>
similar shortcuts: `\"` and `\\"`, `\(` and `\\(`, `\[` and `\\[`, `\{` and `\\{`, `\<` and `\\<`<br>

`<F12>`: goto definition<br>
`<C-o>`: go backword<br>
`<C-i>`: go forward<br>

`:GoDebugStart .<CR>`: run debugger of vim-go<br>

##### Insert Mode
`<C-j>`: move cursor backwards out of parenthesis<br>
`<C-k>`: goto normal mode and save<br>
`<C-e>`: move the current character to the end of next word<br>
`<C-l>`: move the cursor to the end of line<br>
`<C-\>`: delete the word under the cursor<br>

To get more information about usage, click on the links at the References below.


### Tips ###
1) `vim -Nu ~/.vim/bundle/YouCompleteMe/vimrc_ycm_minimal xxx.go` to get minimal vim configuration for YCM to debug YCM.<br>
2) Debug commands of YCM: `:YcmDiags`, `YcmDebugInfo`, `YcmToggleLogs`.


### References ###
https://github.com/VundleVim/Vundle.vim<br>
https://github.com/Valloric/YouCompleteMe<br>
https://github.com/preservim/nerdtree<br>
https://github.com/fatih/vim-go<br>
https://github.com/ctrlpvim/ctrlp.vim<br>
https://github.com/scrooloose/nerdcommenter<br>
https://github.com/majutsushi/tagbar<br>
https://github.com/rstacruz/sparkup<br>
https://github.com/Yggdroot/indentLine<br>
https://github.com/jiangmiao/auto-pairs<br>
https://github.com/tpope/vim-repeat<br>
https://github.com/tpope/vim-fugitive<br>
https://github.com/Xuyuanp/nerdtree-git-plugin<br>
https://github.com/YvesZHI/vim-code-dark<br>
https://github.com/YvesZHI/killersheep<br>
https://github.com/goproxy/goproxy.cn<br>
https://codeyarns.com/2015/03/18/how-to-test-color-setup-in-vim
