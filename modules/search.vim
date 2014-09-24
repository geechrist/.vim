set hlsearch
set ignorecase
set smartcase
" clear search matching
nm <leader><space> :noh<cr>:call clearmatches()<cr>

" sane regexes
" nn / /\v
" vn / /\v

if executable('ag')
  let g:unite_source_rec_async_command= 'ag --nocolor --nogroup --ignore ".hg" --ignore ".svn" --ignore ".git" --hidden -g ""'
  let g:unite_source_grep_command = 'ag'
endif
let g:unite_source_grep_default_opts = '--nogroup --nocolor --ignore ".hg" --ignore ".svn" --ignore ".git" --column'
let g:unite_source_grep_recursive_opt = ''

nn <leader>/ :<C-u>Unite -no-empty -auto-highlight grep:.<cr>
nn K :<C-u>Unite -no-empty -auto-highlight grep:.<cr><c-r><c-w><cr>

" Dash Searching"
NeoBundle "rizzatti/funcoo.vim.git"
NeoBundle "rizzatti/dash.vim.git"
nm <F7> <Plug>DashSearch
