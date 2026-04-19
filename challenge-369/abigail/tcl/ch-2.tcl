#!/opt/homebrew/bin/tclsh

while {[gets stdin line] >= 0} {
    lassign $line str size filler

    #
    # Add the filler character (size - 1) times to str
    #
    append str [string repeat $filler [expr $size - 1]]

    #
    # Repeatedly take the first size characters from str and
    # add it to the out array. If str is non-empty at the end
    # of the loop, all it contsins is filler characters
    #
    set out {}
    while {[string length $str] >= $size} {
        lappend out [string range $str 0 [expr $size - 1]]
        set str [string range $str $size end]
    }

    #
    # Print it. 
    #
    puts $out
}
