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

python
import gdb

class DumpAttr(gdb.Command):
    def __init__(self):
        # print(dir(gdb))
        super(DumpAttr, self).__init__("dump-attribute", gdb.COMMAND_DATA)

    def invoke(self, arg, from_tty):
        arguments = gdb.string_to_argv(arg)
        if len(arguments) != 1:
            raise ValueError("Too many arguments")

        strdup = "((const char*(*)())strdup)"

        val = gdb.parse_and_eval("%s(%s.getXML().c_str())" % (strdup,
                                                              arguments[0]))
        as_string = val.string("utf-8")
        # gdb.parse_and_eval("(void(*)())free")(val)

        # print(dir(val))

        # print("Address: %x" % val.cast("void*"))
        # print("Address: %s" % val.address)
        # gdb.parse_and_eval("free((void*)%x)" % val.address)


        # gdb.parse_and_eval("call free(
        # FIXME: leak
        print(as_string) 


DumpAttr()
end

