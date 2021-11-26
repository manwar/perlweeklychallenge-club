#
# See ../README.md
#

#
# Run as: tclsh ch-1.tcl < input-file
#

proc bin2dec bin {
    set dec 0
    foreach c [split $bin {}] {
        set dec [expr 2 * $dec + $c]
    }
    return $dec
}

proc dec2bin dec {
    set bin {}
    while {$dec > 0} {
        set bin [expr {$dec % 2}]$bin
        set dec [expr {$dec / 2}]
    }
    return $bin
}

while {[gets stdin line] >= 0} {
    lassign [split $line " "] a b
    puts [dec2bin [expr [bin2dec $a] + [bin2dec $b]]]
}
