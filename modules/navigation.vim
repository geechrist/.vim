NeoBundle 'Shougo/vimproc.vim', {
      \ 'build' : {
      \     'windows' : 'tools\\update-dll-mingw',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }

NeoBundle 'Shougo/unite.vim'
let g:unite_enable_short_source_names = 1
let g:unite_split_rule = "botright"
let g:unite_force_overwrite_statusline = 0
let g:unite_winheight = 10

call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
      \ 'ignore_pattern', join([
      \ '\.git/',
      \ ], '\|'))

call unite#custom_source('buffer',
      \ 'ignore_pattern', join([
      \ 'vimfiler',
      \ ], '\|'))

" only match filename
call unite#custom#source(
      \ 'buffer,file_rec/async,file_rec', 'matchers',
      \ ['converter_tail', 'matcher_hide_hidden_files', 'matcher_fuzzy'])
call unite#custom#source(
      \ 'buffer,file_rec/async,file_rec', 'converters',
      \ ['converter_file_directory'])

" call unite#filters#matcher_default#use(['matcher_fuzzy', 'matcher_hide_hidden_files'])
call unite#filters#sorter_default#use(['sorter_rank'])
nn <C-p> :<C-u>Unite -start-insert -buffer-name=files buffer file_rec/async:!<cr>
nn <C-e> :<C-u>Unite -start-insert buffer<cr>

autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
  no <silent><buffer><expr> <C-x> unite#do_action('split')
  ino <silent><buffer><expr> <C-x> unite#do_action('split')
  no <silent><buffer><expr> <C-v> unite#do_action('vsplit')
  ino <silent><buffer><expr> <C-v> unite#do_action('vsplit')
  imap <buffer> <ESC> <Plug>(unite_exit)
  nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction

" explorer
" disable netrw
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1
NeoBundle 'Shougo/vimfiler.vim'
let g:vimfiler_as_default_explorer = 1
function! ToggleVimFilerExplorer()
  :VimFiler -buffer-name=explorer -split -simple -winwidth=25 -toggle -no-quit
endfunction
no <F1> :call ToggleVimFilerExplorer()<CR><CR>
autocmd FileType vimfiler nunmap <buffer> <C-l>
autocmd FileType vimfiler nmap <buffer> <C-R>  <Plug>(vimfiler_redraw_screen)
autocmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') | q | endif
let g:vimfiler_ignore_pattern = '^\%(.git\|.DS_Store\|node_modules\|bower_components\)$'
