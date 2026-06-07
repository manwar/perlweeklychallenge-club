#!/opt/homebrew/bin/tclsh

while {[gets stdin line] >= 0} {
    #
    # Parse input
    #
    if {[regexp {^([a-h])([1-8]) ([a-h])([1-8])$} $line _ f1 r1 f2 r2]} {
        #
        # Set parities of each field
        #
        set p1 [expr ([scan $f1 %c] % 2) == ([scan $r1 %c] % 2)]
        set p2 [expr ([scan $f2 %c] % 2) == ([scan $r2 %c] % 2)]

        #
        # Compare parities
        #
        if {$p1 && $p2 || !$p1 && !$p2} {
            puts "true"
        } else {
            puts "false"
        }
    }
}
