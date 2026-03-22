#!/opt/homebrew/bin/tclsh

set ord_a [scan "a" %c]

while {[gets stdin line] >= 0} {
    lassign [split $line " "] word count
    #
    # Calculate the first digit sum
    #
    set digit_sum 0
    for {set n 0} {$n < [string length $word]} {incr n} {
        set ch        [string index $word $n]
        set ord       [expr [scan $ch %c] - $ord_a + 1]
        set digit_sum [expr $digit_sum + ($ord % 10) + int ($ord / 10)]
    }

    #
    # Calculate any subsequent digit sums
    #
    for {set n 2} {$n <= $count} {incr n} {
        set ds 0
        while {$digit_sum > 0} {
            set ds        [expr $ds + ($digit_sum % 10)]
            set digit_sum [expr int   ($digit_sum / 10)]
        }
        set digit_sum $ds
    }

    puts $digit_sum
}
