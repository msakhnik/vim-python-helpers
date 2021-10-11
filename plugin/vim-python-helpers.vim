python3 << EOF
# print("Hello from Vim's Python!")
EOF
"  Insert pdb set trace (requires python3)
function! Pdb()
python3 << endPython
new_cword = "import pdb;pdb.set_trace()"
vim.command("normal o%s" % new_cword)

endPython
endfunction


"  Insert rpdb set trace
function! RPdb()
python3 << endPython
new_cword = "import rpdb;rpdb.set_trace()"
vim.command("normal o%s" % new_cword)

endPython
endfunction

let s:plugin_root_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')

python3 << EOF
import sys
from os.path import normpath, join
import vim
plugin_root_dir = vim.eval('s:plugin_root_dir')
python_root_dir = normpath(join(plugin_root_dir, '..', 'python'))
sys.path.insert(0, python_root_dir)
EOF

function! Dtos()
python3 << endPython
import quotes
quotes.replace_double_with_single_quotes()
endPython
endfunction

command! -nargs=0 Dtos call Dtos()
