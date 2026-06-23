#!/opt/homebrew/bin/tclsh

while {[gets stdin line] >= 0} {
    set numbers [string map {a 0 b 1 c 2 d 3 e 4 f 5 g 6 h 7 i 8 j 9} $line]
    set n1  [lindex $numbers 0]
    set n2  [lindex $numbers 1]
    set sum [lindex $numbers 2]
    if {$n1 + $n2 == $sum} {
        puts "true"
    } else {
        puts "false"
    }
}
