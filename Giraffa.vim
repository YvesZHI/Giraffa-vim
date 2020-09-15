command Q qa
command W w|qa
"command Q call delete('.tags')|call delete('.clang-format')|qa
"command Qone q|TlistClose
"cnoreabbrev q Qone
command Html s/<[^>]*/\r&/g|g/^$/d

set signcolumn=yes
set colorcolumn=120
hi ColorColumn ctermbg=0 guibg=lightgrey
set updatetime=4500
set completeopt=menu,popup,longest
"set completeopt=menu,preview,longest
"set completeopt-=preview
set conceallevel=2
set concealcursor=vin
set splitbelow

colorscheme codedark
set t_Co=256
set smc=600  " to limit the regular expression of syntax color to avoid huge calculation

set rtp+=~/.vim/bundle/YouCompleteMe "YCM is installed with some error, so Vundle can't distinguish it automatically.

"augroup readonly
"    autocmd!
"    autocmd! BufReadPost ~/.vim/banner.txt setlocal readonly
"augroup END

autocmd BufWinLeave * silent! TlistClose
autocmd VimEnter * NERDTree
autocmd VimEnter * execute "normal j"
autocmd VimEnter * execute "call DeleteBufferImg()"
function! BufferDelete(id)
    if bufnr('$') > 2
        execute "bd1"
        call timer_stop(a:id)
    endif
endfunction
function! DeleteBufferImg()
    let t = timer_start(2200, 'BufferDelete', {'repeat': -1})
endfunction

autocmd BufWritePost *.go execute "GoFmt"
"autocmd CursorHold,CursorHoldI * update
autocmd FileType go setlocal equalprg=gofmt

augroup templates
    autocmd!
    autocmd BufRead *.go call s:ApplyTemplate()

    function! s:ApplyTemplate()
        if getfsize(expand('%')) == 0
            if expand('%:t:r') == 'main'
                execute "0r ~/.vim/templates/" . expand('%:t')
            else
                execute "0r ~/.vim/templates/template." . expand('%:e')
                if expand('%:e') == 'go'
                    execute "%s/this_should_be_replaced/" . expand('%:p:h:t') . "/e"
                    " execute "%s/\\./_" . "/e"
                endif
            endif
        endif
    endfun
augroup END


let g:NERDTreeWinSize=24
let baseFileType='\.yaml\|\.yml\|\.json\|\.toml\|\.xml\|\.html\|\.sh\|\.mod'
let currentFileType='\.go'
let NERDTreeIgnore=['\(' . currentFileType . '\|' . baseFileType . '\)\@<!$[[file]]', 'bin']
let NERDTreeAutoDeleteBuffer=1
let NERDTreeShowLineNumbers=1

let g:Tlist_Use_Right_Window=1
let g:Tlist_Auto_Open=1

"set statusline+=%#warningmsg#
"function! YCMStatusLine() abort
"    if exists(':YcmDiag')
"        let l:errCounts = youcompleteme#GetErrorCount()
"        let l:wrnCounts = youcompleteme#GetWarningCount()
"
"        return printf(
"        \   '%dW %dE',
"        \   wrnCounts,
"        \   errCounts,
"        \)
"    endif
"    return ''
"endfunction
"set statusline+=%{YCMStatusLine()}
"set statusline+=%*

"let g:ycm_filetype_whitelist = {
"			\ "golang":1,
"			\ "sh":1,
"			\ "bash":1,
"			\ }

let g:ycm_auto_hover=""
let g:ycm_disable_signature_help = 0
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

let g:go_highlight_types = 1
let g:go_highlight_structs = 1
let g:go_highlight_methods = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_auto_type_info = 0
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
let g:go_fmt_autosave = 0
let g:go_fmt_options = {
    \ 'gofmt': '-s',
    \ 'goimports': '-local ' . trim(system("head -n 1 go.mod|awk '{print $2}'")),
    \ }

