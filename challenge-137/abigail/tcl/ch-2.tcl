#
# See ../README.md
#

#
# Run as: tclsh ch-2.tcl < input-file
#

proc reverse num {
    set rev 0
    while {$num > 0} {
        set rev [expr $rev * 10]
        set rev [expr $rev + [expr $num % 10]]
        set num [expr $num / 10]
    }
    return $rev
}

proc ly n {
    if {$n >= 10000000}     {return 1}
    if {$n == [reverse $n]} {return 0}
    return [ly [expr $n + [reverse $n]]]
}

while {[gets stdin num] >= 0} {
    puts [ly $num]
}
