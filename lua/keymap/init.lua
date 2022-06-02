local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_key = bind.map_key

require("keymap.config")

local plug_map = {
  ["i|<TAB>"] = map_cmd("v:lua.tab_complete()"):with_expr():with_silent(),
  ["i|<S-TAB>"] = map_cmd("v:lua.s_tab_complete()"):with_silent():with_expr(),
  ["s|<TAB>"] = map_cmd("v:lua.tab_complete()"):with_expr():with_silent(),
  ["s|<S-TAB>"] = map_cmd("v:lua.s_tab_complete()"):with_silent():with_expr(),
}
return { map = plug_map }
