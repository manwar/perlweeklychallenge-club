#!/opt/homebrew/bin/tclsh

while {[gets stdin line] >= 0} {
    #
    # Store the character value of the letters in letters
    #
    set letters [lmap ch $line {scan $ch %c}]

    #
    # Find the position of the question mark
    #
    for {set i 0} {$i < 5} {incr i} {
        if {[lindex $letters $i] == [scan ? %c]} {
            set qi $i
            break
        }
    }

    #
    # Find the values we need to calculate the missing character
    #
    set base [lindex $letters [expr $qi <= 2 ? $qi + 1 : $qi - 1]]
    set from [lindex $letters [expr $qi <  2 ? $qi + 3 : \
                                    $qi == 2 ? $qi - 1 : $qi - 3]]
    set to   [lindex $letters [expr $qi <  2 ? $qi + 2 : $qi - 2]]

    #
    # Calculate the missing character and print it
    #
    puts [format %c [expr $base - $from + $to]]
}
