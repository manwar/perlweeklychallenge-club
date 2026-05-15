#!/opt/homebrew/bin/tclsh

while {[gets stdin line] >= 0} {
    #
    # Remove all spaces and dots
    #
    regsub -all { }  $line {} line
    regsub -all {\.} $line {} line

    #
    # Split on ;
    #
    set parts [split $line {;}]

    #
    # Equal?
    #
    if {[lindex $parts 0] == [lindex $parts 1]} {
        puts "true"
    } else {
        puts "false"
    }
}
