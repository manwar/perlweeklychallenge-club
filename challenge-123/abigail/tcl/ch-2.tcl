#
# See ../README.md
#

#
# Run as: tclsh ch-2.tcl < input-file
#

while {[gets stdin line] >= 0} {
    lassign [split $line " "] x1 y1 x2 y2 x3 y3 x4 y4
    set e1 [expr ($x1 - $x2) * ($x1 - $x2) + ($y1 - $y2) * ($y1 - $y2)]
    set e2 [expr ($x2 - $x3) * ($x2 - $x3) + ($y2 - $y3) * ($y2 - $y3)]
    set e3 [expr ($x3 - $x4) * ($x3 - $x4) + ($y3 - $y4) * ($y3 - $y4)]
    set e4 [expr ($x4 - $x1) * ($x4 - $x1) + ($y4 - $y1) * ($y4 - $y1)]
    set d1 [expr ($x1 - $x3) * ($x1 - $x3) + ($y1 - $y3) * ($y1 - $y3)]
    set d2 [expr ($x2 - $x4) * ($x2 - $x4) + ($y2 - $y4) * ($y2 - $y4)]
    if {$e1 == $e2 && $e2 == $e3 && $e3 == $e4 && $d1 == $d2} {
        puts 1
    } else {
        puts 0
    }
}
