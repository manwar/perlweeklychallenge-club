#!/opt/homebrew/bin/tclsh

while {[gets stdin list] >= 0} {
    set n    [lindex  $list 0]
    set list [lremove $list 0]

    #
    # Special case if n exceeds the size of the list
    #
    if {$n > [llength $list]} {
        puts "-1;"
        continue
    }

    #
    # Calculate the size of each set, and the number of
    # sets which get one more element
    #
    set per_set  [expr [llength $list] / $n]
    set overflow [expr [llength $list] - $n * $per_set]

    #
    # Print sets
    #
    set ptr 0
    for {set i 1} {$i <= $n} {incr i} {
        #
        # Calculate the size of the current set
        #
        set set_size $per_set
        if {$i <= $overflow} {
            incr set_size
        }
        #
        # Print current set one element at a time
        #
        for {set j 1} {$j <= $set_size} {incr j} {
            puts -nonewline [lindex $list $ptr]
            if {$j == $set_size} {
                puts -nonewline {; }
            } else {
                puts -nonewline { }
            }
            incr ptr
        }
    }
    puts {}
}
