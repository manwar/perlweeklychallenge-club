#!/opt/homebrew/bin/tclsh

set matrix [list]

while {[gets stdin line] >= 0} {
    lappend matrix $line
}

set N [llength $matrix]
set r 1

for {set i 0} {$i < $N} {incr i} {
    set row [dict create]
    set col [dict create]
    for {set j 0} {$j < $N} {incr j} {
        if {[lindex $matrix $i $j] < 1 || [lindex $matrix $i $j] > $N} {
            set r 0
        }
        dict set row [lindex $matrix $i $j] 1
        dict set col [lindex $matrix $j $i] 1
    }
    if {[dict size $row] != $N || [dict size $col] != $N} {
        set r 0
    }
}

if {$r == 1} {
    puts true
} else {
    puts false
}
