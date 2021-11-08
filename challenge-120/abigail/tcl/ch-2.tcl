#
# See ../README.md
#

#
# Run as: tclsh ch-2.tcl < input-file
#

set DIFF_PER_MINUTE   11
set MIN_PER_HOUR      60
set FULL_CIRCLE      720

while {[gets stdin line] >= 0} {
    set parts [split $line :]
    set hours   [expr 1[lindex $parts 0] - 100]
    set minutes [expr 1[lindex $parts 1] - 100]
    set angle   [expr (($DIFF_PER_MINUTE * \
                       ($hours * $MIN_PER_HOUR + $minutes))) % $FULL_CIRCLE]
    if {2 * $angle >= $FULL_CIRCLE} {
        set angle [expr $FULL_CIRCLE - $angle]
    }

    puts -nonewline [expr $angle / 2]
    if {$angle % 2 == 1} {
        puts -nonewline ".5"
    }
    puts ""
}
