#
# See ../README.md
#

#
# Run as: tclsh ch-2.tcl
#

set BASE  10
set COUNT  5

proc is_long {number} {
    global BASE
    set seen []
    for {set i 0} {$i < $number} {incr i} {
        lset seen $i 0
    }
    set rest 0
    for {set i 2} {$i <= $number} {incr i} {
        set rest [expr ($rest * $BASE + $BASE - 1) % $number]
        if {[lindex $seen $rest] == 1} {
            return 0
        }
        lset seen $rest 1
    }
    return 1
}


set number 1

while {$COUNT > 0} {
    incr number
    if {$BASE % $number == 0} {
        continue
    }
    if {[is_long $number] == 1} {
        puts $number
        incr COUNT -1
    }
}
