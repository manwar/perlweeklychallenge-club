#
# See ../README.md
#

#
# Run as: tclsh ch-2.tcl < input-file
#

proc substrings {n m prefix max} {
    if {[string length $n] == 0} {
        if {$prefix > -1 && $prefix < $max && $prefix % $m == 0} {
            return 1
        } else {
            return 0
        }
    }

    set fc   [string range $n 0 0]
    set tail [string range $n 1 [string length $n]]

    if {$prefix == -1} {
        set n_prefix $fc
    } else {
        set n_prefix [expr 10 * $prefix + $fc]
    }

    return [expr [substrings $tail $m $n_prefix $max] + \
                 [substrings $tail $m   $prefix $max]]
}


while {[gets stdin line] >= 0} {
    lassign [split $line " "] n m
    puts [substrings $n $m -1 $n]
}
