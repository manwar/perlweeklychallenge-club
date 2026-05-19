#!/opt/homebrew/bin/tclsh

while {[gets stdin line] >= 0} {
    #
    # Remove quotes
    #
    regsub -all {"} $line {} line

    #
    # Get the number of spaces; we do this by comparing the length of
    # the string, with the length of the string with the spaces removed
    #
    set spaces [expr [string length $line] - \
                     [string length [regsub -all { } $line {}]]]

    #
    # Number of gaps between the words
    #
    set gaps [expr [llength $line] - 1]

    #
    # Calculate the number of spaces needed
    #
    set per_gap 0
    if {$gaps > 0} {
        set per_gap [expr $spaces / $gaps]
    }
    set end [expr $spaces - $gaps * $per_gap]

    #
    # Print the result
    #
    puts -nonewline  {"}
    puts -nonewline [join $line [string repeat { } $per_gap]]
    puts -nonewline             [string repeat { } $end]
    puts             {"}
}
