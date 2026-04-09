#!/opt/homebrew/bin/tclsh

while {[gets stdin line] >= 0} {
    lassign $line number mode

    set diff_factors 0
    set factors      0

    #
    # Try dividing by all odd numbers -- but use 2 if the number is 1.
    # Count different and total factors.
    #
    # Note that this way, we will never divide by a composite number --
    # if we encounter a composite number, we have already tried its factors.
    #
    for {set d 1} {$d * $d <= $number} {incr d 2} {
        set n [expr $d == 1 ? 2 : $d]
        if {$number % $n == 0} {
            incr diff_factors
            while {$number % $n == 0} {
                incr factors
                set number [expr $number / $n]
            }
        }
    }

    #
    # At this point, $number is either 1 or a large prime, not encountered
    # before. In the later case, add one of the number of factors and unique
    # factors.
    #
    if {$number != 1} {
        incr diff_factors
        incr factors
    }

    if {$mode == 1} {
        puts $factors
    }
    if {$mode == 0} {
        puts $diff_factors
    }
}
