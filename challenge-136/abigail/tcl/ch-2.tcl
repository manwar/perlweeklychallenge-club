#
# See ../README.md
#

#
# Run as: tclsh ch-2.tcl < input-file
#

proc _count {target this_fib prev_fib} {
    if {$target <  $this_fib} {
        return 0
    }
    if {$target == $this_fib} {
        return 1
    }
    return [expr [_count [expr $target - $this_fib]                  \
                         [expr $this_fib + $prev_fib] $this_fib] +   \
                 [_count       $target                               \
                         [expr $this_fib + $prev_fib] $this_fib]]
}

proc count {target} {
    return [_count $target 1 1]
}

while {[gets stdin line] >= 0} {
    puts [count $line]
}
