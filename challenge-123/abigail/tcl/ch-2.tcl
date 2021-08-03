#
# See ../README.md
#

#
# Run as: tclsh ch-2.tcl < input-file
#

proc dist {x1 y1 x2 y2} {
    return [expr ($x1 - $x2) * ($x1 - $x2) + ($y1 - $y2) * ($y1 - $y2)]
}

while {[gets stdin line] >= 0} {
    lassign [split $line " "] x1 y1 x2 y2 x3 y3 x4 y4
    if {[dist $x1 $y1 $x2 $y2] == [dist $x2 $y2 $x3 $y3] &&
        [dist $x2 $y2 $x3 $y3] == [dist $x3 $y3 $x4 $y4] &&
        [dist $x3 $y3 $x4 $y4] == [dist $x4 $y4 $x1 $y1] &&
        [dist $x1 $y1 $x3 $y3] == [dist $x2 $y2 $x4 $y4]} {
        puts 1
    } else {
        puts 0
    }
}
