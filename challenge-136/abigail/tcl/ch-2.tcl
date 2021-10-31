#
# See ../README.md
#

#
# Run as: tclsh ch-2.tcl < input-file
#

set cache [dict create]

proc _count {target this_fib prev_fib} {
    global cache
    if {![dict exists $cache $target $this_fib]} {
        if {$target <  $this_fib} {
            set result 0
        } elseif {$target == $this_fib} {
            set result 1
        } else {
            set result [expr [_count [expr $target   - $this_fib]              \
                                     [expr $this_fib + $prev_fib] $this_fib] + \
                             [_count       $target                             \
                                     [expr $this_fib + $prev_fib] $this_fib]]
        }
        dict set cache $target $this_fib $result
    }
    return [dict get $cache $target $this_fib]
}

proc count {target} {
    return [_count $target 1 1]
}

while {[gets stdin line] >= 0} {
    puts [count $line]
}
