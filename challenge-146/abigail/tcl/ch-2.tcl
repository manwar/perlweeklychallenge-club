#
# See ../README.md
#

#
# Run as: tclsh ch-2.tcl < input-file
#

while {[gets stdin line] >= 0} {
    lassign [split $line "/"] a b
    for {set i 1} {$i <= 2} {incr i} {
        if {$a < $b} {
            set b [expr $b - $a]
        } else {
            set a [expr $a - $b]
        }
        if {$a == 0 || $b == 0} {
            break
        }
        puts -nonewline "$a/$b "
    }
    puts ""
}
