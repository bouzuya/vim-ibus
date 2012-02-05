scriptencoding utf-8

if !has('python')
  finish
endif

function! ibus#is_enabled()
  return s:is_enabled()
endfunction

function! ibus#enable()
  return s:enable()
endfunction

function! ibus#disable()
  return s:disable()
endfunction

function! ibus#toggle()
  return s:toggle()
endfunction

function! s:is_enabled()
  python << EOT
import vim
import ibus
bus = ibus.Bus()
ic = ibus.InputContext(bus, bus.current_input_contxt())
vim.command('let l:ime_is_enabled = ' + str(ic.is_enabled()))
EOT
    return l:ime_is_enabled
endfunction

function! s:enable()
  python << EOT
import ibus
bus = ibus.Bus()
ic = ibus.InputContext(bus, bus.current_input_contxt())
if not ic.is_enabled():
    ic.enable()
EOT
endfunction

function! s:disable()
  python << EOT
import ibus
bus = ibus.Bus()
ic = ibus.InputContext(bus, bus.current_input_contxt())
if ic.is_enabled():
    ic.disable()
EOT
endfunction

function! s:toggle()
  python << EOT
import ibus
bus = ibus.Bus()
ic = ibus.InputContext(bus, bus.current_input_contxt())
if ic.is_enabled():
    ic.disable()
else:
    ic.enable()
EOT
endfunction

