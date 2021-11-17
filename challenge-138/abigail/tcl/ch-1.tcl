#
# See ../README.md
#

#
# Run as: tclsh ch-1.tcl < input-file
#

set lookup [list [list 261 260 260 261 261 261 261]   \
                 [list 262 261 260 261 262 262 262]]

set SUNDAY    0
set MONDAY    1
set TUESDAY   2
set WEDNESDAY 3
set THURSDAY  4
set FRIDAY    5
set SATURDAY  6

set Anchors [list $TUESDAY $SUNDAY $FRIDAY $WEDNESDAY]

proc doomsday year {
    upvar 1 Anchors anchors
    set anchor [lindex $anchors [expr ($year / 100) % 4]]
    set y      [expr $year % 100]
    return [expr ((($y / 12) + ($y % 12) + (($y % 12) / 4)) + $anchor) % 7]
}

proc is_leap year {
    if {($year % 400 == 0) || ($year % 4 == 0) && ($year % 100 != 0)} {
        return 1
    }
    return 0
}

while {[gets stdin year] >= 0} {
    puts [lindex $lookup [is_leap $year] [doomsday $year]]
}
