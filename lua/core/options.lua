local global = require("core.global")

local function bind_option(options)
  for k, v in pairs(options) do
    if v == true or v == false then
      vim.cmd("set " .. k)
    else
      vim.cmd("set " .. k .. "=" .. v)
    end
  end
end

-- stylua: ignore start
local function load_options()
  local global_local = {
    termguicolors  = true;
    mouse          = "anv";
    errorbells     = true;
    visualbell     = true;
    hidden         = true;
    fileformats    = "unix,mac";
    magic          = true;
    virtualedit    = "block";
    encoding       = "utf-8";
    viewoptions    = "folds,cursor,curdir,slash,unix";
    sessionoptions = "curdir,help,tabpages,winsize";
    clipboard      = "unnamedplus";
    wildignorecase = true;
    wildignore     = [[
      .git,.hg,.svn
      *.aux,*.out,*.toc
      *.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class
      *.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
      *.avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg
      *.mp3,*.oga,*.ogg,*.wav,*.flac
      *.eot,*.otf,*.ttf,*.woff
      *.doc,*.pdf,*.cbr,*.cbz
      *.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb
      *.swp,.lock,.DS_Store,._*
      */tmp/*,*.so,*.swp,*.zip,**/node_modules/**,**/target/**,**.terraform/**"
      ]];
    backup         = false;
    writebackup    = false;
    undofile       = true;
    swapfile       = false;
    directory      = global.cache_dir .. "swag/";
    undodir        = global.cache_dir .. "undo/";
    backupdir      = global.cache_dir .. "backup/";
    viewdir        = global.cache_dir .. "view/";
    spellfile      = global.cache_dir .. "spell/en.uft-8.add";
    history        = 4000;
    shada          = "!,'300,<50,@100,s10,h";
    backupskip     = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim";
    smarttab       = true;
    smartindent    = true;
    shiftround     = true;
    timeout        = true;
    ttimeout       = true;
    timeoutlen     = 500;
    ttimeoutlen    = 10;
    updatetime     = 500;
    redrawtime     = 100;
    ignorecase     = true;
    smartcase      = true;
    infercase      = true;
    incsearch      = true;
    wrapscan       = true;
    complete       = ".,w,b,k";
    inccommand     = "nosplit";  --split
    grepformat     = "%f:%l:%c:%m";
    grepprg        = 'rg --hidden --vimgrep --smart-case --glob "!{.git,node_modules,*~}/*" --';
    breakat        = [[\ \	;:,!?]];
    startofline    = false;
    whichwrap      = "h,l,<,>,[,],~";
    splitbelow     = true;
    splitright     = true;
    switchbuf      = "useopen";
    backspace      = "indent,eol,start";
    diffopt        = "filler,iwhite,internal,algorithm:patience";
    completeopt    = "menu,menuone,noinsert,noselect";
    jumpoptions    = "stack";
    showmode       = false;
    shortmess      = "aotTIcF";
    scrolloff      = 2;
    sidescrolloff  = 5;
    foldlevel      = 99;
    foldlevelstart = 99;
    ruler          = false;
    relativenumber = true;
    list           = true;
    showtabline    = 2;
    winwidth       = 30;
    winminwidth    = 10;
    pumheight      = 15;
    helpheight     = 12;
    previewheight  = 12;
    showcmd        = false;
    cmdheight      = 2;
    cmdwinheight   = 5;
    equalalways    = false;
    laststatus     = 2;
    display        = "lastline";
    showbreak      = "﬌  ";
    listchars      = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←";
    pumblend       = 10;
    winblend       = 10;
    syntax         = "off";
    background     = "dark";
  }

  local bw_local  = {
    synmaxcol      = 1000;
    formatoptions  = "1jcroql";
    textwidth      = 80;
    expandtab      = true;
    autoindent     = true;
    tabstop        = 2;
    shiftwidth     = 2;
    softtabstop    = -1;
    breakindentopt = "shift:2,min:20";
    wrap           = false;
    linebreak      = true;
    number         = true;
    foldenable     = true;
    signcolumn     = "auto:1"; 
    conceallevel   = 2;
    concealcursor  = "niv";
  }
  if global.is_mac then
      vim.g.clipboard = {
        name = "macOS-clipboard",
        copy = {
          ["+"] = "pbcopy",
          ["*"] = "pbcopy",
        },
        paste = {
          ["+"] = "pbpaste",
          ["*"] = "pbpaste",
        },
        cache_enabled = 0
      }
      vim.g.python3_host_prog = '/usr/local/bin/python3'
    end

  for name, value in pairs(global_local) do
    vim.o[name] = value
  end
  bind_option(bw_local)
end

vim.cmd([[syntax on]])
vim.cmd([[set viminfo-=:42 | set viminfo+=:1000]])

load_options()
