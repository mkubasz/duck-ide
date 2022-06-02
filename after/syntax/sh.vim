" Shebang
syn match shShebang "^#!.*$" containedin=shComment

" Operators
syn match shOperator '||'
syn match shOperator '&&'

" Match semicolons as Delimiter rather than Operator
syn match shSemicolon ';' containedin=shOperator,zshOperator


" Special files as Constants
syn match Constant "\v/dev/\w+"
            \ containedin=shFunctionOne,shIf,shCmdParenRegion,shCommandSub

" Common commands
let commands = [ 'arch', 'awk', 'b2sum', 'base32', 'base64', 'basename', 'basenc', 'bash', 'brew', 'cat', 'chcon', 'chgrp', 'chown', 'chroot', 'cksum', 'comm', 'cp', 'csplit', 'curl', 'cut', 'date', 'dd', 'defaults', 'df', 'dir', 'dircolors', 'dirname', 'ed', 'env', 'expand', 'factor', 'fmt', 'fold', 'git', 'grep', 'groups', 'head', 'hexdump', 'hostid', 'hostname', 'hugo', 'id', 'install', 'join', 'killall', 'link', 'ln', 'logname', 'md5sum', 'mkdir', 'mkfifo', 'mknod', 'mktemp', 'nice', 'nl', 'nohup', 'npm', 'nproc', 'numfmt', 'od', 'open', 'paste', 'pathchk', 'pr', 'printenv', 'printf', 'ptx', 'readlink', 'realpath', 'rg', 'runcon', 'scutil', 'sed', 'seq', 'sha1sum', 'sha2', 'shred', 'shuf', 'split', 'stat', 'stdbuf', 'stty', 'sudo', 'sum', 'sync', 'tac', 'tee', 'terminfo', 'timeout', 'tmux', 'top', 'touch', 'tput', 'tr', 'truncate', 'tsort', 'tty', 'uname', 'unexpand', 'uniq', 'unlink', 'uptime', 'users', 'vdir', 'vim', 'wc', 'who', 'whoami', 'yabai', 'yes' ]

for i in commands
    execute 'syn match shStatement "\v(\w|-)@<!'
                \ . i
                \ . '(\w|-)@!" containedin=shFunctionOne,shIf,shCmdParenRegion,shCommandSub'
endfor

" Fix default highlighting groups
hi def link bashSpecialVariables Identifier
hi def link shCmdSubRegion Delimiter
hi def link shDerefSimple Identifier
hi def link shFor Identifier
hi def link shFunctionKey Statement
hi def link shQuote StringDelimiter
hi def link shRange Delimiter
hi def link shSnglCase Delimiter
hi def link shStatement Statement
hi def link shTestOpr Operator
hi def link shVarAssign Operator


" Link custom groups
hi def link shSemicolon Delimiter
hi def link shShebang PreProc

