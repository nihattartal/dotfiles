nmap <LEADER>Af :ALEFix<CR>

let g:ale_lint_on_text_changed = 1
let g:ale_lint_on_save = 1
let g:ale_set_loclist = 1

let g:ale_fixers = {
\  'ruby': [
\    'remove_trailing_lines',
\    'trim_whitespace',
\    'rubocop'
\  ]
\}

let g:ale_ruby_rubocop_executable = 'bin/rubocop'
let g:ruby_indent_assignment_style = 'variable'

 let g:ale_linters = {
 \   'javascript': ['eslint'],
 \   'python': ['flake8'],
 \   'ruby': ['rubocop', 'ruby'],
 \   'graphql': ['gqlint'],
 \   'yaml': ['yaml-lint']
 \}

 " Customize flags
 let g:ale_sign_error = '✖︎'
 let g:ale_sign_warning = '❢'

 " aj goes to next lint error
nmap <silent> <leader>aj :ALENext<cr>
nmap <silent> <leader>ak :ALEPrevious<cr>
