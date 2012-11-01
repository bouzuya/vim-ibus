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
from dbus.exceptions import DBusException
bus = ibus.Bus()
try:
    #
    # TODO: may be a good idea to make ic global.  This would reduce the amount
    # ugly exception-handling code.  See:
    #
    # http://www.mail-archive.com/vim_dev@googlegroups.com/msg18318/example_ibus.vim
    #
    ic = ibus.InputContext(bus, bus.current_input_contxt())
    vim.command('let ibus_is_enabled = ' + str(ic.is_enabled()))
except DBusException:
    #
    # dbus.exception.DBusException: org.freedesktop.DBus.Error.failed: No focused input context
    # This happens occasionally, causing a long trace of errors in Vim.
    # The exception is less harmful than the annoying long trace.
    # Assume ibus is disabled and carry on
    #
    vim.command('let ibus_is_enabled = 0')
EOT
  return ibus_is_enabled
endfunction

function! s:enable()
  python << EOT
import ibus
from dbus.exceptions import DBusException
bus = ibus.Bus()
try:
    ic = ibus.InputContext(bus, bus.current_input_contxt())
    if not ic.is_enabled():
        ic.enable()
except DBusException:
    pass
EOT
  return ''
endfunction

function! s:disable()
  python << EOT
import ibus
from dbus.exceptions import DBusException
bus = ibus.Bus()
try:
    ic = ibus.InputContext(bus, bus.current_input_contxt())
    if ic.is_enabled():
        ic.disable()
except DBusException:
    pass
EOT
  return ''
endfunction

function! s:toggle()
  python << EOT
import ibus
from dbus.exceptions import DBusException
bus = ibus.Bus()
try:
    ic = ibus.InputContext(bus, bus.current_input_contxt())
    if ic.is_enabled():
        ic.disable()
    else:
        ic.enable()
except DBusException:
    pass
EOT
  return ''
endfunction

