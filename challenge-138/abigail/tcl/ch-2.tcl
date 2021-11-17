#
# See ../README.md
#

#
# Run as: tclsh ch-2.tcl < input-file
#

proc can_split {target number} {
    if {$target > $number}  {return 0}
    if {$target <  0}       {return 0}
    if {$target == $number} {return 1}
    set pow_10 10
    while {$pow_10 < $number} {
        if {[can_split [expr $target - ($number % $pow_10)] \
                                  [expr $number / $pow_10]]} {return 1}
        set pow_10 [expr $pow_10 * 10]
    }
    return 0
}


while {[gets stdin number] >= 0} {
    set sqrt [expr isqrt ($number)]
    if {$number > 1} {
        if {[can_split $sqrt $number]} {
            puts 1
        } {
            puts 0
        }
    } {
        puts 0
    }
}
