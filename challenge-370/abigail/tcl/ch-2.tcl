#!/opt/homebrew/bin/tclsh

#
# Return true iff the two given strings are anagrams
#
# We'll sort the characters in the strings, then compare the strings
#
proc are_anagrams {str1 str2} {
    if {[join [lsort [split $str1 {}]] {}] eq
        [join [lsort [split $str2 {}]] {}]} {
        return 1
    }
    return 0
}


proc can_scramble {input target} {
    if {$input eq $target} {
        return 1
    }
    if {[string length $input] != [string length $target]} {
        return 0
    }
    if {![are_anagrams $input $target]} {
        return 0
    }
    for {set l 1} {$l < [string length $input]} {incr l} {
        set m [expr [string length $input] - $l]
        set i1 [string range $input  0 [expr $l - 1]]
        set i2 [string range $input  $l end]
        set t1 [string range $target 0 [expr $l - 1]]
        set t2 [string range $target $l end]
        set t3 [string range $target 0 [expr $m - 1]]
        set t4 [string range $target $m end]
        if {[can_scramble $i1 $t1] && [can_scramble $i2 $t2] ||
            [can_scramble $i1 $t4] && [can_scramble $i2 $t3]} {
            return 1
        }
    }
    return 0
}
            


while {[gets stdin line] >= 0} {
    lassign $line input target
    if {[can_scramble $input $target]} {
        puts true
    } else {
        puts false
    }
}
