set history save on
set history filename ~/.gdb_history
set history size 10000
set history expansion on
set print pretty
set pagination off

set logging file ~/gdb_log
set logging on

define bta
    thread apply all backtrace
end
document bta
Alias for 'thread apply all backtrace'
end

