#!/opt/homebrew/bin/tclsh

while {[gets stdin line] >= 0} {
    lassign $line line digit
    set n 0
    if {$digit != 9} {
        #
        # Remove the first occurrence of $digit that is followed by
        # a larger digit, if any
        #
        set ndigit [expr $digit + 1]
        set n [regsub $digit\(\[$ndigit-9\]\) $line {\1} nline]
    }
    if {$n == 0} {
        #
        # If we didn't find a $digit followed by a larger one, remove
        # the last occurrence of $digit
        #
        regsub \(.*\)$digit $line {\1} nline
    }
    puts $nline
}
