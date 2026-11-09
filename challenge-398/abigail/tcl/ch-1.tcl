#!/opt/homebrew/bin/tclsh

while {[gets stdin numbers] >= 0} {
    set sum   0
    set count 0
    foreach number $numbers {
        if {[expr $number % 6 == 0]} {
            incr sum $number
            incr count
        }
    }

    set res 0
    if {$sum} {
        set res [expr round ("${sum}.0" / $count)]
    }
    puts $res
}
