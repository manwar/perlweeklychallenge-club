#!/opt/homebrew/bin/tclsh

while {[gets stdin line] >= 0} {
    set todo [list $line]
    while {[llength $todo] > 0} {
        set word [lpop todo 0]
        if {[regexp {\?} $word]} {
            lappend todo [regsub {\?} $word 0]
            lappend todo [regsub {\?} $word 1]
        } else {
            puts -nonewline "${word} "
        }
    }
    puts {}
}