let g:NERDSpaceDelims=1
let g:NERDCompactSexyComs=1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_java=1
let g:NERDCommentEmptyLines=1
let g:NERDTrimTrailingWhitespace=1
let g:NERDToggleCheckAllLines=1
let g:NERDCustomDelimiters = {
\   'go': { 'left': '//', 'leftAlt': '/*', 'rightAlt': '*/' },
\}

let g:airline_theme='sol'
let g:airline#extensions#ycm#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab

let g:indentLine_enabled = 1
let g:indentLine_char = '┆'
let g:indentLine_color_term = 60

let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }

let skeletons#autoRegister = 1

nnoremap cgt :wa<CR> \| :2,$tabdo :tabc<CR> \| <C-w><C-j> :q<CR>
nmap <leader>cv <leader>ca<leader>cc<leader>ca

"nnoremap <F5> :wa<CR> \| :sh<CR>
"nnoremap <F5> :wa<CR> \| :term ++kill=term<CR>
nnoremap <F5> :wa \| vertical botright term ++kill=term<CR>

nnoremap <leader>tg :TagbarToggle<CR>

nnoremap mh <C-w><C-h>
nnoremap mj <C-w><C-j>
nnoremap mk <C-w><C-k>
nnoremap ml <C-w><C-l>
nnoremap mw <C-w><C-w>
nnoremap mt <C-w><C-t>
nnoremap mb <C-w><C-b>
nnoremap mp <C-w><C-p>

nnoremap <F12> :YcmCompleter GoToDefinition<CR> \| :NERDTreeFind<CR> \| :wincmd p<CR>
nnoremap <C-i> <C-i> \| :NERDTreeFind<CR> \| :wincmd p<CR>
nnoremap <C-o> <C-o> \| :NERDTreeFind<CR> \| :wincmd p<CR>

""" Custom Search & Custom Replace
""" Custom Search is async but Custom Replace is not
function! CustomGrepCore(target)
    silent! execute 'vimgrep '.a:target.' **/*.go'
    return len(getqflist())
endfunction

function! CustomGrepJob(...) abort
    let before = expand('%:p')
    if a:0 == 1    " a:0 is the number of parameters
        let res = CustomGrepCore("<cword>")
        let jobID = a:1
    else
        let res = CustomGrepCore(a:1)
        let jobID = a:2
    endif
    if res != 0
        cope
        execute "normal \<C-w>\<C-k>"
        if before != expand('%:p')
            execute "normal \<C-o>"
        endif
    endif
    call timer_stop(jobID)
endfunction

function! CustomGrep(...) abort
    call timer_start(0, function('CustomGrepJob', a:000))   " jobID will be appended at the end of the parameter a:000
endfunction

function! CustomReplace(...)
    if a:0 == 1
        let target = expand("<cword>")
        let newWord = a:1
    elseif a:0 == 2
        let target = a:1
        let newWord = a:2
    else
        return
    endif
    let g:target = newWord
    let g:lastWord = target

    let before = expand('%:p')
    let res = CustomGrepCore(target)
    if res != 0
        if before != expand('%:p')
            execute "normal \<C-o>"
        endif
    endif
    cdo execute 's/'.target.'/'.newWord.'/gc | w'

    "let cnt = CustomGrepCore(target)
    "let x = 0
    "while x < cnt
    "    execute 's/'.target.'/'.newWord.'/gc'
    "    w
    "    if x != cnt - 1
    "        cnext
    "    endif
    "    let x = x + 1
    "endwhile
endfunction

function! CustomUndoReplace()
    let before = expand('%:p')
    let res = CustomGrepCore(g:target)
    if res != 0
        cfdo execute '%s/'.g:target.'/'.g:lastWord.'/g | w'
        if before != expand('%:p')
            execute "normal \<C-o>"
        endif
    endif
endfunction

command! -nargs=? Grep :call CustomGrep(<f-args>)
command! -nargs=+ Replace :call CustomReplace(<f-args>)
command! UndoReplace :silent! call CustomUndoReplace()
nnoremap <leader>vv :Grep<CR>
